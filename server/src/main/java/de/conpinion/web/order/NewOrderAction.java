package de.conpinion.web.order;

import lombok.Data;

@Data
public class NewOrderAction {
	private String type;
	private String creditCardNumber;
	private Integer items;
}
