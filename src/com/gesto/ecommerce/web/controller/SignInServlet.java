package com.gesto.ecommerce.web.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gesto.ecommerce.model.User;
import com.gesto.ecommerce.service.UserService;
import com.gesto.ecommerce.service.impl.MockUserServiceImpl;
import com.gesto.ecommerce.util.PasswordEncryptionUtil;
import com.gesto.ecommerce.web.util.SessionManager;

/**
 * Servlet para Autentification.
 */
@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {    

	private UserService userService = null;
	
    public SignInServlet() {
        super();
        userService = new MockUserServiceImpl();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter(ParameterNames.USER);
		String password = request.getParameter(ParameterNames.PASSWORD);
					
		String target = null;
		boolean redirect = false;
		try {
			User user = userService.findUserById(userName);			
			if (user==null) {
				request.setAttribute(AttributeNames.ERROR, AttributeNames.USER_NOT_FOUND_ERROR);
				target = ViewsPaths.SIGN_IN;
			} else {				
				if (!PasswordEncryptionUtil.checkPassword(password,user.getEncryptedPassword())) {
					request.setAttribute(AttributeNames.ERROR, "Contraseña incorrecta");			
					target = ViewsPaths.SIGN_IN;
				} else {
					SessionManager.set(request, SessionAttributeNames.USER, user);
					target = ViewsPaths.INDEX;
					// Explicar mejor redirect aqui y por que
					redirect = true;
				}
			}
			if (redirect) {
				response.sendRedirect(target);
			} else {
				request.getRequestDispatcher(target).forward(request, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO Pendiente de explicar
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
