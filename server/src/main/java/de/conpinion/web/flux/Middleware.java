package de.conpinion.web.flux;


import java.util.function.Consumer;
import java.util.function.Function;

@FunctionalInterface
public interface Middleware<STATE, ACTION> {
	void process(ACTION action, STATE state, Process<ACTION> nextAction);
}
