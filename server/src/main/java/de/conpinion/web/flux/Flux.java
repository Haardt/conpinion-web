package de.conpinion.web.flux;

import com.google.common.collect.Multimap;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Properties;
import java.util.function.BiConsumer;
import java.util.function.BiFunction;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.stream.Collectors;

import static com.google.common.collect.Maps.immutableEntry;
import static java.util.stream.Collectors.*;


public class Flux<STATE, ACTION extends Action> {

	private Map<String, List<BiFunction<STATE, ACTION, STATE>>> reducers;
	private List<BiConsumer<STATE, STATE>> subscriptions;
	private Process<ACTION> processMiddleware = action -> processAction(action);
	private STATE state;
	private Function<STATE, STATE> cloneFunction;
	private boolean subscriberEnabled = true;

	public Flux(STATE initialState, Function<STATE, STATE> cloneFunction) {
		this.state = initialState;
		this.cloneFunction = cloneFunction;
	}

	public void addMiddleware(Middleware<STATE, ACTION> nextMiddleware) {
		Process<ACTION> prevMiddleware = this.processMiddleware;
		this.processMiddleware = (action) ->
			nextMiddleware.process(action, state, (nextAction) -> {
				if (action == nextAction) {
					prevMiddleware.process(nextAction);
				} else {
					dispatch(nextAction);
				}
			});
	}

	public void addReducers(Map.Entry<String, BiFunction<STATE, ACTION, STATE>>... reducers) {
		this.reducers = Arrays.asList(reducers)
			.stream().collect(groupingBy(Map.Entry::getKey,	mapping(Map.Entry::getValue, toList())));
	}

	public void addSubscribers(BiConsumer<STATE, STATE>... subscriber) {
		this.subscriptions = Arrays.asList(subscriber);
	}

	public void dispatch(ACTION action) {
		processMiddleware.process(action);
	}

	private void processAction(ACTION action) {
		STATE oldState = cloneFunction.apply(state);
		reducers.get(action.type()).stream().forEach( reducer -> state = reducer.apply(state, action));
		if (subscriberEnabled) {
			subscriptions.forEach(subscriber -> subscriber.accept(oldState, state));
		}
	}

	public void disableSubscriber() {
		this.subscriberEnabled = false;
	}

	public void enableSubscriber() {
		this.subscriberEnabled = true;
	}

	public boolean subscriberEnabled() {
		return subscriberEnabled;
	}
}
