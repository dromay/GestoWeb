package com.gesto.ecommerce.web.util;

public interface Errors {
	// Codigos de error
		public static final String GENERIC_ERROR = "error.generico";
		public static final String MISSING_PARAMETER_ERROR = "error.missing";
		public static final String DUPLICATE_PARAMETER_ERROR = "error.duplicate";
		public static final String REQUIRED_FIELD_ERROR = "error.requerido";		
		public static final String USER_NOT_FOUND_ERROR = "error.user_not_found";
		public static final String INCORRECT_PASSWORD_ERROR = "error.login";
		public static final String ACCESS_ERROR = "error.acceso";
		public static final Object CLIENT_NOT_FOUND_ERROR = "error.cliente";
		public static final Object NOT_FOUND_ERROR = "error.busqueda";
		public static final Object NOT_CALL = "error.nocall";
		public static final Object DIFFERENT_CALL = "error.llamada.dif";
		public static final Object TICKET_CREATE = "error.ticket.crear";
		public static final Object MANAGEMENT_CREATE = "error.gestion.crear";
		public static final Object TICKET_NOT_FOUND = "error.ticket.buscar";
		public static final Object DATE_NOT_CREATED = "Date not parsed";
		public static final Object SEND_MAIL = "error.correo";
		public static final Object NOT_FOUND_CALL = "error.call";
		
}
