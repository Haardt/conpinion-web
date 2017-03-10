package de.conpinion.web.flux;

import com.github.aesteve.vertx.nubes.VertxNubes;

import de.conpinion.web.flux.annotations.NewAction;
import de.conpinion.web.flux.processors.NewActionProcessorFactory;

import io.vertx.core.AsyncResult;
import io.vertx.core.Handler;
import io.vertx.core.Vertx;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.web.Router;

/**
 * Created by haardt on 07.03.17.
 */
public class FluxNubes extends VertxNubes {

		public static final String SERVICE_NAME = "flux";

		private final FluxService flux;

		public FluxNubes(Vertx vertx, JsonObject config) {
			super(vertx, config);
			flux = new FluxService();
			registerService(SERVICE_NAME, flux);
		}

		@Override
		public void bootstrap(Handler<AsyncResult<Router>> handler) {
			registerAnnotationProcessor(NewAction.class, new NewActionProcessorFactory(flux));
			super.bootstrap(handler);

		}
}
