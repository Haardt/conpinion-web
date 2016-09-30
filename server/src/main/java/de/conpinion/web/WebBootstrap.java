package de.conpinion.web;

import de.conpinion.web.web.WebServerVerticle;
import io.vertx.core.AbstractVerticle;
import io.vertx.core.DeploymentOptions;
import io.vertx.core.Future;
import io.vertx.core.Vertx;
import java.util.function.BiFunction;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebBootstrap extends AbstractVerticle {
    
    public BiFunction<Integer, Integer, Integer> add = (x,y) -> x + y;
    public BiFunction<Integer, Integer, Integer> add5 = add.andThen(x -> x * 5);
    
    

    public static void main(String[] args) {

        Vertx vertx = Vertx.vertx();

        DeploymentOptions webServerOptions = new DeploymentOptions();
        vertx.deployVerticle(WebServerVerticle.class.getName(), webServerOptions);
    }

    @Override
    public void start(Future<Void> startFuture) throws Exception {
        Integer apply = new WebBootstrap().add5.apply(2, 5);
        log.info("web-comfort starting...{}", apply);

        DeploymentOptions webServerOptions = new DeploymentOptions();
        vertx.deployVerticle(WebServerVerticle.class.getName(), webServerOptions);
    }
}
