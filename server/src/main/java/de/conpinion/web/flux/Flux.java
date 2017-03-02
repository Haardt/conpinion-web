package de.conpinion.web.flux;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import static com.google.common.collect.Maps.immutableEntry;


public class Flux<STATE, ACTION extends Action> {

	private Map<String, BiFunction<STATE, ACTION, STATE>> reducers;
	private List<Consumer<STATE>> subscriptions;
	private Middleware<STATE, ACTION> middleware = action -> {
		processAction(action);
		return x -> y ->{};
	};

	private STATE state;

	public Flux(STATE initialState) {
		this.state = initialState;
	}

	public void addMiddleware(Middleware<STATE, ACTION> nextMiddleware) {
		Middleware<STATE, ACTION> prevMiddleware = this.middleware;
		this.middleware = (action) -> {
			nextMiddleware.process(action).apply(state).accept((nextAction) ->
			{
				if (action == nextAction) {
					prevMiddleware.process(nextAction);
				}
				else {
					dispatch(nextAction);
				}
			});
			return a -> b -> {};
		};
	}

	public void addReducers(Map.Entry<String, BiFunction<STATE, ACTION, STATE>>... reducers) {
		this.reducers = Arrays.asList(reducers).stream().collect(Collectors.toMap(
			Map.Entry::getKey, Map.Entry::getValue));
	}

	public void addSubscribers(Consumer<STATE>... subscriber) {
		this.subscriptions = new ArrayList<>(Arrays.asList(subscriber));
	}

	public void dispatch(ACTION action) {
		middleware.process(action);
	}

	private void processAction(ACTION action) {
		state = reducers.get(action.type()).apply(state, action);
		subscriptions.forEach((subscriber) -> subscriber.accept(state));
	}


	public BiFunction<Integer, CalcAction, Integer> addReducer = (state, action) -> state + action.getDigit();
	public BiFunction<Integer, CalcAction, Integer> subReducer = (state, action) -> state - action.getDigit();
	public BiFunction<Integer, CalcAction, Integer> mulReducer = (state, action) -> state * action.getDigit();


	public Middleware<STATE, ACTION> logging = action -> state -> next -> {
		System.out.println("LOG: " + action);
		next.process(action);
	};

	public Middleware<STATE, CalcAction> manipulate = action -> state -> next -> {
		if (action.getDigit() != 5) {
			next.process(action);
			return;
		}
		next.process(CalcAction.add(1));
	};

	public static void main(String[] args) {

		Flux<Integer, CalcAction> flux = new Flux<>(1);

		flux.addMiddleware(flux.logging);
		flux.addMiddleware(flux.manipulate);



		flux.addReducers(
			immutableEntry("ADD", flux.addReducer),
			immutableEntry("SUB", flux.subReducer),
			immutableEntry("MUL", flux.mulReducer)
		);

		flux.addSubscribers(
			(STATE) -> System.out.println("1. Subscriber: " + STATE),
			(STATE) -> System.out.println("2. Subscriber: " + STATE));

		flux.dispatch(CalcAction.add(2));
		flux.dispatch(CalcAction.add(5));

	}
}
