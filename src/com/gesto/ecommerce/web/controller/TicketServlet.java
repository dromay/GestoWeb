package com.gesto.ecommerce.web.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.gesto.ecommerce.exceptions.DuplicateInstanceException;
import com.gesto.ecommerce.model.Cliente;
import com.gesto.ecommerce.model.Contacto;
import com.gesto.ecommerce.model.Empleado;
import com.gesto.ecommerce.model.Empresa;
import com.gesto.ecommerce.model.Gestion;
import com.gesto.ecommerce.model.Ticket;
import com.gesto.ecommerce.service.ClienteService;
import com.gesto.ecommerce.service.ContactoService;
import com.gesto.ecommerce.service.EmpleadoCriteria;
import com.gesto.ecommerce.service.EmpleadoService;
import com.gesto.ecommerce.service.GestionCriteria;
import com.gesto.ecommerce.service.GestionService;
import com.gesto.ecommerce.service.TicketService;
import com.gesto.ecommerce.service.impl.ClienteServiceImpl;
import com.gesto.ecommerce.service.impl.ContactoServiceImpl;
import com.gesto.ecommerce.service.impl.EmpleadoServiceImpl;
import com.gesto.ecommerce.service.impl.GestionServiceImpl;
import com.gesto.ecommerce.service.impl.TicketServiceImpl;
import com.gesto.ecommerce.util.DateTimeUtils;
import com.gesto.ecommerce.util.ToStringUtil;
import com.gesto.ecommerce.web.util.Errors;
import com.gesto.ecommerce.web.util.SessionManager;
import com.gesto.ecommerce.web.util.Success;
import com.gesto.ecommerce.web.util.WebConstants;

@WebServlet("/TicketServlet")
public class TicketServlet extends HttpServlet {
	private static Logger logger = LogManager.getLogger(TicketServlet.class.getName());
	private TicketService ticketService = null;
	private GestionService gestionService = null;
	private EmpleadoService empleadoService = null;
	private ClienteService clienteService = null;
	private ContactoService contactoService = null;

