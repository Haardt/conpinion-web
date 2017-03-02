package de.conpinion.web.flux;


import java.util.function.Consumer;
import java.util.function.Function;

@FunctionalInterface
public interface Middleware<STATE, ACTION> {
	Function<STATE, Consumer<Process<ACTION>>> process(ACTION action);
}
