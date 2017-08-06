package de.conpinion.web.flux;

import com.mchange.v2.collection.MapEntry;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;
import java.util.function.BiFunction;
import java.util.function.Function;

import lombok.extern.log4j.Log4j2;

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
			.stream().collect(groupingBy(Map.Entry::getKey, mapping(Map.Entry::getValue, toList())));
	}

	public void addSubscribers(BiConsumer<STATE, STATE>... subscriber) {
		this.subscriptions = Arrays.asList(subscriber);
	}

	public void dispatch(ACTION action) {
		processMiddleware.process(action);
	}

	private void processAction(ACTION action) {
		STATE oldState = cloneFunction.apply(state);
		reducers.get(action.type()).stream().forEach(reducer -> state = reducer.apply(state, action));
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












	public static void main(String[] args) {
		final Flux flux = new Flux<Integer, Action>(0, x -> x);
		flux.example();
	}

	public void example() {
		addMiddleware(logMiddleware);

		addReducers(
			new MapEntry("INC", incReducer),
			new MapEntry("DEC", decReducer)
			);

		addSubscribers((oldState, newState) -> {
			System.out.println("OldState: " + oldState + "/ NewState:" + newState);
		});

		dispatch((ACTION) new IncAction());
		dispatch((ACTION) new IncAction());
		dispatch((ACTION) new DecAction());
	}

	class IncAction implements Action {
		@Override
		public String type() {
			return "INC";
		}
	}

	class DecAction implements Action {
		@Override
		public String type() {
			return "DEC";
		}
	}

	BiFunction<Integer, IncAction, Integer> incReducer = (oldState, action) -> oldState + 1;

	BiFunction<Integer, DecAction, Integer> decReducer = (oldState, action) -> oldState - 1;

	Middleware logMiddleware = (currentAction, state, processNextAction) -> {
		System.out.println("Action: " + currentAction);
		processNextAction.process(currentAction);
	};




}
