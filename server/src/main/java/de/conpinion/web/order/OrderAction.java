package de.conpinion.web.order;

import de.conpinion.web.flux.Action;

public class OrderAction implements Action {

    private String type;

    private OrderAction(String type) {
        this.type = type;
    }

    @Override
    public String type() { return type; }

    @Override
    public String toString() {
        return type;
    }

    public static OrderAction newOrder() {
        return new OrderAction("order");
    }
}