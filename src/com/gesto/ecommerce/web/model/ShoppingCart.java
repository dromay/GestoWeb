package com.gesto.ecommerce.web.model;

import java.util.ArrayList;
import java.util.List;

public class ShoppingCart {
	
	private List<ShoppingCartLine> lines = null;
	
	public ShoppingCart() {
		lines = new ArrayList<ShoppingCartLine>();
	}
	
	public void add(ShoppingCartLine p) {
		lines.add(p);
	}

	public List<ShoppingCartLine> getLines() {
		return lines;
	}

	public void setLineas(List<ShoppingCartLine> lineas) {
		this.lines = lineas;
	}
	
}
