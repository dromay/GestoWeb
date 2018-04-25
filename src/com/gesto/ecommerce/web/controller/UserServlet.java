package com.gesto.ecommerce.web.controller;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.gesto.ecommerce.model.Cliente;
import com.gesto.ecommerce.model.Contacto;
import com.gesto.ecommerce.model.Departamento;
import com.gesto.ecommerce.model.Empleado;
import com.gesto.ecommerce.model.Empresa;
import com.gesto.ecommerce.model.Idioma;
import com.gesto.ecommerce.service.ClienteCriteria;
import com.gesto.ecommerce.service.DepartamentoService;
import com.gesto.ecommerce.service.EmpleadoService;
import com.gesto.ecommerce.service.IdiomaService;
import com.gesto.ecommerce.service.IncomingCallService;
import com.gesto.ecommerce.service.impl.DepartamentoServiceImpl;
import com.gesto.ecommerce.service.impl.EmpleadoServiceImpl;
import com.gesto.ecommerce.service.impl.IdiomaServiceImpl;
import com.gesto.ecommerce.service.impl.IncomingCallServiceImpl;
import com.gesto.ecommerce.util.PasswordEncryptionUtil;
import com.gesto.ecommerce.util.ToStringUtil;
import com.gesto.ecommerce.web.util.Actions;
import com.gesto.ecommerce.web.util.CookieManager;
import com.gesto.ecommerce.web.util.Errors;
import com.gesto.ecommerce.web.util.LocaleManager;
import com.gesto.ecommerce.web.util.SessionManager;
import com.gesto.ecommerce.web.util.WebConstants;

/**
 * Servlet para Autentification.
 */
@WebServlet("/user")
public class UserServlet extends HttpServlet {

	private static Logger logger = LogManager.getLogger(UserServlet.class.getName());

	private EmpleadoService empleadoService = null;
	private IdiomaService idiomaService = null;
	private DepartamentoService departamentoService = null;
	private IncomingCallService incomingCallService = null;

