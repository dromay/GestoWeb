package com.gesto.ecommerce.web.controller;

public interface ViewPaths {
	
	// JSP
	
	public static final String SIGN_IN = "/GestoWeb/html/signin/signin.jsp";
	public static final String SIGN_IN_SERVLET = "/html/signin/signin.jsp";
	public static final String INDEX = "/html/index.jsp";
	public static final String INDEX_ASIDE = "/GestoWeb/html/index.jsp";
	public static final String EMPLOYEE_SEARCH ="/GestoWeb/html/employee/employee-search.jsp";
	public static final String EMPLOYEE_SEARCH_SERVLET ="/html/employee/employee-search.jsp";
	public static final String EMPLOYEE_DETAIL ="/GestoWeb/html/employee/employee-details.jsp";
	public static final String EMPLOYEE_DETAIL_SERVLET ="/html/employee/employee-details.jsp";
	public static final String CLIENT_SEARCH ="/GestoWeb/html/client/client-search.jsp";
	public static final String CLIENT_SEARCH_SERVLET ="/html/client/client-search.jsp";
	public static final String CLIENT_DETAIL ="/GestoWeb/html/client/client-details.jsp";
	public static final String CLIENT_DETAIL_SERVLET ="/html/client/client-details.jsp";
	public static final String TICKET_CREATE ="/html/ticket/create-ticket.jsp";
	public static final String TICKET_DETAILS ="/html/ticket/ticket-details.jsp";
	public static final String GESTION_SEARCH ="/GestoWeb/html/gestion/gestion-search.jsp";
	public static final String GESTION_SEARCH_DETAIL ="/html/gestion/gestion-search.jsp";
	public static final String GESTION_DETAILS ="/html/gestion/gestion-details.jsp";
	public static final String GESTION_DETAILS_DETAIL ="/html/gestion/gestion-details.jsp";
	public static final String MAIL ="/GestoWeb/html/mail/send-mail.jsp";
	public static final String SEND_MAIL ="/html/mail/send-mail.jsp";
	public static final String XML ="/GestoWeb/html/xml/xml.jsp";
	
	// Servlet
	
	public static final String USER_SIGN_IN = "/GestoWeb/user?action=sign-in";
	public static final String USER_SIGN_OUT = "/GestoWeb/user?action=sign-out";
	public static final String USER_CREATE_CALL = "/GestoWeb/user?action=create-call";
	public static final String USER_DELETE_CALL = "/GestoWeb/user?action=delete-call";
	public static final String USER_CHANGE_LOCALE_ES_ES = "/GestoWeb/user?action=change-locale&locale=es-ES";
	public static final String USER_CHANGE_LOCALE_GL_ES = "/GestoWeb/user?action=change-locale&locale=gl-ES";
	public static final String USER_CHANGE_LOCALE_EN = "/GestoWeb/user?action=change-locale&locale=en";
	public static final String TICKET = "/GestoWeb/TicketServlet";
	
	
	
	
	
	
	
}
