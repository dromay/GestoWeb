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

import com.gesto.ecommerce.exceptions.DataException;
import com.gesto.ecommerce.model.Cliente;
import com.gesto.ecommerce.model.Departamento;
import com.gesto.ecommerce.model.Empleado;
import com.gesto.ecommerce.model.Idioma;
import com.gesto.ecommerce.service.ClienteCriteria;
import com.gesto.ecommerce.service.ClienteService;
import com.gesto.ecommerce.service.DepartamentoService;
import com.gesto.ecommerce.service.IdiomaService;
import com.gesto.ecommerce.service.impl.ClienteServiceImpl;
import com.gesto.ecommerce.service.impl.DepartamentoServiceImpl;
import com.gesto.ecommerce.service.impl.IdiomaServiceImpl;
import com.gesto.ecommerce.util.ToStringUtil;
import com.gesto.ecommerce.web.util.Errors;
import com.gesto.ecommerce.web.util.SessionManager;
import com.gesto.ecommerce.web.util.WebConstants;

/**
 * Servlet implementation class EmployeeServlet
 */
@WebServlet("/ClientServlet")
public class ClientServlet extends HttpServlet {
	private static Logger logger = LogManager.getLogger(EmployeeServlet.class.getName());
	private ClienteService clienteService = null;
	private IdiomaService idiomaService = null;
	private DepartamentoService departamentoService = null;

	public ClientServlet() {
		super();
		clienteService = new ClienteServiceImpl();
		idiomaService = new IdiomaServiceImpl();
		departamentoService = new DepartamentoServiceImpl();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Locale locale = (Locale) SessionManager.get(request, WebConstants.USER_LOCALE);
		String action = request.getParameter(ParameterNames.ACTION);
		String target = null;
		
		if(ParameterNames.SEARCH_CLIENTE.equalsIgnoreCase(action)){
			String nombreCliente = request.getParameter(ParameterNames.NOMBRE_CLIENTE);
			String codCliente = request.getParameter(ParameterNames.DOC_CLIENTE);
			String tlf = request.getParameter(ParameterNames.TLF);
			String correo = request.getParameter(ParameterNames.CORREO);
			String idGestionCriteria = request.getParameter(ParameterNames.ID_GESTION);
			String idioma = request.getParameter(ParameterNames.IDIOMA);
			String tipoCliente = request.getParameter(ParameterNames.TIPO_CLIENTE);
			
			if (logger.isDebugEnabled()) {
				logger.debug("Result :" + tipoCliente);
			}
			

			try {
				ClienteCriteria criteria = new ClienteCriteria();
				if (!StringUtils.isEmpty(nombreCliente)){
					criteria.setNombreCriteria(nombreCliente);
					request.setAttribute(AttributeNames.NOMBRE_CLIENTE, nombreCliente);
				}
				if (!StringUtils.isEmpty(codCliente)) {
					criteria.setDocIdentidadCriteria(codCliente);
					request.setAttribute(AttributeNames.COD_CLIENTE, codCliente);
				}
				if (!StringUtils.isEmpty(tlf)) {
					criteria.setTlfCriteria(tlf);
					request.setAttribute(AttributeNames.TLF_CLIENTE, tlf);
				}
					
				if (!StringUtils.isEmpty(correo)) {
					criteria.setCorreoCriteria(correo);
					request.setAttribute(AttributeNames.CORREO_CLIENTE, correo);
				}
					
				if (!StringUtils.isEmpty(idGestionCriteria)) {
					criteria.setIdGestionCriteria(Long.valueOf(idGestionCriteria));
					request.setAttribute(AttributeNames.ID_GESTION, idGestionCriteria);
				}
				if (!StringUtils.isEmpty(idioma)) {
					criteria.setIdIdiomaCriteria(idioma);
					request.setAttribute(AttributeNames.IDIOMA, idioma);
				}
				if (!StringUtils.isEmpty(tipoCliente)) {
					criteria.setTipoCriteria(tipoCliente);
					request.setAttribute(AttributeNames.TIPO_CLIENTE, tipoCliente);
				}
				List<Cliente> clientes = clienteService.findByCriteria(criteria, locale.getLanguage(), 1, Integer.MAX_VALUE);
				for (Cliente c : clientes) {
					logger.debug("Result :" + ToStringUtil.toString(c));
				}
				if (clientes.isEmpty()) {
					request.setAttribute(AttributeNames.ERROR, Errors.NOT_FOUND_ERROR);
					target = ViewPaths.CLIENT_SEARCH_SERVLET;

				} else {
					request.setAttribute(AttributeNames.CLIENTES, clientes);
					target = ViewPaths.CLIENT_SEARCH_SERVLET;
				}

			} catch (Exception e) {
				logger.error(e.getMessage(), e);
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				target = ViewPaths.CLIENT_SEARCH_SERVLET;
			}
		}
		if(ParameterNames.CLIENTE_DETAIL.equalsIgnoreCase(action)){
			String idCliente = request.getParameter(ParameterNames.ID_CLIENTE);
			
			try {
				Cliente cliente = clienteService.findById(Long.valueOf(idCliente),locale.getLanguage());
				request.setAttribute(AttributeNames.CLIENTES, cliente);
				target = ViewPaths.CLIENT_DETAIL_SERVLET;
				
			} catch (DataException e) {
				logger.error(e.getMessage(), e);
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				target = ViewPaths.CLIENT_SEARCH_SERVLET;
			}
			
		}
		request.getRequestDispatcher(target).forward(request, response);
		}
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