	public TicketServlet() {
		super();
		ticketService = new TicketServiceImpl();
		gestionService = new GestionServiceImpl();
		empleadoService = new EmpleadoServiceImpl();
		clienteService = new ClienteServiceImpl();
		contactoService = new ContactoServiceImpl();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter(ParameterNames.ACTION);
		Empleado usuario = (Empleado) SessionManager.get(request, SessionAttributeNames.USER);
		Cliente cliente = (Cliente) SessionManager.get(request, SessionAttributeNames.CLIENTE);
		Contacto contacto = (Contacto) SessionManager.get(request, SessionAttributeNames.CONTACTO);
		Empresa empresa = (Empresa) SessionManager.get(request, SessionAttributeNames.EMPRESA);
		Locale locale = (Locale) SessionManager.get(request, WebConstants.USER_LOCALE);

		String target = null;

		if (ParameterNames.PRECREATE_GESTION.equalsIgnoreCase(action)) {

			if (cliente == null || contacto == null || usuario == null) {
				request.setAttribute(AttributeNames.ERROR, Errors.NOT_CALL);
				target = ViewPaths.GESTION_SEARCH_SERVLET;
			} else {
				// Get the date today using Calendar object.
				Date today = Calendar.getInstance().getTime();
				// Using DateFormat format method we can create a string
				// representation of a date with the defined format.
				String fechaInicio = WebUtils.df.format(today);
				if (logger.isDebugEnabled()) {
					logger.debug(fechaInicio);
				}
				target = ViewPaths.TICKET_CREATE;
				request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
			}
		}

		if (ParameterNames.PRECREATE_TICKET.equalsIgnoreCase(action)){
			
			Gestion g = null;
			try {
				g = gestionService.findById(Long.valueOf(request.getParameter(ParameterNames.ID_GESTION)),
						locale.getLanguage());
				if (cliente == null || contacto == null || usuario == null) {
					request.setAttribute(AttributeNames.ERROR, Errors.NOT_CALL);
					target = ViewPaths.GESTION_SEARCH_SERVLET;
				} else if (g.getIdCliente() != cliente.getIdCliente()) {
					request.setAttribute(AttributeNames.ERROR, Errors.DIFFERENT_CALL);
					target = ViewPaths.GESTION_SEARCH_SERVLET;
				} else {
					// Get the date today using Calendar object.
					Date today = Calendar.getInstance().getTime();
					// Using DateFormat format method we can create a string
					// representation of a date with the defined format.
					String fechaInicio = WebUtils.FECHA_FORMATO.format(today);
	
					target = ViewPaths.TICKET_CREATE;
					request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
					request.setAttribute(AttributeNames.ID_GESTION,
							Long.valueOf(request.getParameter(ParameterNames.ID_GESTION)));
				}
			} catch (DataException | NumberFormatException e) {
				request.setAttribute(AttributeNames.ERROR, Errors.MANAGEMENT_CREATE);
				logger.error(Errors.MISSING_PARAMETER_ERROR, e);
				target = ViewPaths.GESTION_SEARCH_SERVLET;
			}
		}

		if (ParameterNames.CREATE_GESTION.equalsIgnoreCase(action)) {
			// Vamos a crear un ticket de una gestion nueva
			String fechaInicio = request.getParameter(ParameterNames.FECHA_INICIO);
			try {
				String tipoGestion = request.getParameter(ParameterNames.TIPO_GESTION);
				String comentario = request.getParameter(ParameterNames.COMENTARIO);
				boolean hasErrors = false;

				if (StringUtils.isEmpty(tipoGestion)) {
					hasErrors = true;
					request.setAttribute(AttributeNames.ERROR_MANAGEMENT, Errors.REQUIRED_FIELD_ERROR);
				}
				if (StringUtils.isEmpty(comentario)) {
					hasErrors = true;
					request.setAttribute(AttributeNames.ERROR_COMENTARY, Errors.REQUIRED_FIELD_ERROR);
				}
				if (hasErrors) {
					// Si hay errores.. se los muestro y si no continuo
					request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
					request.setAttribute(AttributeNames.ERROR, Errors.MANAGEMENT_CREATE);
					target = ViewPaths.TICKET_CREATE;
				} else {
				
				Ticket t = new Ticket();
				Gestion g = new Gestion();

				// Datos Gestion

				g.setIdCliente(cliente.getIdCliente());

				g.setIdEmpleado(usuario.getIdEmpleado());

				g.setIdEmpresa(empresa.getIdEmpresa());

				// Datos Ticket

				t.setIdContacto(contacto.getIdContacto());

				t.setTipoTicket(tipoGestion);
				
				t.setComentario(comentario);

				// Calculamos la duración
				Date inicioDate = null;

				inicioDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fechaInicio);

				t.setFechaInicio(inicioDate);
				g.setFechaInicio(inicioDate);

				Date finDate = new Date();

				Duration d = DateTimeUtils.between(inicioDate, finDate);
				t.setTiempoTotal(d.getSeconds());

				gestionService.create(g, t);
				request.setAttribute(AttributeNames.SUCCESS, Success.MANAGEMENT);
				}
			} catch (DuplicateInstanceException e) {
				request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
				request.setAttribute(AttributeNames.ERROR, Errors.MANAGEMENT_CREATE);
				logger.error(Errors.DUPLICATE_PARAMETER_ERROR, e);
			} catch (DataException e) {
				request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
				request.setAttribute(AttributeNames.ERROR, Errors.MANAGEMENT_CREATE);
				logger.error(Errors.MISSING_PARAMETER_ERROR, e);
			} catch (ParseException e) {
				request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
				request.setAttribute(AttributeNames.ERROR, Errors.MANAGEMENT_CREATE);
				logger.error(Errors.DATE_NOT_CREATED, e);
			}

			target = ViewPaths.TICKET_CREATE;

		}

		if (ParameterNames.CREATE_TICKET.equalsIgnoreCase(action)) {
			// Vamos a crear un ticket de una gestion existente
			String fechaInicio = request.getParameter(ParameterNames.FECHA_INICIO);
			try {
				
				String tipoGestion = request.getParameter(ParameterNames.TIPO_GESTION);
				String comentario = request.getParameter(ParameterNames.COMENTARIO);
				boolean hasErrors = false;

				if (StringUtils.isEmpty(tipoGestion)) {
					hasErrors = true;
					request.setAttribute(AttributeNames.ERROR_MANAGEMENT, Errors.REQUIRED_FIELD_ERROR);
				}
				if (StringUtils.isEmpty(comentario)) {
					hasErrors = true;
					request.setAttribute(AttributeNames.ERROR_COMENTARY, Errors.REQUIRED_FIELD_ERROR);
				}
				if (hasErrors) {
					// Si hay errores.. se los muestro y si no continuo
					request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
					request.setAttribute(AttributeNames.ERROR, Errors.TICKET_CREATE);
					target = ViewPaths.TICKET_CREATE;
				} else {
				Ticket t = new Ticket();

				// Datos Ticket

				t.setIdContacto(contacto.getIdContacto());

				t.setIdEmpleado(usuario.getIdEmpleado());

				t.setTipoTicket(tipoGestion);

				t.setComentario(comentario);

				String idGestion = request.getParameter(ParameterNames.ID_GESTION);
				t.setIdGestion(Long.valueOf(idGestion));

				// Calculamos la duración
				Date inicioDate = null;

				inicioDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fechaInicio);

				t.setFechaInicio(inicioDate);

				Date finDate = new Date();

				Duration d = DateTimeUtils.between(inicioDate, finDate);
				t.setTiempoTotal(d.getSeconds());

				ticketService.create(t);
				request.setAttribute(AttributeNames.SUCCESS, Success.TICKET);
				}
			} catch (DuplicateInstanceException e) {
				request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
				request.setAttribute(AttributeNames.ERROR, Errors.TICKET_CREATE);
				logger.error(Errors.DUPLICATE_PARAMETER_ERROR, e);
			} catch (DataException e) {
				request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
				request.setAttribute(AttributeNames.ERROR, Errors.TICKET_CREATE);
				logger.error(Errors.MISSING_PARAMETER_ERROR, e);
			} catch (ParseException e) {
				request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
				request.setAttribute(AttributeNames.ERROR, Errors.TICKET_CREATE);
				logger.error(Errors.DATE_NOT_CREATED, e);
			}

