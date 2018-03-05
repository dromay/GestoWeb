<%@page import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.web.model.*, com.gesto.ecommerce.web.util.*, com.gesto.ecommerce.web.controller.*" %>

<%

	Empleado empleado = (Empleado) SessionManager.get(request, SessionAttributeNames.USER);
	if (empleado!=null) {
		%>
		<p><%=empleado.getNombre() + " "+empleado.getApellido()%>
		<p><a href="/GestoWeb/SignOutServlet">Salir</a></p>
		<%
	} else {
		%>
		<a href="/GestoWeb/html/signin/signin.jsp">Identifícate</a>
		<%
	}
%>

