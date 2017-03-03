package de.conpinion.web.order;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Future;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PaymentVerticle extends AbstractVerticle
{
	@Override
	public void start(Future<Void> startFuture) throws Exception
	{
		log.info("Payment verticle started...");

		vertx.eventBus().consumer("creditCard.validation", message -> {
			log.info("credit card validation request");
			message.reply("OK");
		});

		startFuture.complete(null);
	}
}