	public UserServlet() {
		super();
		empleadoService = new EmpleadoServiceImpl();
		idiomaService = new IdiomaServiceImpl();
		departamentoService = new DepartamentoServiceImpl();
		incomingCallService = new IncomingCallServiceImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter(ParameterNames.ACTION);

		String target = null;
		boolean redirect = false;

		if (Actions.SIGN_IN.equalsIgnoreCase(action)) {
			String userName = request.getParameter(ParameterNames.USER_EMPLEADO).trim();
			String password = request.getParameter(ParameterNames.PASSWORD);
			Locale locale = (Locale) SessionManager.get(request, WebConstants.USER_LOCALE);
			boolean hasErrors = false;

			if (StringUtils.isEmpty(userName)) {
				hasErrors = true;
				request.setAttribute(AttributeNames.ERROR_USER, Errors.REQUIRED_FIELD_ERROR);
			}
			if (StringUtils.isEmpty(password)) {
				hasErrors = true;
				
				request.setAttribute(AttributeNames.ERROR_PASSWORD, Errors.REQUIRED_FIELD_ERROR);
			}

			if (hasErrors) {
				// Si hay errores.. se los muestro y si no continuo
				request.setAttribute(AttributeNames.USUARIO, userName);
				target = ViewPaths.SIGN_IN_SERVLET;
			} else {
				// Si los parametros están bien, sigo...
				try {
					Empleado user = empleadoService.findByUsuario(userName, locale.getLanguage());

					if (user == null) {
						if (logger.isDebugEnabled()) {
							logger.debug("Entra " + redirect);
						}
						request.setAttribute(AttributeNames.ERROR, Errors.INCORRECT_PASSWORD_ERROR);
						target = ViewPaths.SIGN_IN_SERVLET;
					} else {
						if (!PasswordEncryptionUtil.checkPassword(password, user.getPassword())) {
							request.setAttribute(AttributeNames.ERROR, Errors.INCORRECT_PASSWORD_ERROR);
							target = ViewPaths.SIGN_IN_SERVLET;
						} else {
							SessionManager.set(request, SessionAttributeNames.USER, user);
							List<Idioma> idiomas = idiomaService.findByEmpleado(user.getIdEmpleado(),
									locale.getLanguage());
							SessionManager.set(request, SessionAttributeNames.IDIOMAS, idiomas);
							List<Departamento> departamentos = departamentoService.findAll(locale.getLanguage());
							SessionManager.set(request, SessionAttributeNames.DEPARTAMENTOS, departamentos);
							target = ViewPaths.GESTION_SEARCH;
							redirect = true;
						}
					}

				} catch (Exception e) {
					logger.error(e.getMessage(), e);
					request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
					target = ViewPaths.SIGN_IN_SERVLET;
				} catch (Throwable t) {
					logger.error(t.getMessage(), t);
					request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
					target = ViewPaths.SIGN_IN_SERVLET;
				}
			}
		} else if (Actions.SIGN_OUT.equalsIgnoreCase(action)) {
			SessionManager.set(request, SessionAttributeNames.USER, null);
			request.getSession(true).setAttribute(SessionAttributeNames.CLIENTE, null);
			request.getSession(true).setAttribute(SessionAttributeNames.EMPRESA, null);
			request.getSession(true).setAttribute(SessionAttributeNames.CONTACTO, null);
			target = ViewPaths.SIGN_IN;
			redirect = true;

		} else if (Actions.CREATE_CALL.equalsIgnoreCase(action)) {

			Empleado usuario = (Empleado) SessionManager.get(request, SessionAttributeNames.USER);
			Locale locale = (Locale) SessionManager.get(request, WebConstants.USER_LOCALE);

			try {

				Contacto contacto = incomingCallService.findCall(usuario, locale.getLanguage());

				Empresa empresa = incomingCallService.findReceiverCompany(locale.getLanguage());

				Cliente cliente = incomingCallService.findCallClient(contacto.getContactoTlf(), locale.getLanguage());
				
				Idioma idiomaCall = null;
				
				for(Idioma i : usuario.getIdiomas()){	
					for(Idioma ie : contacto.getIdiomas()){
						if(ie.getIdIdioma().compareTo(i.getIdIdioma())==0){
							idiomaCall = i;
						}
					}
					
				}

				if (logger.isDebugEnabled()) {
					logger.debug("Result :" + ToStringUtil.toString(cliente));
					logger.debug("Result :" + ToStringUtil.toString(empresa));
					logger.debug("Result :" + ToStringUtil.toString(contacto));
				}
				if (cliente != null || empresa != null) {
					SessionManager.set(request, SessionAttributeNames.CLIENTE, cliente);
					SessionManager.set(request, SessionAttributeNames.EMPRESA, empresa);
					SessionManager.set(request, SessionAttributeNames.CONTACTO, contacto);
					SessionManager.set(request, SessionAttributeNames.IDIOMA_CALL, idiomaCall);
					target = ViewPaths.GESTION_SEARCH_DETAIL;
				} else {
					request.setAttribute(AttributeNames.ERROR, Errors.NOT_FOUND_CALL);
					target = ViewPaths.GESTION_SEARCH_DETAIL;
				}

			} catch (Exception e) {
				logger.error(e.getMessage(), e);
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				target = ViewPaths.GESTION_SEARCH_DETAIL;
			}
			
		} else if (Actions.DELETE_CALL.equalsIgnoreCase(action)) {

			request.getSession(true).setAttribute(SessionAttributeNames.CLIENTE, null);
			request.getSession(true).setAttribute(SessionAttributeNames.EMPRESA, null);
			request.getSession(true).setAttribute(SessionAttributeNames.CONTACTO, null);
			target = ViewPaths.GESTION_SEARCH;
			redirect = true;
			
		} else if (Actions.CHANGE_LOCALE.equalsIgnoreCase(action)) {
			
			String localeName = request.getParameter(ParameterNames.LOCALE);
			List<Locale> results = LocaleManager.getMatchedLocales(localeName);
			Locale newLocale = null;
			if (results.size() > 0) {
				newLocale = results.get(0);
			} else {
				logger.warn("Request locale not supported: " + localeName);
				newLocale = LocaleManager.getDefault();
			}

			SessionManager.set(request, WebConstants.USER_LOCALE, newLocale);
			CookieManager.addCookie(response, WebConstants.USER_LOCALE, newLocale.toString(), "/", 365 * 24 * 60 * 60);

			if (logger.isDebugEnabled()) {
				logger.debug("Locale changed to " + newLocale);
			}

			target = ViewPaths.SIGN_IN; // Ejercicio: como hacer que siga en la misma URL
			redirect = true;

		}
		// else {
		// logger.error("Unknown action: "+action);
		// target = ViewsPaths.ROOT_CONTEXT;
		// redirect = true;
		// }

		if (logger.isDebugEnabled()) {
			logger.debug("Action " + action + " processed: target = " + target + ", redirect = " + redirect);
		}

		if (redirect) {
			response.sendRedirect(target);
		} else {
			request.getRequestDispatcher(target).forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
