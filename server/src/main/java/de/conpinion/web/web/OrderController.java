package de.conpinion.web.web;

import com.github.aesteve.vertx.nubes.annotations.Controller;
import com.github.aesteve.vertx.nubes.annotations.mixins.ContentType;
import com.github.aesteve.vertx.nubes.annotations.params.Param;
import com.github.aesteve.vertx.nubes.annotations.params.RequestBody;
import com.github.aesteve.vertx.nubes.annotations.routing.http.GET;
import com.github.aesteve.vertx.nubes.annotations.routing.http.POST;
import com.github.aesteve.vertx.nubes.annotations.routing.http.PUT;
import com.github.aesteve.vertx.nubes.annotations.services.Service;
import com.github.aesteve.vertx.nubes.context.PaginationContext;

import de.conpinion.web.flux.Action;
import de.conpinion.web.flux.FluxNubes;
import de.conpinion.web.flux.FluxService;
import de.conpinion.web.flux.annotations.NewAction;
import de.conpinion.web.order.actions.NewOrderAction;

import java.util.function.Consumer;
import java.util.function.Function;

import io.netty.handler.codec.http.HttpResponseStatus;
import io.netty.handler.codec.http.HttpStatusClass;
import io.vertx.core.eventbus.EventBus;
import io.vertx.core.http.HttpServerResponse;
import io.vertx.core.json.JsonArray;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.web.RoutingContext;
import lombok.extern.slf4j.Slf4j;

@Controller("/users/")
@ContentType("application/json")
@Slf4j
public class OrderController {

	@Service(FluxNubes.SERVICE_NAME)
	private FluxService fluxService;

	@GET
	public JsonArray getUsers(PaginationContext context) {
		log.info("UserController");
		return new JsonArray()
			.add(new JsonObject ().put("id", 1).put("firstName", "Alice").put("lastName", "Wunderland"))
			.add(new JsonObject ().put("id", 2).put("firstName", "Bob").put("lastName", "Baumeister"));
	}

	@GET(":requestId")
	public void getUser(RoutingContext context, @Param("requestId") String requestId) {
		int id = Integer.parseInt(requestId);
		log.info("UserController-Get: {}", id);
		if (id == 1) {
			context.response().end(new JsonObject ().put("id", 1).put("firstName", "Alice").put("lastName", "Wunderland").toString());
		}
		if (id == 2) {
			context.vertx().setTimer(2000, t -> {
				context.response().end(new JsonObject ().put("id", 2).put("firstName", "Bob").put("lastName", "Baumeister").toString());
			});
		}
	}

	@PUT(":id")
	public void newUser(RoutingContext context, @RequestBody JsonObject newUser) {
		log.info("Put request: {}", newUser);
//		context.response().end("{\"status\": \"OK\"}");
		context.response().setStatusCode(HttpResponseStatus.BAD_REQUEST.code());
		context.response().end(
			new JsonObject().put("validation",
			new JsonObject("{\"firstName\": \"unknown name\",\"lastName\": \"too short\"}")).encode());
	}
}
