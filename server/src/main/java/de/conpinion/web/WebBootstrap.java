package de.conpinion.web;

import com.github.aesteve.vertx.nubes.NubesServer;
import com.github.aesteve.vertx.nubes.VertxNubes;

import de.conpinion.web.web.WebServerVerticle;

import java.util.Locale;
import java.util.concurrent.TimeUnit;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.DeploymentOptions;
import io.vertx.core.Future;
import io.vertx.core.Vertx;
import io.vertx.core.http.HttpServer;
import io.vertx.core.http.HttpServerOptions;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.web.Router;
import lombok.extern.slf4j.Slf4j;
import static com.github.aesteve.vertx.nubes.utils.async.AsyncUtils.onSuccessOnly;

@Slf4j
public class WebBootstrap extends AbstractVerticle {

    protected final static int NB_INSTANCES = 4; // to make sure it works well in a multiple-instance environment
    protected final static String HOST = "localhost";
    protected final static int PORT = 8089;

    public static void main(String[] args) {

        Vertx vertx = Vertx.vertx();

        DeploymentOptions webServerOptions = new DeploymentOptions();
        vertx.deployVerticle(WebBootstrap.class.getName(), webServerOptions);

    }

    @Override
    public void start(Future<Void> startFuture) throws Exception {
        log.info("web-comfort starting...{}");

        HttpServerOptions options = new HttpServerOptions();
        options.setPort(PORT);
        options.setHost(HOST);
        HttpServer server = vertx.createHttpServer(options);

        VertxNubes nubes = new VertxNubes(vertx, new JsonObject("{\"controller-packages\":[\"de.conpinion.web.web\"]}"));


       // nubes.setDefaultLocale(Locale.GERMAN);

        nubes.bootstrap(onSuccessOnly(startFuture, router -> {
            server.requestHandler(router::accept);
            server.listen(res -> {
                if (res.failed()) {
                    startFuture.fail(res.cause());
                    return;
                }
                startFuture.complete();
            });
        }));

        DeploymentOptions webServerOptions = new DeploymentOptions();
        vertx.deployVerticle(WebServerVerticle.class.getName(), webServerOptions);
    }

    private static JsonObject createConfig() {
        JsonObject config = new JsonObject();
        config.put("host", HOST);
        config.put("port", PORT);
        return config;
    }
}
