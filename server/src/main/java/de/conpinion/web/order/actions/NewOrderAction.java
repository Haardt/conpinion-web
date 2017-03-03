package de.conpinion.web.order.actions;

import de.conpinion.web.flux.Action;



public class NewOrderAction implements Action {
	public static final String TYPE = "order";
	private final String creditCardNumber;
	private final Integer items;

	public NewOrderAction(String creditCardNumber, Integer items) {
		this.creditCardNumber = creditCardNumber;
		this.items = items;
	}

	public String getCreditCardNumber() {
		return creditCardNumber;
	}

	public Integer getItems() {
		return items;
	}

	public String type() {
		return TYPE;
	}

	public static NewOrderAction newOrder(String creditCardNumber, Integer items) {

		return new NewOrderAction(creditCardNumber, items);
	}
}
