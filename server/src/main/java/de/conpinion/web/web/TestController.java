package de.conpinion.web.web;

import com.github.aesteve.vertx.nubes.annotations.Controller;
import com.github.aesteve.vertx.nubes.annotations.mixins.ContentType;
import com.github.aesteve.vertx.nubes.annotations.params.Param;
import com.github.aesteve.vertx.nubes.annotations.routing.http.GET;

import lombok.extern.slf4j.Slf4j;

/**
 * Created by haardt on 21.02.17.
 */
@Controller("/test")
//@ContentType("application/text")
@Slf4j
public class TestController {

	@GET("/all")
	public String getAll(@Param("bla") String bla) {
		String id = bla;

		//log.info("Id: {}", id);
		return "hallo" + id;
	}
}
