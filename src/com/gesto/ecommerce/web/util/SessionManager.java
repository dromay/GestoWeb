package com.gesto.ecommerce.web.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.gesto.ecommerce.web.controller.SessionAttributeNames;
import com.gesto.ecommerce.web.model.ShoppingCart;

public class SessionManager {

	public static Object get(HttpServletRequest request, String attName) {
		return getSession(request).getAttribute(attName);
	}

	public static void set(HttpServletRequest request, String attName, Object attValue) {
		getSession(request).setAttribute(attName, attValue);
	}
	
	/**
	 * Método factoria de la sesión, y sus objetos mandatorios.
	 * @param request
	 * @return
	 */
	protected static HttpSession getSession(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		// Atención a: https://guneetsahai.com/2008/08/09/request-getsession-false-always-returning-a-session/
		if (session==null) {
			// Inicializo la sesion y todos los objetos obligatorios
			session = request.getSession(true);
			
			ShoppingCart c = new ShoppingCart(); 
			session.setAttribute(SessionAttributeNames.SHOPPING_CART, c);
		}
		return session;
	}	
}
