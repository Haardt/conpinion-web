package de.conpinion.web.order;

import de.conpinion.web.flux.Action;
import de.conpinion.web.flux.Flux;
import de.conpinion.web.flux.Middleware;
import de.conpinion.web.order.actions.NewOrderAction;
import de.conpinion.web.order.actions.PaymentAction;
import de.conpinion.web.order.actions.WarehouseAction;

import java.util.Properties;
import java.util.function.BiConsumer;
import java.util.function.BiFunction;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.AsyncResult;
import io.vertx.core.Future;
import io.vertx.core.eventbus.Message;
import lombok.extern.slf4j.Slf4j;

import static com.google.common.base.MoreObjects.firstNonNull;
import static com.google.common.collect.Maps.immutableEntry;

@Slf4j
public class OrderVerticle extends AbstractVerticle {
	@Override
	public void start(Future<Void> startFuture) throws Exception {
		log.info("Order verticle started...");
		vertx.eventBus().consumer("order.new", message -> {
			
			Flux<Properties, Action> flux = new Flux<>(new Properties(), (Properties state) -> (Properties) state.clone());
			flux.addMiddleware(loggingMiddleware());
			flux.addMiddleware(orderMiddleware());

			flux.addReducers(
				immutableEntry(PaymentAction.TYPE, paymentReducer),
				immutableEntry(WarehouseAction.TYPE, warehouseReducer),

				immutableEntry(PaymentAction.TYPE, deliveryReducer),
				immutableEntry(WarehouseAction.TYPE, deliveryReducer)
			);

			flux.addSubscribers(
				deliverySubscriber,
				errorSubscriber
				);

			log.info("new order received...");

			flux.dispatch(NewOrderAction.newOrder("2343-4445-666-8888", 2));
		});

		startFuture.complete(null);
	}

	private Middleware<Properties, Action> loggingMiddleware() {
		return (action, state, next) -> {
			log.info("ACTION: " + action.toString());
			next.process(action);
		};
	}

	private Middleware<Properties, Action> orderMiddleware() {
		return (action, state, next) -> {
			if (action.type().equals(NewOrderAction.TYPE)) {
				vertx.eventBus().send("creditCard.process", ((NewOrderAction) action).getCreditCardNumber(),
					(AsyncResult<Message<Boolean>> reply) -> {
						if (reply.result().body()) {
							next.process(PaymentAction.ok());
						} else {
							next.process(PaymentAction.error());
						}
					});
				vertx.eventBus().send("warehouse.process", ((NewOrderAction) action).getItems(),
					(AsyncResult<Message<Boolean>> reply) -> {
						if (reply.result().body()) {
							next.process(WarehouseAction.ok());
						} else {
							next.process(WarehouseAction.error());
						}
					});
				return;
			}
			next.process(action);
		};
	}

	BiFunction<Properties, Action, Properties> paymentReducer = (state, action) -> {
		log.info("payment reducer");
		boolean paymentValid = ((PaymentAction) action).isPaymentValid();
		state.put("payment.valid", paymentValid);
		if (!paymentValid)
			state.put("payment.error", "insufficient funds...");
		return state;
	};

	BiFunction<Properties, Action, Properties> warehouseReducer = (state, action) -> {
		log.info("warehouse reducer");
		boolean warehouseValid = ((WarehouseAction) action).isWarehouseValid();
		state.put("warehouse.valid", warehouseValid);
		if (!warehouseValid)
			state.put("warehouse.error", "not available...");
		return state;
	};

	BiFunction<Properties, Action, Properties> deliveryReducer = (state, action) -> {
		boolean newPaymentStatus = firstNonNull((Boolean) state.get("payment.valid"), false);
		boolean newWarehouseStatus = firstNonNull((Boolean) state.get("warehouse.valid"), false);
		log.info("Delivery reducer status: P: {} / W: {}", newPaymentStatus, newWarehouseStatus);
		state.put("delivery.start", newPaymentStatus && newWarehouseStatus);
		return state;
	};

	//Idempotent
	BiConsumer<Properties, Properties> deliverySubscriber = (oldState, currentState) -> {
		boolean oldDeliveryStatus = firstNonNull((Boolean) oldState.get("delivery.start"), false);
		boolean newDeliveryStatus = firstNonNull((Boolean) currentState.get("delivery.start"), false);
		log.info("Delivery status: O: {} / C: {}", oldDeliveryStatus, newDeliveryStatus);
		if ((oldDeliveryStatus != newDeliveryStatus) && newDeliveryStatus) {
			log.error("Start delivery...");
		}
	};

	BiConsumer<Properties, Properties> errorSubscriber = (oldState, currentState) -> {
		boolean paymentError = currentState.containsKey("payment.error");
		if (paymentError) {
			log.error("Order error: {}", currentState.getProperty("payment.error"));
		}
		boolean warehouseError = currentState.containsKey("warehouse.error");
		if (warehouseError) {
			log.error("Order error: {}", currentState.getProperty("warehouse.error"));
		}
		log.info("Error status: P: {} / W: {}", paymentError, warehouseError);
	};
}
