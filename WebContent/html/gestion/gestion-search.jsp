<%@include file="/html/common/header.jsp"%>
<%@ page
	import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.service.*, com.gesto.ecommerce.service.impl.*, java.util.*"%>

<c:set var="error" value="${requestScope.error}" scope="page" />
<c:set var="success" value="${requestScope.success}" scope="page" />
<c:set var="gestiones" value="${requestScope.gestiones}" scope="page" />
<c:set var="tickets" value="${requestScope.tickets}" scope="page" />
<c:set var="empleados" value="${requestScope.empleados}" scope="page" />
<c:set var="clientes" value="${requestScope.clientes}" scope="page" />


<c:set var="idGestion" value="${requestScope.idgestion}" scope="page" />
<c:set var="fechaInicio" value="${requestScope.fechainicio}" scope="page" />
<c:set var="nombreEmpleado" value="${requestScope.nombreempleado}" scope="page" />
<c:set var="apellidoEmpleado" value="${requestScope.apellidoempleado}" scope="page" />
<c:set var="nombreCliente" value="${requestScope.nombrecliente}" scope="page" />
<c:set var="doc" value="${requestScope.doccliente}" scope="page" />
<c:set var="tlf" value="${requestScope.tlfcliente}" scope="page" />
<c:set var="correo" value="${requestScope.correocliente}" scope="page" />

<h1>
	<fmt:message key="gestion" bundle="${messages}" />
</h1>
<br>

<c:if test="${not empty error}">
	<div class="alert alert-danger">
		<strong><fmt:message key="${error}" bundle="${messages}"/></strong>
	</div>
</c:if>

<c:if test="${not empty success}">
	<div class="alert alert-success">
		<strong><fmt:message key="${success}" bundle="${messages}"/></strong>
	</div>
</c:if>

<form action="/GestoWeb/TicketServlet" method="post">
	<input type="hidden" name="<%=ParameterNames.ACTION%>"
		value="<%=ParameterNames.PRECREATE_GESTION%>" />
	<button type="submit" class="btn btn-dark">
		<fmt:message key="gestion.crear" bundle="${messages}" />
	</button>
</form>
<br>

<div class="jumbotron">
	<form action="/GestoWeb/TicketServlet" method="post">
		<input type="hidden" name="<%=ParameterNames.ACTION%>"
			value="<%=ParameterNames.SEARCH_GESTION%>" />
		<div class="form-row">
			<div class="form-group col-md-2">
				<label for="idGestion">ID <fmt:message key="gestion"
						bundle="${messages}" /></label> <input type="number" class="form-control"
					id="idGestion" value="<c:out value="${idGestion}"/>"
					name="<%=ParameterNames.ID_GESTION%>">
			</div>
			<div class="form-group col-md-2">
				<label for="fechaInicio"><fmt:message key="fecha.inicio"
						bundle="${messages}" /></label> <input type="date" class="form-control"
					id="fechaInicio" name="<%=ParameterNames.FECHA_INICIO_GESTION%>">
			</div>
			<div class="form-group col-md-4"></div>
			<div class="form-group col-md-2">
				<label for="nombreCliente"><fmt:message key="cliente.nombre"
						bundle="${messages}" /></label> <input type="text" class="form-control"
					id="nombreCliente" value="<c:out value="${nombreCliente}"/>"
					name="<%=ParameterNames.NOMBRE_CLIENTE%>">
			</div>
			<div class="form-group col-md-2">
				<label for="codigoCliente"><fmt:message key="documento"
						bundle="${messages}" /></label> <input type="text" class="form-control"
					id="codigoCliente" value="<c:out value="${doc}"/>"
					name="<%=ParameterNames.DOC_CLIENTE%>">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-2">
				<label for="nombreEmpleado"><fmt:message
						key="empleado.nombre" bundle="${messages}" /></label> <input type="text"
					class="form-control" id="nombreEmpleado"
					value="<c:out value="${nombreEmpleado}"/>"
					name="<%=ParameterNames.NOMBRE_EMPLEADO%>">
			</div>
			<div class="form-group col-md-2">
				<label for="apellidoEmpleado"><fmt:message
						key="empleado.apellido" bundle="${messages}" /></label> <input
					type="text" class="form-control" id="apellidoEmpleado"
					value="<c:out value="${apellidoEmpleado}"/>"
					name="<%=ParameterNames.APELLIDO_EMPLEADO%>">
			</div>
			<div class="form-group col-md-4"></div>
			<div class="form-group col-md-2">
				<label for="tlf"><fmt:message key="cliente.telefono"
						bundle="${messages}" /></label> <input type="text" class="form-control"
					id="tlf" value="<c:out value="${tlf}"/>"
					name="<%=ParameterNames.TLF%>">
			</div>
			<div class="form-group col-md-2">
				<label for="correo"><fmt:message key="cliente.correo"
						bundle="${messages}" /></label> <input type="text" class="form-control"
					id="correo" value="<c:out value="${correo}"/>"
					name="<%=ParameterNames.CORREO%>">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-5"></div>
			<div class="form-group col-md-2">
				<button type="submit" class="btn btn-dark">
					<fmt:message key="gestion.buscar" bundle="${messages}" />
				</button>
			</div>
			<div class="form-group col-md-5"></div>
		</div>

	</form>

</div>

<br>


<hr>
<br>
<div class="table-responsive">
	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th>ID</th>
				<th><fmt:message key="usuario" bundle="${messages}" /></th>
				<th><fmt:message key="cliente" bundle="${messages}" /></th>
				<th><fmt:message key="fecha" bundle="${messages}" /></th>
				<th><fmt:message key="razon" bundle="${messages}" /></th>
				<th><fmt:message key="comentario" bundle="${messages}" /></th>
				<th></th>
			</tr>
		</thead>

		<c:if test='${not empty gestiones}'>
			<tbody>
				<c:forEach items="${gestiones}" var="gestion" varStatus="status">
					<tr>
						<td><c:out value="${gestion.idGestion}" /></td>
						<td><c:out value="${empleados[status.index].usuario}" /></td>
						<td><c:out value="${clientes[status.index].nombre}" /></td>
						<td><c:out value="${gestion.fechaInicio}" /></td>
						<td><c:out value="${tickets[status.index].tipoTicket}" /></td>
						<td><c:out value="${tickets[status.index].comentario}" /></td>

						<td>
							<form action="/GestoWeb/TicketServlet" method="post">
								<input type="hidden" name="<%=ParameterNames.ACTION%>"
									value="<%=ParameterNames.POST_SEARCH_GESTION%>" /> <input
									type="hidden" name="<%=ParameterNames.ID_GESTION%>"
									value="<c:out value="${gestion.idGestion}"/>" />
								<button type="submit" class="btn btn-dark">
									<fmt:message key="gestion.ver" bundle="${messages}" />
								</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<p>
				<c:out value="${fn:length(gestiones)}" />
				<fmt:message key="resultados" bundle="${messages}" />
			</p>
		</c:if>
	</table>
</div>


<%@include file="/html/common/footer.jsp"%>