package de.conpinion.web.flux;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.stream.Collectors;

import static com.google.common.collect.Maps.immutableEntry;


public class Flux<STATE, ACTION extends Action> {

	private Map<String, BiFunction<STATE, ACTION, STATE>> reducers;
	private List<Consumer<STATE>> subscriptions;
	private Function<ACTION, ACTION> middleware = Function.identity();
	private STATE state;

	public Flux(STATE initialState) {
		this.state = initialState;
	}

	public void addMiddleware(Function<ACTION, ACTION> nextMiddleware) {
		Function<ACTION, ACTION> prevMiddleware = this.middleware;
		this.middleware = (action) -> prevMiddleware.apply(nextMiddleware.apply(action));
	}

	private void dispatch(ACTION action) {
		processAction(middleware.apply(action));
	}

	private void addReducers(Map.Entry<String, BiFunction<STATE, ACTION, STATE>>... reducers) {
		this.reducers = Arrays.asList(reducers).stream().collect(Collectors.toMap(
			Map.Entry::getKey, Map.Entry::getValue));
	}

	private void addSubscribers(Consumer<STATE>... subscriber) {
		this.subscriptions = new ArrayList<>(Arrays.asList(subscriber));
	}

	private void processAction(ACTION action) {
		state = reducers.get(action.type()).apply(state, action);
		subscriptions.forEach((subscriber) -> subscriber.accept(state));
	}



	public BiFunction<Integer, CalcAction, Integer> addReducer = (state, action) -> state + action.getDigit();
	public BiFunction<Integer, CalcAction, Integer> subReducer = (state, action) -> state - action.getDigit();
	public BiFunction<Integer, CalcAction, Integer> mulReducer = (state, action) -> state * action.getDigit();

	public static void main(String[] args) {
		Flux<Integer, CalcAction> flux = new Flux<>(1);

		flux.addMiddleware((ACTION) -> {
			System.out.println("LOG: " + ACTION);
			return ACTION;
		});

		flux.addReducers(
			immutableEntry("ADD", flux.addReducer),
			immutableEntry("SUB", flux.subReducer),
			immutableEntry("MUL", flux.mulReducer)
		);

		flux.addSubscribers(
			(STATE) -> System.out.println("1. Subscriber: " + STATE),
			(STATE) -> System.out.println("2. Subscriber: " + STATE));

		flux.dispatch(CalcAction.add(1));
		flux.dispatch(CalcAction.add(1));
		flux.dispatch(CalcAction.add(1));
		flux.dispatch(CalcAction.sub(1));
		flux.dispatch(CalcAction.sub(1));
		flux.dispatch(CalcAction.mul(2));
	}
}
