package de.conpinion.web.order;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Future;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WarehouseVerticle extends AbstractVerticle
{
	@Override
	public void start(Future<Void> startFuture) throws Exception
	{
		log.info("Warehouse verticle started...");

		vertx.eventBus().consumer("warehouse.validation", message -> {
			log.info("warehouse validation request");
			message.reply("OK");
		});

		startFuture.complete(null);
	}
}
