package de.conpinion.web.flux.processors;

import com.github.aesteve.vertx.nubes.context.PaginationContext;
import com.github.aesteve.vertx.nubes.handlers.AnnotationProcessor;
import com.github.aesteve.vertx.nubes.handlers.impl.ContentTypeProcessor;
import com.github.aesteve.vertx.nubes.handlers.impl.NoopAfterAllProcessor;
import com.github.aesteve.vertx.nubes.marshallers.Payload;

import de.conpinion.web.flux.Action;
import de.conpinion.web.flux.FluxService;
import de.conpinion.web.flux.annotations.NewAction;

import io.vertx.ext.web.RoutingContext;
import lombok.extern.slf4j.Slf4j;

/**
 * Created by haardt on 07.03.17.
 */
@Slf4j
public class NewActionProcessor implements AnnotationProcessor<NewAction> {

	private final FluxService fluxService;

	public NewActionProcessor(FluxService fluxService) {
		this.fluxService = fluxService;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public void postHandle(RoutingContext context) {
		log.info("Processor....postHandle");
		PaginationContext payload = context.get(PaginationContext.DATA_ATTR);
		Payload<String> newPayload = new Payload<>();
		context.put(ContentTypeProcessor.BEST_CONTENT_TYPE, "application/json");
		newPayload.set("[{\"id\":123, \"firstName\":\"Max\", \"lastName\":\"Mustermann\"}, {\"id\":124, \"firstName\":\"Alice\", \"lastName\":\"Mustermann\"}]");
		context.put(Payload.DATA_ATTR, newPayload);
		context.next();
	}

	@Override
	public void afterAll(RoutingContext context) {
		log.info("afterAll...");
		context.next();
	}


	@Override
	public void preHandle(RoutingContext context) {
		log.info("preHandle...");
		context.next();
	}
}
