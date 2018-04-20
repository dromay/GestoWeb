package com.gesto.ecommerce.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.gesto.ecommerce.web.controller.AttributeNames;
import com.gesto.ecommerce.web.controller.SessionAttributeNames;
import com.gesto.ecommerce.web.controller.ViewPaths;
import com.gesto.ecommerce.web.util.Errors;
import com.gesto.ecommerce.web.util.SessionManager;

/**
 * Filtro para inicializacion de la sesion y estado común requerido.
 */
//En servlet 3.0 la anotacion no provee manera para establecer orden de filtros
// @WebFilter(filterName = "InitSessionFilter", urlPatterns = {"/*"})
public class UserSessionFilter implements Filter {

	private static Logger logger = LogManager.getLogger(UserSessionFilter.class.getName());
  
    public UserSessionFilter() {       
    }

	public void init(FilterConfig cfg) throws ServletException {
		// Habitualmente se configuran en el web.xml
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		if (SessionManager.get((HttpServletRequest) request, SessionAttributeNames.USER)==null) {
			if (logger.isInfoEnabled()) {
				logger.info("Necesita autentificacion "+request.getRemoteAddr()+".");
			}
			request.setAttribute(AttributeNames.ERROR, Errors.ACCESS_ERROR);
			request.getRequestDispatcher(ViewPaths.SIGN_IN_SERVLET).forward(request, response);
		}
		
		// Continuar la invocacion de la cadena de responsabilidad.
		// Solamente no se invocara si el filtro determinase otro 
		// como por ejemplo en el caso de un filtro de autenticacion.
		chain.doFilter(request, response);
	}




}
