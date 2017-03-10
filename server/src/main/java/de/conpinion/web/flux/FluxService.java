package de.conpinion.web.flux;

import com.github.aesteve.vertx.nubes.services.Service;

import java.lang.annotation.Annotation;

import io.vertx.core.Future;
import io.vertx.core.Vertx;
import io.vertx.core.json.JsonObject;
import lombok.extern.slf4j.Slf4j;

/**
 * Created by haardt on 07.03.17.
 */
@Slf4j
public class FluxService implements Service {

	@Override
	public void init(Vertx vertx, JsonObject config) {
		log.info("FluxService started...");
	}

	@Override
	public void start(Future<Void> future) {
		future.complete();
	}

	@Override
	public void stop(Future<Void> future) {
		future.complete();
	}
}
