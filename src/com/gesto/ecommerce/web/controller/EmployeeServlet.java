package com.gesto.ecommerce.web.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gesto.ecommerce.model.Empleado;
import com.gesto.ecommerce.service.EmpleadoService;
import com.gesto.ecommerce.service.impl.EmpleadoServiceImpl;


/**
 * Servlet implementation class EmployeeServlet
 */
@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	private EmpleadoService empleadoService = null;
	
    public EmployeeServlet() {
        super();
        empleadoService = new EmpleadoServiceImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usuario = request.getParameter("usuario");
		
		String target = null;
		
		try {
			Empleado empleados = empleadoService.findByUsuario(usuario);			
			if (usuario==null || usuario=="") {
				request.setAttribute("error", "Introduce datos de busqueda");
				target = "/html/employee/employee-search.jsp";
			} else {				
					request.setAttribute("empleados", empleados);			
					target = "/html/employee/employee-search.jsp";
			}

		 
			request.getRequestDispatcher(target).forward(request, response);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO Pendiente de explicar
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
