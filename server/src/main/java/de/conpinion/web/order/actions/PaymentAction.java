package de.conpinion.web.order.actions;

import de.conpinion.web.flux.Action;

public class PaymentAction implements Action {

	public static final String TYPE = "payment";

	private boolean paymentValid;

	private PaymentAction(boolean paymentValid) {
		this.paymentValid = paymentValid;
	}

	@Override
	public String type() {
		return TYPE;
	}

	public boolean isPaymentValid() {
		return paymentValid;
	}

	@Override
	public String toString() {
		return TYPE + ":" + paymentValid;
	}

	public static PaymentAction ok() {
		return new PaymentAction(true);
	}

	public static PaymentAction error() {
		return new PaymentAction(false);
	}
}