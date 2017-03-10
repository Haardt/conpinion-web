package de.conpinion.web.web;

import com.github.aesteve.vertx.nubes.annotations.Controller;
import com.github.aesteve.vertx.nubes.annotations.mixins.ContentType;
import com.github.aesteve.vertx.nubes.annotations.params.RequestBody;
import com.github.aesteve.vertx.nubes.annotations.routing.http.GET;
import com.github.aesteve.vertx.nubes.annotations.routing.http.POST;
import com.github.aesteve.vertx.nubes.annotations.services.Service;
import com.github.aesteve.vertx.nubes.context.PaginationContext;

import de.conpinion.web.flux.Action;
import de.conpinion.web.flux.FluxNubes;
import de.conpinion.web.flux.FluxService;
import de.conpinion.web.flux.annotations.NewAction;
import de.conpinion.web.order.actions.NewOrderAction;

import io.vertx.core.eventbus.EventBus;
import io.vertx.core.http.HttpServerResponse;
import io.vertx.ext.web.RoutingContext;
import lombok.extern.slf4j.Slf4j;

@Controller("/users")
@ContentType("application/json")
@Slf4j
public class OrderController {

	@Service(FluxNubes.SERVICE_NAME)
	private FluxService fluxService;

	@GET
	@NewAction
	public Action getUsers(PaginationContext context) {
		log.info("OrderController");
		return ()-> "type";
	}

	@GET("/:id")
	public String getUser(Integer id) {
		log.info("OrderController");
		return "{\"firstName\": \"bob\", \"lastName\":\"Baumeister\"}";
	}

	@POST("/:id")
	public String newOrder(EventBus eventBus, RoutingContext context, @RequestBody NewOrderAction newOrderAction) {

		return "OK";
	}
}
