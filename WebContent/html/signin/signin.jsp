<%@include file="/html/common/header.jsp"%>

<h3>Autenticaci�n</h3>
<%
	String error = (String) request.getAttribute("error");
	if (error!=null) {
		%><%=error%><%
	}
%>
<form action="/GestoWeb/SignInServlet" method="post">
	<input type="text" name="user" placeholder="Usuario"/>
	<br/>
	<input type="password" name="password" placeholder="Contrase�a"/>	
	<br/>  			
	<input type="submit" value="Submit">	
</form>

<%@include file="/html/common/footer.jsp"%>