			target = ViewPaths.TICKET_CREATE;

		}
		if (ParameterNames.SEARCH_GESTION.equalsIgnoreCase(action)) {
			try {

				String idGestion = request.getParameter(ParameterNames.ID_GESTION);
				String idEmpresa = request.getParameter(ParameterNames.ID_EMPRESA);
				String fechaInicio = request.getParameter(ParameterNames.FECHA_INICIO_GESTION);
				String nombreEmpleado = request.getParameter(ParameterNames.NOMBRE_EMPLEADO);
				String apellidoEmpleado = request.getParameter(ParameterNames.APELLIDO_EMPLEADO);
				String docCliente = request.getParameter(ParameterNames.DOC_CLIENTE);
				String nombreCliente = request.getParameter(ParameterNames.NOMBRE_CLIENTE);
				String tlf = request.getParameter(ParameterNames.TLF);
				String correo = request.getParameter(ParameterNames.CORREO);
				Date inicioDate = null;

				GestionCriteria criteria = new GestionCriteria();
				if (!StringUtils.isEmpty(idGestion)) {
					criteria.setIdGestion(Long.valueOf(idGestion));
					request.setAttribute(AttributeNames.ID_GESTION, idGestion);
				}
				if (!StringUtils.isEmpty(idEmpresa)) {
					criteria.setIdEmpresa(Long.valueOf(idEmpresa));
					request.setAttribute(AttributeNames.EMPRESA_GESTION, idEmpresa);
				}
				if (!StringUtils.isEmpty(fechaInicio)) {
					inicioDate = new SimpleDateFormat("yyyy-MM-dd").parse(fechaInicio);
					criteria.setFechaInicio(inicioDate);
					request.setAttribute(AttributeNames.FECHA_INICIO, fechaInicio);
				}
				if (!StringUtils.isEmpty(nombreEmpleado)) {
					criteria.setCriteriaNombreEmpleado(nombreEmpleado);
					request.setAttribute(AttributeNames.NOMBRE_EMPLEADO, nombreEmpleado);
				}
				if (!StringUtils.isEmpty(apellidoEmpleado)) {
					criteria.setCriteriaApellidoEmpleado(apellidoEmpleado);
					request.setAttribute(AttributeNames.APELLIDO_EMPLEADO, apellidoEmpleado);
				}
				if (!StringUtils.isEmpty(docCliente)) {
					criteria.setCriteriaCodIdentidad(docCliente);
					request.setAttribute(AttributeNames.DOC_CLIENTE, docCliente);
				}
				if (!StringUtils.isEmpty(nombreCliente)) {
					criteria.setCriteriaNombreCliente(nombreCliente);
					request.setAttribute(AttributeNames.NOMBRE_CLIENTE, nombreCliente);
				}
				if (!StringUtils.isEmpty(tlf)) {
					criteria.setCriteriaTlf(tlf);
					request.setAttribute(AttributeNames.TLF_CLIENTE, tlf);
				}
				if (!StringUtils.isEmpty(correo)) {
					criteria.setCriteriaCorreo(correo);
					request.setAttribute(AttributeNames.CORREO_CLIENTE, correo);
				}

				List<Ticket> ticketsG = new ArrayList<>();
				List<Cliente> clientesG = new ArrayList<>();
				List<Gestion> gestiones = gestionService.findByCriteria(criteria, locale.getLanguage(), 1,
						Integer.MAX_VALUE);

				// Añadimos empleados
				List<Empleado> empleadosG = new ArrayList<>();
				EmpleadoCriteria criteriaEmpleado = new EmpleadoCriteria();

				for (Gestion g : gestiones) {
					if (logger.isDebugEnabled()) {
						logger.debug("Result :" + ToStringUtil.toString(g));
					}
					ticketsG.add(g.getTickets().get(0));
					clientesG.add(clienteService.findById(g.getIdCliente(), locale.getLanguage()));
					criteriaEmpleado.setIdGestionCriteria(g.getIdGestion());
					empleadosG.add(empleadoService.findByCriteria(criteriaEmpleado, locale.getLanguage(), 1, Integer.MAX_VALUE).get(0));
				}
				if (gestiones.isEmpty()) {
					request.setAttribute(AttributeNames.ERROR, Errors.NOT_FOUND_ERROR);
					target = ViewPaths.GESTION_SEARCH_SERVLET;

				} else {
					request.setAttribute(AttributeNames.GESTIONES, gestiones);
					request.setAttribute(AttributeNames.TICKETS, ticketsG);
					request.setAttribute(AttributeNames.EMPLEADOS, empleadosG);
					request.setAttribute(AttributeNames.CLIENTES, clientesG);
					target = ViewPaths.GESTION_SEARCH_SERVLET;
					if (logger.isDebugEnabled()) {
						logger.debug("Result :" + ToStringUtil.toString(gestiones));
					}
				}

			} catch (Exception e) {
				logger.error(e.getMessage(), e);
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				target = ViewPaths.GESTION_SEARCH_SERVLET;
			}

		}
		if (ParameterNames.POST_SEARCH_GESTION.equalsIgnoreCase(action)) {

			try {
				
				List<Ticket> tickets = ticketService.findByGestion(Long.valueOf(request.getParameter(ParameterNames.ID_GESTION)));
				List<Contacto> contactosT = new ArrayList<>();

				// Añadimos empleados
				List<Empleado> empleadosT = new ArrayList<>();
				EmpleadoCriteria criteriaEmpleado = new EmpleadoCriteria();
				for (Ticket t : tickets) {
					criteriaEmpleado.setIdTicketCriteria(t.getIdTicket());
					empleadosT.add(empleadoService.findByCriteria(criteriaEmpleado, locale.getLanguage(), 1, Integer.MAX_VALUE).get(0));
					contactosT.add(contactoService.findById(t.getIdContacto(), locale.getLanguage()));
				}
				if (tickets.isEmpty()) {
					request.setAttribute(AttributeNames.ERROR, Errors.TICKET_NOT_FOUND);
					target = ViewPaths.GESTION_SEARCH_SERVLET;

				} else {
					request.setAttribute(AttributeNames.ID_GESTION, Long.valueOf(request.getParameter(ParameterNames.ID_GESTION)));
					request.setAttribute(AttributeNames.TICKETS, tickets);
					request.setAttribute(AttributeNames.EMPLEADOS, empleadosT);
					request.setAttribute(AttributeNames.CONTACTOS, contactosT);
					target = ViewPaths.GESTION_DETAILS_SERVLET;
					if (logger.isDebugEnabled()) {
						logger.debug("Result :" + ToStringUtil.toString(tickets));
					}
				}

			} catch (DataException e) {
				logger.error(e.getMessage(), e);
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				target = ViewPaths.GESTION_SEARCH_SERVLET;
			} catch (NumberFormatException e) {
				logger.error(e.getMessage(), e);
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				target = ViewPaths.GESTION_SEARCH_SERVLET;
			}

		}
		if (ParameterNames.TICKET_DETAIL.equalsIgnoreCase(action)) {

			try {
				Gestion gestionT = gestionService.findById(Long.valueOf(request.getParameter(ParameterNames.ID_GESTION)), locale.getLanguage());
				Cliente clienteT = clienteService.findById(gestionT.getIdCliente(), locale.getLanguage());
				Empleado empleadoT = empleadoService.findByUsuario(request.getParameter(ParameterNames.USER_EMPLEADO),locale.getLanguage());
				Ticket ticket = ticketService.findById(Long.valueOf(request.getParameter(ParameterNames.ID_TICKET)));
				Contacto contactoT = contactoService.findById(ticket.getIdContacto(), locale.getLanguage());
				request.setAttribute(AttributeNames.ID_GESTION,Long.valueOf(request.getParameter(ParameterNames.ID_GESTION)));
				request.setAttribute(AttributeNames.TICKETS, ticket);
				request.setAttribute(AttributeNames.EMPLEADOS, empleadoT);
				request.setAttribute(AttributeNames.CONTACTOS, contactoT);
				request.setAttribute(AttributeNames.CLIENTES, clienteT);
				target = ViewPaths.TICKET_DETAILS;

			} catch (DataException e) {
				logger.error(e.getMessage(), e);
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				target = ViewPaths.GESTION_SEARCH_SERVLET;
			}

		}
		request.getRequestDispatcher(target).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
