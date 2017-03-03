package de.conpinion.web.order;

import java.util.Random;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Future;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PaymentVerticle extends AbstractVerticle
{
	private boolean toggle = false;

	@Override
	public void start(Future<Void> startFuture) throws Exception
	{
		log.info("Payment verticle started...");

		vertx.eventBus().consumer("creditCard.process", message -> {
			log.info("credit card validation request");
			vertx.setTimer(5000, (dummy) ->{
				toggle = ! toggle;
				message.reply(toggle);
			});
		});

		startFuture.complete(null);
	}
}
