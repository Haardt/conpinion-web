package de.conpinion.web.flux;

/**
 * Created by haardt on 27.02.17.
 */
public class CalcAction implements Action {

    private String type;
    private Integer digit;

    private CalcAction(String type, Integer digit) {
        this.type = type;
        this.digit = digit;
    }

    @Override
    public String type() { return type; }

    public Integer getDigit() {
        return digit;
    }

    public static CalcAction add(Integer digit) {
        return new CalcAction("ADD", digit);
    }

    public static CalcAction sub(Integer digit) {
        return new CalcAction("SUB", digit);
    }

    public static CalcAction mul(Integer digit) {
        return new CalcAction("MUL", digit);
    }

    @Override
    public String toString() {
        return type + ":" + digit;
    }
}