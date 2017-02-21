package de.conpinion.web.web;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Future;
import io.vertx.core.http.HttpServer;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.handler.BodyHandler;
import io.vertx.ext.web.handler.StaticHandler;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebServerVerticle extends AbstractVerticle
{
	@Override
	public void start(Future<Void> startFuture) throws Exception
	{
//		log.info("Starting static web server...");
//
//		System.out.println("Working Directory = " +
//				System.getProperty("user.dir"));
//
//		HttpServer server = vertx.createHttpServer();
//		Router router = Router.router(vertx);
//
//		server.requestHandler(router::accept);
//
//		server.listen(8081, res -> {
//			if (res.succeeded())
//			{
//				log.info ("Web-Server ready...blub");
//			}
//			else
//			{
//				log.error("Can't bind Web-Server...{}", res.cause());
//			}
//		});
//
//		router.route("/public/*").handler(
//				StaticHandler.create()
//							 .setCachingEnabled(false)
//
//							 .setDirectoryListing(true)
//							 .setWebRoot("../web/public"));
//
//

		startFuture.complete(null);

	}
}
