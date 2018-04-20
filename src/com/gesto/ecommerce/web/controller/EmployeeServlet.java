package com.gesto.ecommerce.web.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import com.gesto.ecommerce.model.Departamento;
import com.gesto.ecommerce.model.Empleado;
import com.gesto.ecommerce.model.Idioma;
import com.gesto.ecommerce.service.DepartamentoService;
import com.gesto.ecommerce.service.EmpleadoCriteria;
import com.gesto.ecommerce.service.EmpleadoService;
import com.gesto.ecommerce.service.IdiomaService;
import com.gesto.ecommerce.service.impl.DepartamentoServiceImpl;
import com.gesto.ecommerce.service.impl.EmpleadoServiceImpl;
import com.gesto.ecommerce.service.impl.IdiomaServiceImpl;
import com.gesto.ecommerce.util.ToStringUtil;
import com.gesto.ecommerce.web.util.Errors;
import com.gesto.ecommerce.web.util.SessionManager;
import com.gesto.ecommerce.web.util.WebConstants;

/**
 * Servlet implementation class EmployeeServlet
 */
@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {
	private static Logger logger = LogManager.getLogger(EmployeeServlet.class.getName());
	private EmpleadoService empleadoService = null;
	private IdiomaService idiomaService = null;
	private DepartamentoService departamentoService = null;

	public EmployeeServlet() {
		super();
		empleadoService = new EmpleadoServiceImpl();
		idiomaService = new IdiomaServiceImpl();
		departamentoService = new DepartamentoServiceImpl();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Locale locale = (Locale) SessionManager.get(request, WebConstants.USER_LOCALE);
		String action = request.getParameter(ParameterNames.ACTION);
		String target = null;
		
		if(ParameterNames.SEARCH_EMPLEADO.equalsIgnoreCase(action)){
			String usuario = request.getParameter(ParameterNames.USER_EMPLEADO);
			String nombre = request.getParameter(ParameterNames.NOMBRE_EMPLEADO);
			String apellido = request.getParameter(ParameterNames.APELLIDO_EMPLEADO);
			String ext = request.getParameter(ParameterNames.EXT);
			String idGestionCriteria = request.getParameter(ParameterNames.ID_GESTION);
			String idioma = request.getParameter(ParameterNames.IDIOMA);
			String departamento = request.getParameter(ParameterNames.DEPARTAMENTO);
			

			try {
				EmpleadoCriteria criteria = new EmpleadoCriteria();
				if (!StringUtils.isEmpty(usuario)){
					criteria.setUsuario(usuario);
					request.setAttribute(AttributeNames.USER_EMPLEADO, usuario);
				}
				if (!StringUtils.isEmpty(nombre)) {
					criteria.setNombre(nombre);
					request.setAttribute(AttributeNames.NOMBRE_EMPLEADO, nombre);
				}
				if (!StringUtils.isEmpty(apellido)) {
					criteria.setApellido(apellido);
					request.setAttribute(AttributeNames.APELLIDO_EMPLEADO, apellido);
				}	
				if (!StringUtils.isEmpty(ext)) {
					criteria.setExt(Long.valueOf(ext));
					request.setAttribute(AttributeNames.EXT_EMPLEADO, ext);
				}
				if (!StringUtils.isEmpty(idGestionCriteria)) {
					criteria.setIdGestionCriteria(Long.valueOf(idGestionCriteria));
					request.setAttribute(AttributeNames.ID_GESTION, idGestionCriteria);	
				}
				if (!StringUtils.isEmpty(idioma))
					criteria.setIdIdiomaCriteria(idioma);
				if (!StringUtils.isEmpty(departamento))
					criteria.setExtDepartamento(Long.valueOf(departamento));
				List<Empleado> empleados = empleadoService.findByCriteria(criteria, locale.getLanguage(), 1, 5);
				List<Empleado> supervisores = new ArrayList<>();
				for (Empleado em : empleados) {
					supervisores.add(empleadoService.findSupervisor(em,locale.getLanguage()));
					logger.debug("Result :" + ToStringUtil.toString(em));
				}
				if (empleados.isEmpty()) {
					request.setAttribute(AttributeNames.ERROR, Errors.NOT_FOUND_ERROR);
					target = ViewPaths.EMPLOYEE_SEARCH_SERVLET;

				} else {
					request.setAttribute(AttributeNames.EMPLEADOS, empleados);
					request.setAttribute(AttributeNames.SUPERVISORES, supervisores);
					target = ViewPaths.EMPLOYEE_SEARCH_SERVLET;
				}

			} catch (Exception e) {
				logger.error(e.getMessage(), e);
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				target = ViewPaths.EMPLOYEE_SEARCH_SERVLET;
			}
		}
		if(ParameterNames.EMPLEADO_DETAIL.equalsIgnoreCase(action)){
			String usuario = request.getParameter(ParameterNames.USER_EMPLEADO);
			
			try {
				Empleado empleado = empleadoService.findByUsuario(usuario, locale.getLanguage());
				Empleado supervisor = empleadoService.findSupervisor(empleado,locale.getLanguage());
				List<Idioma> idiomas = idiomaService.findByEmpleado(empleado.getIdEmpleado(), locale.getLanguage());
				Departamento departamento = departamentoService.findById(empleado.getExtDepartamento(), locale.getLanguage()); 
				request.setAttribute(AttributeNames.EMPLEADOS, empleado);
				request.setAttribute(AttributeNames.IDIOMAS, idiomas);
				request.setAttribute(AttributeNames.DEPARTAMENTOS, departamento);
				request.setAttribute(AttributeNames.SUPERVISOR, supervisor);
				target = ViewPaths.EMPLOYEE_DETAIL_SERVLET;
				
			} catch (DataException e) {
				logger.error(e.getMessage(), e);
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				target = ViewPaths.EMPLOYEE_SEARCH_SERVLET;
			}
			
		}
		request.getRequestDispatcher(target).forward(request, response);
		}
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
