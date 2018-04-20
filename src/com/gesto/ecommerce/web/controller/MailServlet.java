package com.gesto.ecommerce.web.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.gesto.ecommerce.config.ConfigurationManager;
import com.gesto.ecommerce.exceptions.MailException;
import com.gesto.ecommerce.service.EmpleadoService;
import com.gesto.ecommerce.service.impl.EmpleadoServiceImpl;
import com.gesto.ecommerce.web.util.Errors;
import com.gesto.ecommerce.web.util.SessionManager;
import com.gesto.ecommerce.web.util.Success;

@WebServlet("/MailServlet")
public class MailServlet extends HttpServlet {
	private static Logger logger = LogManager.getLogger(MailServlet.class.getName());

	//private MockService mockService = null;
	//
	
	public MailServlet() {
		super();
		//mockService = new MockServiceImpl();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String subject = request.getParameter(ParameterNames.SUBJECT);
		String message = request.getParameter(ParameterNames.MESSAGE);
		String to = request.getParameter(ParameterNames.TO);
		boolean hasErrors = false;
		String target = null;
		

			if (StringUtils.isEmpty(subject)) {
				hasErrors = true;
				request.setAttribute(AttributeNames.ERROR_SUBJECT, Errors.REQUIRED_FIELD_ERROR);
			}
			if (StringUtils.isEmpty(message)) {
				hasErrors = true;
				request.setAttribute(AttributeNames.ERROR_MESSAGE, Errors.REQUIRED_FIELD_ERROR);
			}
			if (StringUtils.isEmpty(to)) {
				hasErrors = true;
				request.setAttribute(AttributeNames.ERROR_TO, Errors.REQUIRED_FIELD_ERROR);
			}

			if (hasErrors) {
				// Si hay errores.. se los muestro y no continuo
				request.setAttribute(AttributeNames.ERROR, Errors.SEND_MAIL);
				target = ViewPaths.SEND_MAIL;
			} else {
				
				ConfigurationManager cfg = ConfigurationManager.getInstance();
				SimpleEmail email = new SimpleEmail();
				try {
					//mockService.sendMail(subject, message, to);
					email.setHostName("smtp.gmail.com");

					email.setSmtpPort(465);

					email.setAuthenticator(
							new DefaultAuthenticator(
									"GestoMailAtencion",
									"1234abcd0"
									));
					email.setSSLOnConnect(true);
					email.setFrom("no-reply@gmail.com");			
					email.setSubject(subject);
					email.setMsg(message);
					email.addTo(to);
					email.send();
					//target = "/html/gestion/gestion-search.jsp";
					target = ViewPaths.SEND_MAIL;
					request.setAttribute(AttributeNames.SUCCESS, Success.MAIL);
				} catch (EmailException e) {
					request.setAttribute(AttributeNames.ERROR, Errors.SEND_MAIL);
					target = ViewPaths.SEND_MAIL;
					try {
						throw new MailException ("Trying to send email "
								+ " from " + cfg.getParameter("no-reply@gmail.com")
								+ " using hostname "+cfg.getParameter("smtp.gmail.com")
								+ " to " + request.getParameter(ParameterNames.TO), e);
					} catch (MailException e1) {
						logger.error(e1.getMessage(), e1);
						request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
						target = ViewPaths.SEND_MAIL;
					}
				}
			}
			
		request.setAttribute(AttributeNames.SUBJECT, subject);
		request.setAttribute(AttributeNames.MESSAGE, message);
		request.setAttribute(AttributeNames.TO, to);
		request.getRequestDispatcher(target).forward(request, response);
		}
		
	
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
