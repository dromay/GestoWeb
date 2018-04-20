package com.gesto.ecommerce.web.controller;

public interface ParameterNames {

	// Nombre del parametro acción en las jsps y servlets
	public static final String ACTION = "action";

	// Nombres de las acciones
	public static final String CREATE_GESTION = "create";
	public static final String CREATE_TICKET = "save";
	public static final String SEARCH = "search";
	public static final String SEARCH_GESTION = "searchgestion";
	public static final String SEARCH_EMPLEADO = "searchempleado";
	public static final String SEARCH_CLIENTE = "searchcliente";
	public static final String PRECREATE_GESTION = "precreate";
	public static final String PRECREATE_TICKET = "presave";
	public static final String TICKET_DETAIL = "ticketdetail";
	public static final String EMPLEADO_DETAIL = "empleadodetail";
	public static final String CLIENTE_DETAIL = "clientedetail";

	// Cliente
	public static final String ID_CLIENTE = "idcliente";
	public static final String NOMBRE_CLIENTE = "nombrecliente";
	public static final String TLF = "telefono";
	public static final String TIPO_CLIENTE = "tipocliente";

	// Gestion
	public static final String ID_GESTION = "idgestion";
	public static final String TIPO_GESTION = "tipogestion";

	// Idioma
	public static final String IDIOMA = "idioma";

	// Ticket
	public static final String COMENTARIO = "comentario";
	public static final String FECHA_INICIO = "fecha-inicio";
	public static final String ID_TICKET = "idticket";
	public static final String TIEMPO_TOTAL = "tiempototal";

	// Empleado
	public static final String ID_EMPLEADO = "idempleado";
	public static final String USER_EMPLEADO = "usuario";
	public static final String USER_SUPERVISOR = "usuariosupervisor";
	public static final String PASSWORD = "password";
	public static final String NOMBRE_EMPLEADO = "nombreempleado";
	public static final String APELLIDO_EMPLEADO = "extdepartamento";
	public static final String EXT = "extension";
	public static final String EXT_DEPARTAMENTO = "extdepartamento";
	public static final String DEPARTAMENTO = "departamento";

	// Contacto
	public static final String ID_CONTACTO = "idcontacto";
	public static final String NOMBRE_CONTACTO = "nombrecontacto";
	public static final String APELLIDO_CONTACTO = "apellidocontacto";

	public static final String ID_EMPRESA = "idempresa";

	public static final String TLF_RECEPTOR = "tlfreceptor";

	public static final String FECHA_INICIO_GESTION = "iniciogestion";

	public static final String DOC_CLIENTE = "doccliente";

	public static final String CORREO = "correo";

	public static final String CREATE_CALL = "createcall";

	public static final String DELETE_CALL = "deletecall";
	
	public static final String POST_SEARCH_GESTION = "postsearch";

	public static final String SUBJECT = "subject";

	public static final String MESSAGE = "message";

	public static final String TO = "to";

	public static final String LOCALE = "locale";


}
