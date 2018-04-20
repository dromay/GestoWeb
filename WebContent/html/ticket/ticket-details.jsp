<%@include file="/html/common/header.jsp"%>
	
	<c:set var="error" value="${requestScope.error}" scope="page"/>
	<c:set var="ticket" value="${requestScope.tickets}" scope="page"/>
	<c:set var="empleado" value="${requestScope.empleados}" scope="page"/>
	<c:set var="cliente" value="${requestScope.clientes}" scope="page"/>
	<c:set var="contacto" value="${requestScope.contactos}" scope="page"/>
	<c:set var="idGestion" value="${requestScope.idgestion}" scope="page"/>
	
	<h1>Ticket / <fmt:message key="gestion" bundle="${messages}"/>#<c:out value="${idGestion}"/></h1>	    
<br>

<c:if test="${not empty error}">
	<div class="alert alert-danger">
	    	<strong><c:out value="${error}"/></strong>
	 </div>
</c:if>

<div class="jumbotron">
	<form>
	  	<div class="form-row">
		   	<div class="form-group col-md-4">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="nombreCliente"><fmt:message key="cliente.nombre" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="nombreCliente" placeholder="<c:out value="${cliente.nombre}"/>" name="<%=ParameterNames.NOMBRE_CLIENTE%>" disabled>
		    </div>
		    <div class="form-group col-md-2">
		      <label for="tipoCliente"><fmt:message key="cliente.tipo" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="tipoCliente" placeholder="<c:out value="${cliente.tipo}"/>" name="<%=ParameterNames.TIPO_CLIENTE%>" disabled>
		    </div>
	 	</div>
	 	<div class="form-row">
		 	<div class="form-group col-md-2">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="nombreContacto"><fmt:message key="contacto.nombre" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="nombreContacto" placeholder="<c:out value="${contacto.contactoNombre}"/>" name="<%=ParameterNames.NOMBRE_CONTACTO%>"disabled>
		    </div>
		   	<div class="form-group col-md-2">
		      <label for="apellidoContacto"><fmt:message key="contacto.apellido" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="apellidoContacto" placeholder="<c:out value="${contacto.contactoApellido}"/>" name="<%=ParameterNames.APELLIDO_CONTACTO%>"disabled>
		    </div>
		   	<div class="form-group col-md-2">
		      <label for="tlf"><fmt:message key="contacto.telefono" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="tlf" placeholder="<c:out value="${contacto.contactoTlf}"/>" name="<%=ParameterNames.TLF%>"disabled>
		    </div>
		    <div class="form-group col-md-2">
		      <label for="correo"><fmt:message key="contacto.correo" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="correo" placeholder="<c:out value="${contacto.contactoCorreo}"/>" name="<%=ParameterNames.CORREO%>"disabled>
		    </div>
	  	</div>
		<div class="form-row">
			<div class="form-group col-md-3">
		    </div>
			<div class="form-group col-md-3">
		      <label for="tipo"><fmt:message key="gestion.tipo" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="tipo" placeholder="<c:out value="${ticket.tipoTicket}"/>"  name="<%=ParameterNames.TIPO_GESTION%>"disabled>
		    </div> 
		</div>
		<div class="form-row">
			<div class="form-group col-md-3">
		    </div>
			<div class="form-group col-md-6">
		      <label for="comentario"><fmt:message key="comentario" bundle="${messages}"/></label>
		      <textarea class="form-control" id="comentario" placeholder="<c:out value="${ticket.comentario}"/>"  name="<%=ParameterNames.COMENTARIO%>" rows="10" cols="70" disabled></textarea>
		    </div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-2">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="usuario"><fmt:message key="usuario" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="usuario" placeholder="<c:out value="${empleado.usuario}"/>"  name="<%=ParameterNames.USER_EMPLEADO%>"disabled>
		    </div>
		    <div class="form-group col-md-1">
		    </div>
		   	<div class="form-group col-md-2">
		      <label for="fechaInicio"><fmt:message key="fecha" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="fechaInicio" placeholder="<c:out value="${ticket.fechaInicio}"/>"  name="<%=ParameterNames.FECHA_INICIO%>"disabled>
		    </div>
		    <div class="form-group col-md-1">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="tiempoTotal"><fmt:message key="tiempo" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="tiempoTotal" placeholder="<c:out value="${ticket.tiempoTotal}"/>"  name="<%=ParameterNames.TIEMPO_TOTAL%>"disabled>
		    </div>
		</div>
	</form>
</div>


<%@include file="/html/common/footer.jsp"%>