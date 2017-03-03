package de.conpinion.web.order;

import de.conpinion.web.flux.Action;
import de.conpinion.web.flux.Flux;
import de.conpinion.web.flux.Middleware;
import de.conpinion.web.flux.Process;

import java.util.Properties;
import java.util.function.BiFunction;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Future;
import lombok.extern.slf4j.Slf4j;

import com.google.common.collect.Maps;

import static com.google.common.collect.Maps.*;

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
				immutableEntry("payment", paymentReducer),
				immutableEntry("warehouse", warehouseReducer),
				immutableEntry("payment", deliveryReducer),
				immutableEntry("warehouse", deliveryReducer)
			);

			flux.addSubscribers((oldState, currentState) -> {
				boolean oldDeliveryStatus = Boolean.valueOf(oldState.getProperty("delivery.status", "false"));
				boolean newDeliveryStatus = Boolean.valueOf(currentState.getProperty("delivery.status", "false"));
				log.info("Delivery status: O: {} / C: {}", oldDeliveryStatus, newDeliveryStatus);
				if ((oldDeliveryStatus != newDeliveryStatus) && newDeliveryStatus) {
					log.error("Start delivery...");
				}
			});


			log.info("new order received...");

			flux.dispatch(OrderAction.newOrder());
		});

		startFuture.complete(null);
	}

	private Middleware<Properties, Action> loggingMiddleware() {
		return (action, state, next) -> {
			log.info("Action: " + action.toString());
			next.process(action);
		};
	}

	private Middleware<Properties, Action> orderMiddleware() {
		return (action, state, next) -> {
			if (action.type().equals("order")) {
				vertx.eventBus().send("creditCard.validation", "123", reply -> {
					if (reply.result().body().equals("OK")) {
						next.process(PaymentAction.ok());
					} else {
						next.process(PaymentAction.error());
					}
				});
				vertx.eventBus().send("warehouse.validation", "10", reply -> {
					if (reply.result().body().equals("OK")) {
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

	private BiFunction<Properties, Action, Properties> paymentReducer = (state, action) -> {
		log.info("payment reducer");
		state.setProperty("payment.status", ((PaymentAction) action).isPaymentValid() ? "true" : "false");
		return state;
	};

	public BiFunction<Properties, Action, Properties> warehouseReducer = (state, action) -> {
		log.info("warehouse reducer");
		state.setProperty("warehouse.status", ((WarehouseAction) action).isWarehouseValid() ? "true" : "false");
		return state;
	};

	public BiFunction<Properties, Action, Properties> deliveryReducer = (state, action) -> {
		boolean newPaymentStatus = Boolean.valueOf(state.getProperty("payment.status", "false"));
		boolean newWarehouseStatus = Boolean.valueOf(state.getProperty("warehouse.status", "false"));
		log.info("Delivery reducer status: P: {} / W: {}", newPaymentStatus, newWarehouseStatus);
		state.setProperty("delivery.status", (newPaymentStatus && newWarehouseStatus) ? "true" : "false");
		return state;
	};
}
