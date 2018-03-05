<%@include file="/html/common/header.jsp"%>
<%@ page import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.service.*, com.gesto.ecommerce.service.impl.*, java.util.*" %>

            <% 
            String usuario = request.getParameter("usuario");
            if(usuario==null) {usuario="";}
            %>
        <h3>Busqueda</h3>
        <form action="/GestoWeb/EmployeeServlet" method="post">
            <input type="text" name="usuario" placeholder="Usuario del empleado"> <br>
            <input type="submit" value="submit">
        </form>
        <ul>
         	<% 	if (usuario!=null && usuario!=""){
                		List<Empleado> empleados = (List<Empleado>) request.getAttribute("usuario");
                        for (Empleado e: empleados){
                            %><li><a href="/GestoWeb/html/employee/employee-details.jsp?id=<%=e.getUsuario()%>"><%=e.getNombre()%></a></li><%
                        }
                }
         	else{
         		%><p><%=request.getAttribute("error")%></p><%
         	}
      		%>
            </ul>
<%@include file="/html/common/footer.jsp"%>