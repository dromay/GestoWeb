<%@include file="/html/common/header.jsp"%>

	<c:set var="error" value="${requestScope.error}" scope="page"/>
	<c:set var="success" value="${requestScope.success}" scope="page"/>
	<c:set var="gestion" value="${requestScope.errorgestion}" scope="page"/>
	<c:set var="comentario" value="${requestScope.errorcomentario}" scope="page"/>
	<c:set var="idGestion" value="${requestScope.idgestion}" scope="page"/>
	<c:set var="fechaInicio" value="${requestScope.fechainicio}" scope="page"/>
	<c:set var="cliente" value="${sessionScope.client}" scope="page"/>
	<c:set var="contacto" value="${sessionScope.contact}" scope="page"/>
	
	
	<c:choose>
		<c:when test="${not empty idGestion}">
			<h1><fmt:message key="ticket.nuevo" bundle="${messages}"/> <fmt:message key="gestion" bundle="${messages}"/>#<c:out value="${idGestion}"/></h1>
		</c:when>	      
		<c:otherwise>
			<h1><fmt:message key="nuevo" bundle="${messages}"/> <fmt:message key="gestion" bundle="${messages}"/>/Ticket</h1>
		</c:otherwise>
	</c:choose>
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
	</form>
</div>


<div>
	<form action="/GestoWeb/TicketServlet" method="post" >
		
	<c:choose>
		<c:when test="${not empty idGestion}">
			<input type="hidden" name="<%=ParameterNames.ACTION%>" value="<%=ParameterNames.CREATE_TICKET%>"/>
			<input type="hidden" name="<%=ParameterNames.FECHA_INICIO%>" value="<c:out value="${fechaInicio}"/>"/>
			<input type="hidden" name="<%=ParameterNames.ID_GESTION%>" value="<c:out value="${idGestion}"/>"/>
		</c:when>	      
		<c:otherwise>
			<input type="hidden" name="<%=ParameterNames.ACTION%>" value="<%=ParameterNames.CREATE_GESTION%>"/>
			<input type="hidden" name="<%=ParameterNames.FECHA_INICIO%>" value="<c:out value="${fechaInicio}"/>"/>
		</c:otherwise>
	</c:choose>	
		
		<div class="form-row">
			<div class="form-group col-md-3">
		    </div>
			<div class="form-group col-md-3">
		      <label for="tipo"><fmt:message key="gestion.tipo" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="tipo" name="<%=ParameterNames.TIPO_GESTION%>">
		    </div> 
		    
		</div>
		<c:if test="${not empty gestion}">
			<div class="form-row">
		    	<br>
		    	<div class="form-group col-md-3">
		    	</div>
				<div class="alert alert-danger col-md-3">
	    			<strong><fmt:message key="${gestion}" bundle="${messages}"/></strong>
	 			</div>
	 		</div>
		</c:if>
		<div class="form-row">
			<div class="form-group col-md-3">
		    </div>
			<div class="form-group col-md-6">
		      <label for="comentario"><fmt:message key="comentario" bundle="${messages}"/></label>
		      <textarea class="form-control" id="comentario"  name="<%=ParameterNames.COMENTARIO%>" rows="10" cols="70"></textarea>
		    </div>
		</div>
		<c:if test="${not empty comentario}">
		    <div class="form-row">
		    	<div class="form-group col-md-3">
		    	</div>
				<div class="alert alert-danger col-md-6">
	    			<strong><fmt:message key="${comentario}" bundle="${messages}"/></strong>
	 			</div>
	 		</div>
		</c:if>
		<div class="form-row">
			<div class="form-group col-md-5">
		    </div>
		    <div class="form-group col-md-2">
		    	<button type="submit" class="btn btn-dark"><fmt:message key="ticket.crear" bundle="${messages}"/></button>
		    </div>
		   	<div class="form-group col-md-5">
		    </div>
		</div>
	</form>
</div>


<%@include file="/html/common/footer.jsp"%>