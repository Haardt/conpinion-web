package de.conpinion.web.web;

import com.github.aesteve.vertx.nubes.annotations.Controller;
import com.github.aesteve.vertx.nubes.annotations.params.RequestBody;
import com.github.aesteve.vertx.nubes.annotations.routing.http.GET;
import com.github.aesteve.vertx.nubes.annotations.routing.http.POST;

import de.conpinion.web.order.actions.NewOrderAction;

import io.vertx.core.eventbus.EventBus;
import io.vertx.ext.web.RoutingContext;
import lombok.extern.slf4j.Slf4j;

@Controller("/orders")
//@ContentType("application/text")
@Slf4j
public class OrderController {

	@GET
	public String getOrders(EventBus eventBus) {
		log.info("{}", eventBus);
		eventBus.send("order.new", "order");
		return "order";
	}

	@POST("/:id")
	public String newOrder(EventBus eventBus, RoutingContext context, @RequestBody NewOrderAction newOrderAction) {

		return "OK";
	}
}
