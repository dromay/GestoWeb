<%@include file="/html/common/header.jsp"%>
<%@ page import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.service.*, com.gesto.ecommerce.service.impl.*, java.util.*"%>

<c:set var="cliente" value="${requestScope.clientes}" scope="page"/>
	 
<h2><c:out value="${cliente.tipo}"/> <c:out value="${clientes.nombre}"/></h2>
<br>
<div class="jumbotron">
	<form>
	  	<div class="form-row">
		   	<div class="form-group col-md-2">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="tipo"><fmt:message key="tipo" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="tipo" placeholder="<c:out value="${cliente.tipo}"/>"  disabled>
		    </div>
		    <div class="form-group col-md-2">
		      <label for="nombre"><fmt:message key="nombre" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="nombre" placeholder="<c:out value="${cliente.nombre}"/>" disabled>
		    </div>
		 	<div class="form-group col-md-1">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="docCliente"><fmt:message key="documento" bundle="${messages}"/></label>
		     	<c:choose>
						<c:when test="${not empty cliente.docIdentidad}">
							<td><input type="text" class="form-control" id="docCliente" placeholder="<c:out value="${cliente.docIdentidad}"/>" disabled></td>
						</c:when>	      
						<c:otherwise>
							<input type="text" class="form-control" id="docCliente" placeholder="<fmt:message key="especificado.no" bundle="${messages}"/>" disabled>
						</c:otherwise>
				</c:choose>
			</div>
		   	<div class="form-group col-md-2">
		   		<c:if test="${not empty cliente.idiomas}">
					<label for="idiomaCliente"><fmt:message key="idioma" bundle="${messages}"/></label> 
					<select id="idiomaCliente" class="form-control">
						<c:forEach items="${cliente.idiomas}" var="idioma">
	    					<option value="<c:out value="${idioma.idIdioma}"/>"><c:out value="${idioma.descripcion}"/></option>
	    				</c:forEach>
	    			</select>
				</c:if>
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
		        <th><fmt:message key="nombre" bundle="${messages}"/></th>
		        <th><fmt:message key="apellido" bundle="${messages}"/></th>
		        <th><fmt:message key="telefono" bundle="${messages}"/></th>
		        <th><fmt:message key="correo" bundle="${messages}"/></th>
		        <th><fmt:message key="idioma" bundle="${messages}"/></th>
		        <th></th>
      		</tr>
    	</thead>
    	<tbody>
		<c:if test="${not empty cliente.contactos}">
			<c:forEach items="${cliente.contactos}" var="contacto">
				<tr>
							<td><c:out value="${contacto.contactoNombre}"/></td>
							<td><c:out value="${contacto.contactoApellido}"/></td>
							<td><c:out value="${contacto.contactoTlf}"/></td>
							<td><c:out value="${contacto.contactoCorreo}"/></td>
						<c:if test="${not empty contacto.idiomas}">
							<td><select id="idiomaContacto" class="form-control">
		        			<c:forEach items="${contacto.idiomas}" var="idioma">
		        				<option value="<c:out value="${idioma.idIdioma}"/>"><c:out value="${idioma.descripcion}"/></option>
		       				</c:forEach>
		       				</select></td>
		       			</c:if>
				</tr>
			</c:forEach>
		</c:if>
		</tbody>
  	</table>
</div>


<%@include file="/html/common/footer.jsp"%>