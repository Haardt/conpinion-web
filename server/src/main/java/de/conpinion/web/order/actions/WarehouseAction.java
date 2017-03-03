package de.conpinion.web.order.actions;

import de.conpinion.web.flux.Action;

public class WarehouseAction implements Action {

    public static final String TYPE ="warehouse";
    private boolean warehouseValid;

    private WarehouseAction(boolean warehouseValid) {
        this.warehouseValid = warehouseValid;
    }

    @Override
    public String type() { return TYPE; }

    public boolean isWarehouseValid() {
        return warehouseValid;
    }

    @Override
    public String toString() {
        return TYPE + ":" + warehouseValid;
    }

    public static WarehouseAction ok() {
        return new WarehouseAction(true);
    }

    public static WarehouseAction error() {
        return new WarehouseAction(false);
    }
}