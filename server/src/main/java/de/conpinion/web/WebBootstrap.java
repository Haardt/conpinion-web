package de.conpinion.web;

import de.conpinion.web.web.WebServerVerticle;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.DeploymentOptions;
import io.vertx.core.Future;
import io.vertx.core.Vertx;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebBootstrap extends AbstractVerticle {
    
    public static void main(String[] args) {

        Vertx vertx = Vertx.vertx();

        DeploymentOptions webServerOptions = new DeploymentOptions();
        vertx.deployVerticle(WebServerVerticle.class.getName(), webServerOptions);
    }

    @Override
    public void start(Future<Void> startFuture) throws Exception {
        log.info("web-comfort starting...{}");

        DeploymentOptions webServerOptions = new DeploymentOptions();
        vertx.deployVerticle(WebServerVerticle.class.getName(), webServerOptions);
    }
}
