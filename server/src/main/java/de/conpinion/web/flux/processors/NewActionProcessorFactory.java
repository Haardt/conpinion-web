package de.conpinion.web.flux.processors;

import com.github.aesteve.vertx.nubes.handlers.AnnotationProcessor;
import com.github.aesteve.vertx.nubes.reflections.factories.AnnotationProcessorFactory;

import de.conpinion.web.flux.FluxService;
import de.conpinion.web.flux.annotations.NewAction;

/**
 * Created by haardt on 07.03.17.
 */
public class NewActionProcessorFactory implements AnnotationProcessorFactory<NewAction> {

	private FluxService fluxService;

	public NewActionProcessorFactory(FluxService fluxService) {
		this.fluxService = fluxService;
	}

	@Override
	public AnnotationProcessor<NewAction> create(NewAction annotation) {
		return new NewActionProcessor(fluxService);
	}
}
