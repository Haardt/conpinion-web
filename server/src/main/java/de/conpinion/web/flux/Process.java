package de.conpinion.web.flux;


import java.util.function.Consumer;
import java.util.function.Function;

@FunctionalInterface
public interface Process<ACTION> {
	void process(ACTION action);
}
