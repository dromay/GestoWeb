<%@page import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.web.util.*, com.gesto.ecommerce.web.controller.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="empleado" value="${sessionScope.user}" scope="page"/>

<c:choose>
    <c:when test="${not empty empleado}">
      <div class="col-sm-2 sidenav">
            <br>
            <nav class="nav nav-pills flex-column flex-sm-col nav-fill">
  				<a class="flex-sm-fill text-sm-center nav-link" href="<%=ViewPaths.GESTION_SEARCH%>"><fmt:message key="gestion" bundle="${messages}"/></a>
  				<a class="flex-sm-fill text-sm-center nav-link" href="<%=ViewPaths.EMPLOYEE_SEARCH%>"><fmt:message key="empleado" bundle="${messages}"/></a>
  				<a class="flex-sm-fill text-sm-center nav-link" href="<%=ViewPaths.CLIENT_SEARCH%>"><fmt:message key="cliente" bundle="${messages}"/></a>
  				<a class="flex-sm-fill text-sm-center nav-link" href="<%=ViewPaths.MAIL%>"><fmt:message key="correo" bundle="${messages}"/></a>
			</nav>
       </div>
    </c:when>
    <c:otherwise>
        <div class="col-sm-2 sidenav">
            <br>
        </div>
    </c:otherwise>
</c:choose>
	
