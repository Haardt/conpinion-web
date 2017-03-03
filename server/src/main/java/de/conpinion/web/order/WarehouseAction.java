package de.conpinion.web.order;

import de.conpinion.web.flux.Action;

public class WarehouseAction implements Action {

    private String type;
    private boolean warehouseValid;

    private WarehouseAction(String type, boolean warehouseValid) {
        this.type = type;
        this.warehouseValid = warehouseValid;
    }

    @Override
    public String type() { return type; }

    public boolean isWarehouseValid() {
        return warehouseValid;
    }

    @Override
    public String toString() {
        return type + ":" + warehouseValid;
    }

    public static WarehouseAction ok() {
        return new WarehouseAction("warehouse", true);
    }

    public static WarehouseAction error() {
        return new WarehouseAction("warehouse", false);
    }
}