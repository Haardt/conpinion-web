package de.conpinion.web;

import com.github.aesteve.vertx.nubes.VertxNubes;

import de.conpinion.web.flux.FluxNubes;
import de.conpinion.web.order.OrderVerticle;
import de.conpinion.web.order.PaymentVerticle;
import de.conpinion.web.order.WarehouseVerticle;
import de.conpinion.web.web.WebServerVerticle;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.AsyncResult;
import io.vertx.core.DeploymentOptions;
import io.vertx.core.Future;
import io.vertx.core.Vertx;
import io.vertx.core.http.HttpServer;
import io.vertx.core.http.HttpServerOptions;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.handler.StaticHandler;
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
        //log.info("web-comfort starting...{}");

        HttpServerOptions options = new HttpServerOptions();
        options.setPort(PORT);
        options.setHost(HOST);
        HttpServer server = vertx.createHttpServer(options);

        VertxNubes nubes = new FluxNubes(vertx, new JsonObject("{\n" +
            "  \"src-package\": \n" +
            "    \"de.conpinion.web\"\n" +
            "  ,\n" +
            "  \"controller-packages\": \n[" +
            "    \"de.conpinion.web.web\"]\n" +
            "  ,\n" +
            "  \"webroot\": \"./../web/public/app\",\n" +
            "  \"static-path\": \"/app\"\n" +
            "}"));


       // nubes.setDefaultLocale(Locale.GERMAN);

        nubes.bootstrap(onSuccessOnly(startFuture, router -> {
            router.route("/public/*").handler(
                    StaticHandler.create()
                                 .setCachingEnabled(false)

                                 .setDirectoryListing(true)
                                 .setWebRoot("../web/public"));

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

        vertx.deployVerticle(new OrderVerticle(), webServerOptions);
        vertx.deployVerticle(new WarehouseVerticle(), webServerOptions);
        vertx.deployVerticle(new PaymentVerticle(), webServerOptions);
    }

    private static JsonObject createConfig() {
        JsonObject config = new JsonObject();
        config.put("host", HOST);
        config.put("port", PORT);
        return config;
    }
}
