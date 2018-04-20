<%@page import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.web.util.*, com.gesto.ecommerce.web.controller.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.web.controller.*"%>

	<c:set var="empleado" value="${sessionScope.user}" scope="page"/>
	<c:set var="cliente" value="${sessionScope.client}" scope="page"/>
	<c:set var="empresa" value="${sessionScope.company}" scope="page"/>
	<c:set var="contacto" value="${sessionScope.contact}" scope="page"/>

	<c:choose>
		<c:when test="${not empty empleado}">
			<div class="col-sm-2 header">
			<p style="padding-top:10%;"><img src="/GestoWeb/images/dynamic/<c:out value="${empleado.idEmpleado}"/>.jpg" alt="Logo <c:out value="${empleado.nombre}"/> " height="48" width="45" title="Logo <c:out value="${empleado.nombre}"/>"/> <c:out value="${empleado.nombre}"/> <c:out value="${empleado.apellido}"/></p>
			<c:choose>
					<c:when test="${not empty cliente || not empty empresa}">
						<a href="<%=ViewPaths.USER_DELETE_CALL%>">
							<i class="fas fa-phone-slash fa-2x" style="color:Red;padding-left:2%;"></i>
						</a>
					</c:when>	      
					<c:otherwise>
						<a href="<%=ViewPaths.USER_CREATE_CALL%>">
					    	<i class="fas fa-phone fa-2x" style="color:Green;padding:2%;"></i>
					    </a>
					</c:otherwise>
			</c:choose>	
			<a href="<%=ViewPaths.USER_SIGN_OUT%>"><i class="fas fa-sign-out-alt fa-2x" style="color:White;padding-left:20%;"></i></a>
			</div>
		</c:when>	      
		<c:otherwise>
			<div class="col-sm-2 header"  >
				<a href="<%=ViewPaths.SIGN_IN%>"><i class="fas fa-sign-in-alt fa-3x" style="color:White;line-height: 2.6;"></i></a>
				<br>
				<a href="/GestoWeb/user?action=change-locale&locale=gl">GL</a>
	|			<a href="/GestoWeb/user?action=change-locale&locale=es">ES</a>
	|			<a href="/GestoWeb/user?action=change-locale&locale=en">EN</a>
    |			<a href="/GestoWeb/user?action=change-locale&locale=fr">FR</a>
			</div>
		</c:otherwise>
	</c:choose>	
	

