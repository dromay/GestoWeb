package com.gesto.ecommerce.web.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.gesto.ecommerce.exceptions.DataException;
import com.gesto.ecommerce.model.Hotel;
import com.gesto.ecommerce.service.XMLService;
import com.gesto.ecommerce.service.impl.XMLServiceImpl;
import com.gesto.ecommerce.web.util.Errors;

/**
 * Servlet implementation class XML
 */
@WebServlet("/XML")
public class XMLServlet extends HttpServlet {
	
	private static Logger logger = LogManager.getLogger(XMLServlet.class.getName());
	
	private XMLService xmlService = null;
	
    public XMLServlet() {
        super();
        xmlService = new XMLServiceImpl();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			String target = null;
			try {
			List<Hotel> xml_request = xmlService.XMLRequest();
			request.setAttribute(AttributeNames.HOTELES, xml_request);
			response.getWriter().append("Served at: ").append(request.getContextPath());
			
			} catch (DataException e) {
				request.setAttribute(AttributeNames.ERROR, Errors.GENERIC_ERROR);
				logger.error(e.getMessage(), e);
			}
			target = ViewPaths.XML;		
			request.getRequestDispatcher(target).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
