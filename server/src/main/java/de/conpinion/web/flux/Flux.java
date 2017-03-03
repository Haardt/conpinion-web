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
		this.subscriptions = new ArrayList<>(Arrays.asList(subscriber));
	}

	public void dispatch(ACTION action) {
		processMiddleware.process(action);
	}

	private void processAction(ACTION action) {
		STATE oldState = cloneFunction.apply(state);
		reducers.get(action.type()).stream().forEach( reducer -> state = reducer.apply(state, action));
		subscriptions.forEach(subscriber -> subscriber.accept(oldState, state));
	}






	// example

	public BiFunction<Integer, CalcAction, Integer> addReducer = (state, action) -> state + action.getDigit();
	public BiFunction<Integer, CalcAction, Integer> subReducer = (state, action) -> state - action.getDigit();
	public BiFunction<Integer, CalcAction, Integer> mulReducer = (state, action) -> state * action.getDigit();

	public Middleware<STATE, ACTION> logging = (action, state, next) -> {
		System.out.println("LOG: " + action);
		next.process(action);
	};

	public Middleware<STATE, CalcAction> manipulate = (action, state, next) -> {
		if (action.getDigit() != 5) {
			next.process(action);
			return;
		}
		next.process(CalcAction.add(1));
	};

	public static void main(String[] args) {

		Flux<Integer, CalcAction> flux = new Flux<>(1, state -> state);

		// Reverse execution order
		flux.addMiddleware(flux.manipulate);
		flux.addMiddleware(flux.logging);

		flux.addReducers(
			immutableEntry("ADD", flux.addReducer),
			immutableEntry("SUB", flux.subReducer),
			immutableEntry("MUL", flux.mulReducer)
		);

		flux.addSubscribers(
			(oldState, currentState) -> System.out.println("Subscriber: " + oldState + " : " + currentState));

		flux.dispatch(CalcAction.add(2));
		flux.dispatch(CalcAction.add(5));

	}
}
