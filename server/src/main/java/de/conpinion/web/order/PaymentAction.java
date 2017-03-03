package de.conpinion.web.order;

import de.conpinion.web.flux.Action;

public class PaymentAction implements Action {

    private String type;
    private boolean paymentValid;

    private PaymentAction(String type, boolean paymentValid) {
        this.type = type;
        this.paymentValid = paymentValid;
    }

    @Override
    public String type() { return type; }

    public boolean isPaymentValid() {
        return paymentValid;
    }

    @Override
    public String toString() {
        return type + ":" + paymentValid;
    }

    public static PaymentAction ok() {
        return new PaymentAction("payment", true);
    }

    public static PaymentAction error() {
        return new PaymentAction("payment", false);
    }
}