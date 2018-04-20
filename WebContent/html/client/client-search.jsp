<%@include file="/html/common/header.jsp"%>
<%@ page
	import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.service.*, com.gesto.ecommerce.service.impl.*, java.util.*"%>
	
<c:set var="idiomas" value="${sessionScope.languages}" scope="page"/>
<c:set var="clientes" value="${requestScope.clientes}" scope="page"/>
<c:set var="nombre" value="${requestScope.nombrecliente}" scope="page"/>
<c:set var="id" value="${requestScope.codigocliente}" scope="page"/>
<c:set var="tlf" value="${requestScope.tlfcliente}" scope="page"/>
<c:set var="correo" value="${requestScope.correocliente}" scope="page"/>
<c:set var="idiomacliente" value="${requestScope.idioma}" scope="page"/>
<c:set var="tipo" value="${requestScope.tipocliente}" scope="page"/>
<c:set var="idGestion" value="${requestScope.idgestion}" scope="page"/>

<h1><fmt:message key="cliente" bundle="${messages}"/></h1>      
<br>

<c:set var="error" value="${requestScope.error}" scope="page"/>
	<c:if test="${not empty error}">
		<div class="alert alert-danger">
			<strong><fmt:message key="${error}" bundle="${messages}"/></strong>
		</div>
	</c:if>

<div class="jumbotron">
	<form action="/GestoWeb/ClientServlet" method="post">
	<input type="hidden" name="<%=ParameterNames.ACTION%>" value="<%=ParameterNames.SEARCH_CLIENTE%>"/>
	  <div class="form-row">
	  	<div class="form-group col-md-2">
	    </div>
	  	<div class="form-group col-md-2">
	      <label for="nombreCliente"><fmt:message key="cliente.nombre" bundle="${messages}"/></label>
	      <input type="text" class="form-control" id="nombreCliente" value="<c:out value="${nombre}"/>" name="<%=ParameterNames.NOMBRE_CLIENTE%>">
	    </div>
	    <div class="form-group col-md-2">
	      <label for="codigoCliente"><fmt:message key="cliente.documento" bundle="${messages}"/></label>
	      <input type="text" class="form-control" id="codigoCliente" value="<c:out value="${id}"/>" name="<%=ParameterNames.DOC_CLIENTE%>">
	    </div>
	    <div class="form-group col-md-2">
	      <label for="tlf"><fmt:message key="cliente.telefono" bundle="${messages}"/></label>
	      <input type="text" class="form-control" id="tlf" value="<c:out value="${tlf}"/>" name="<%=ParameterNames.TLF%>">
	    </div>
	    <div class="form-group col-md-2">
	      <label for="correo"><fmt:message key="cliente.correo" bundle="${messages}"/></label>
	      <input type="text" class="form-control" id="correo" value="<c:out value="${correo}"/>" name="<%=ParameterNames.CORREO%>">
	    </div>
	 </div>
	  <div class="form-row">
	  	<div class="form-group col-md-2">
	    </div>
	    <div class="form-group col-md-2">
	    	<label for="idioma"><fmt:message key="idioma" bundle="${messages}"/></label>
	    	<select class="form-control" id="idioma" name="<%=ParameterNames.IDIOMA%>">
	    		<option></option>
	    		<c:forEach items="${idiomas}" var="idioma">
	    			<option value="<c:out value="${idioma.idIdioma}"/>"><c:out value="${idioma.descripcion}"/></option>
	    		</c:forEach>
	    	</select>	    	
	    </div>
	    <div class="form-group col-md-1">
	    </div>
	    <div class="form-group col-md-2">
	    	<label for="idGes">ID <fmt:message key="gestion" bundle="${messages}"/></label>
	      	<input type="number" class="form-control" id="idGes" value="<c:out value="${idGestion}"/>"  name="<%=ParameterNames.ID_GESTION%>"/>
	    </div>
	    <div class="form-group col-md-1">
	    </div>
	   	<div class="form-group col-md-2">
	   		<label for="tipoCliente"><fmt:message key="cliente.tipo" bundle="${messages}"/></label>
	    	<select class="form-control" id="tipoCliente" name="<%=ParameterNames.TIPO_CLIENTE%>">
	    		<option></option>
	    		<option value="PR"><fmt:message key="cliente.tipo.proveedor" bundle="${messages}"/></option>
	    		<option value="PA"><fmt:message key="cliente.tipo.particular" bundle="${messages}"/></option>
	    		<option value="HO"><fmt:message key="cliente.tipo.hotel" bundle="${messages}"/></option>
	    		<option value="AG"><fmt:message key="cliente.tipo.agencia" bundle="${messages}"/></option>
    		</select>
	    </div>
	  </div>
	  <div class="form-row">
	 	<div class="form-group col-md-5">
	    </div>
	   	<div class="form-group col-md-2">
	   		<button type="submit" class="btn btn-dark"><fmt:message key="cliente.buscar" bundle="${messages}"/></button>
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
		        <th><fmt:message key="tipo" bundle="${messages}"/></th>
		        <th><fmt:message key="nombre" bundle="${messages}"/></th>
		        <th><fmt:message key="documento" bundle="${messages}"/></th>
		        <th><fmt:message key="numero.contactos" bundle="${messages}"/></th>
		        <th><fmt:message key="numero.gestiones" bundle="${messages}"/></th>
		        <th></th>
      		</tr>
    	</thead>
		<c:if test='${not empty clientes}'>
				<tbody>
			    	<c:forEach items="${clientes}" var="cliente">
						    <tr>
									<td><c:out value="${cliente.tipo}"/></td>
					        		<td><c:out value="${cliente.nombre}"/></td>
					        <c:choose>
								<c:when test="${not empty cliente.docIdentidad}">
								    <td><c:out value="${cliente.docIdentidad}"/></td>
								</c:when>	      
								<c:otherwise>
									<td><fmt:message key="especificado.no" bundle="${messages}"/></td>
								</c:otherwise>
							</c:choose>
						         	<td><c:out value="${fn:length(cliente.getContactos())}"/></td>
						         	<td><c:out value="${fn:length(cliente.getGestiones())}"/></td>
		
					        		<td>
					        			<form action="/GestoWeb/ClientServlet" method="post">
											<input type="hidden" name="<%=ParameterNames.ACTION%>" value="<%=ParameterNames.CLIENTE_DETAIL%>"/>
											<input type="hidden" name="<%=ParameterNames.ID_CLIENTE%>" value="<c:out value="${cliente.idCliente}"/>"/>
											<button type="submit" class="btn btn-dark"><fmt:message key="cliente.ver" bundle="${messages}"/></button>
										</form>
									</td>
		      				</tr>
					</c:forEach>
				  </tbody>
		  	<p><c:out value="${fn:length(clientes)}"/> <fmt:message key="resultados" bundle="${messages}"/></p>
		</c:if>
	</table>
</div>
<%@include file="/html/common/footer.jsp"%>