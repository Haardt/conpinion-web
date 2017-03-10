package de.conpinion.web.order

import de.conpinion.web.order.actions.PaymentAction
import de.conpinion.web.order.actions.WarehouseAction
import spock.lang.Specification
import spock.lang.Unroll

class OrderVerticleTest extends Specification {
    def '#paymentReducer'() {
        setup:
        OrderVerticle orderVerticle = new OrderVerticle()

        expect:
        orderVerticle.paymentReducer.apply([] as Properties, action) == result

        where:
        action                || result
        PaymentAction.ok()    || ['payment.status': true]
        PaymentAction.error() || ['payment.status': false, 'payment.error': 'insufficient funds...']

    }

    def '#warehouseReducer'() {
        setup:
        OrderVerticle orderVerticle = new OrderVerticle()

        expect:
        orderVerticle.warehouseReducer.apply([] as Properties, action) == result

        where:
        action                  || result
        WarehouseAction.ok()    || ['warehouse.status': true]
        WarehouseAction.error() || ['warehouse.status': false, 'warehouse.error': 'not available...']
    }

    @Unroll
    def 'With status #currentState.warehouse.status expect to be deliveryReducer'(currentState) {
        setup 'sdfsdf':
        OrderVerticle orderVerticle = new OrderVerticle()

        expect:
        orderVerticle.deliveryReducer.apply(currentState, null)['delivery.status'] == result

        where:
        currentState                                                      || result
        ['warehouse.status': false, 'payment.status': true] as Properties || false
        ['warehouse.status': true, 'payment.status': false] as Properties || false
        ['warehouse.status': true, 'payment.status': true] as Properties  || true
    }
}