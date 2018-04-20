<%@include file="/html/common/header.jsp"%>
<%@ page
	import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.service.*, com.gesto.ecommerce.service.impl.*, java.util.*"%>

<c:set var="error" value="${requestScope.error}" scope="page" />
<c:set var="userempl" value="${requestScope.userempl}" scope="page" />
<c:set var="nombre" value="${requestScope.nombreempleado}" scope="page" />
<c:set var="apellido" value="${requestScope.apellidoempleado}" scope="page" />
<c:set var="idGestion" value="${requestScope.idgestion}" scope="page" />
<c:set var="ext" value="${requestScope.extempleado}" scope="page" />
<c:set var="idiomas" value="${sessionScope.languages}" scope="page" />
<c:set var="departamentos" value="${sessionScope.departments}" scope="page" />
<c:set var="empleados" value="${requestScope.empleado}" scope="page" />
<c:set var="supervisores" value="${requestScope.supervisores}" scope="page" />

<h1>
	<fmt:message key="empleado" bundle="${messages}" />
</h1>
<br>

<c:if test="${not empty error}">
	<div class="alert alert-danger">
		<strong><fmt:message key="${error}" bundle="${messages}"/></strong>
	</div>
</c:if>

<div class="jumbotron">
	<form action="/GestoWeb/EmployeeServlet" method="post">
		<input type="hidden" name="<%=ParameterNames.ACTION%>"
			value="<%=ParameterNames.SEARCH_EMPLEADO%>" />
		<div class="form-row">
			<div class="form-group col-md-2"></div>
			<div class="form-group col-md-2">
				<label for="usuario"><fmt:message key="usuario"
						bundle="${messages}" /></label> <input type="text" class="form-control"
					id="usuario"  value="<c:out value="${userempl}"/>"
					name="<%=ParameterNames.USER_EMPLEADO%>" />
			</div>
			<div class="form-group col-md-2">
				<label for="ext"><fmt:message key="extension"
						bundle="${messages}" /></label> <input type="text" class="form-control"
					id="ext"  value="<c:out value="${ext}"/>" name="<%=ParameterNames.EXT%>" />
			</div>
			<div class="form-group col-md-2">
				<label for="nombreEmpleado"><fmt:message key="nombre"
						bundle="${messages}" /></label> <input type="text" class="form-control"
					id="nombreEmpleado"  value="<c:out value="${nombre}"/>"
					name="<%=ParameterNames.NOMBRE_EMPLEADO%>" />
			</div>
			<div class="form-group col-md-2">
				<label for="apellido"><fmt:message key="apellido"
						bundle="${messages}" /></label> <input type="text" class="form-control"
					id="apellido"  value="<c:out value="${apellido}"/>"
					name="<%=ParameterNames.APELLIDO_EMPLEADO%>" />
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-2"></div>
			<div class="form-group col-md-2">
				<label for="idioma"><fmt:message key="idioma"
						bundle="${messages}" /></label> <select class="form-control" id="idioma"
					name="<%=ParameterNames.IDIOMA%>">
					<option></option>
					<c:forEach items="${idiomas}" var="idioma">
						<option value="<c:out value="${idioma.idIdioma}"/>"><c:out
								value="${idioma.descripcion}" /></option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group col-md-1"></div>
			<div class="form-group col-md-2">
				<label for="idGes">ID <fmt:message key="gestion"
						bundle="${messages}" /></label> <input type="number" class="form-control"
					id="idGes"  value="<c:out value="${idGestion}"/>"
					name="<%=ParameterNames.ID_GESTION%>" />
			</div>
			<div class="form-group col-md-1"></div>
			<div class="form-group col-md-2">
				<label for="departamento"><fmt:message key="departamento"
						bundle="${messages}" /></label> <select class="form-control"
					id="departamento" name="<%=ParameterNames.DEPARTAMENTO%>">
					<option></option>
					<c:forEach items="${departamentos}" var="departamento">
						<option value="<c:out value="${departamento.extDepartamento}"/>"><c:out
								value="${departamento.descripcion}" /></option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-5"></div>
			<div class="form-group col-md-2">
				<button type="submit" class="btn btn-dark">
					<fmt:message key="empleado.buscar" bundle="${messages}" />
				</button>
			</div>
		</div>
	</form>
</div>



<hr>
<br>
<div class="table-responsive">
	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th><fmt:message key="usuario" bundle="${messages}" /></th>
				<th><fmt:message key="nombre" bundle="${messages}" /></th>
				<th><fmt:message key="apellido" bundle="${messages}" /></th>
				<th><fmt:message key="extension" bundle="${messages}" /></th>
				<th><fmt:message key="supervisor" bundle="${messages}" /></th>
				<th></th>
			</tr>
		</thead>
		<c:if test='${not empty empleados}'>
			<tbody>
				<c:forEach items="${empleados}" var="empleado" varStatus="status">
					<tr>
						<td><c:out value="${empleado.usuario}" /></td>
						<td><c:out value="${empleado.nombre}" /></td>
						<td><c:out value="${empleado.apellido}" /></td>
						<td><c:out value="${empleado.ext}" /></td>
						<td><c:out value="${supervisores[status.index].nombre}" /></td>
						<td>
							<form action="/GestoWeb/EmployeeServlet" method="post">
								<input type="hidden" name="<%=ParameterNames.ACTION%>"
									value="<%=ParameterNames.EMPLEADO_DETAIL%>" /> <input
									type="hidden" name="<%=ParameterNames.USER_EMPLEADO%>"
									value="<c:out value="${empleado.usuario}"/>" />
								<button type="submit" class="btn btn-dark">
									<fmt:message key="empleado.ver" bundle="${messages}" />
								</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<p>
				<c:out value="${fn:length(empleados)}" />
				<fmt:message key="resultados" bundle="${messages}" />
			</p>
		</c:if>
	</table>
</div>
<%@include file="/html/common/footer.jsp"%>