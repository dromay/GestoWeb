package com.gesto.ecommerce.web.model;

import com.gesto.ecommerce.model.Producto;

public class ShoppingCartLine {
	private Producto product = null;
	private int units = 0;
	
	/**
	 * Aqui si tiene sentido un constructor asi.
	 * @param product
	 * @param units
	 * @return
	 */
	public ShoppingCartLine(Producto product, int units ) {
		setProduct(product);
		setUnits(units);
	}

	public Producto getProduct() {
		return product;
	}

	public void setProduct(Producto product) {
		this.product = product;
	}

	public int getUnits() {
		return units;
	}

	public void setUnits(int units) {
		this.units = units;
	}
	
}
