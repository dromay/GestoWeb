<%@include file="/html/common/header.jsp"%>
<%@ page import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.service.*, com.gesto.ecommerce.service.impl.*, java.util.*" %>
	<div>
        <%    
        String u = String.valueOf(request.getParameter("usuario"));
        EmpleadoService empleadoService = new EmpleadoServiceImpl();
        Empleado e = empleadoService.findByUsuario(u); %>
	<!--           <h3><%=e.getTituloCortesia()%>&nbsp;<%=e.getNombre()%>&nbsp; <%=e.getApellido()%></h3><br>
            <img src="C:/Users/danie/Desktop/apache-tomcat-9.0.2/webapps/Empleado/images/shippers/<%=e.getNombre()%>.png" alt="Logo <%=e.getNombre()%>"/><br><br>
            <p><strong>Titulo:&nbsp;</strong><%=e.getTitulo()%></p><br>
            <p><strong>Fecha&nbsp;Nacimiento:&nbsp;</strong><%=e.getNacimiento()%></p><br> 
            <p><strong>Fecha&nbsp;Alta:&nbsp;</strong><%=e.getAlta()%></p><br> 
            <p><strong>Direccion:&nbsp;</strong><%=e.getDireccion()%></p><br> 
            <p><strong>Ciudad:&nbsp;</strong><%=e.getCiudad()%></p><br> 
            <p><strong>Region:&nbsp;</strong><%=e.getRegion()%></p><br>
            <p><strong>Codigo&nbsp;Postal:&nbsp;</strong><%=e.getCodigoPostal()%></p><br> 
            <p><strong>Pais:&nbsp;</strong><%=e.getPais()%></p><br> 
            <p><strong>Telefono:&nbsp;</strong><%=e.getTelefonoFijo()%></p><br> 
            <p><strong>Extension:&nbsp;</strong><%=e.getExtension()%></p><br> 
            <p><strong>Salario:&nbsp;</strong><%=e.getSalario()%></p><br>   -->
     </div>       
<%@include file="/html/common/footer.jsp"%>