<%@include file="/html/common/header.jsp"%>
<%@ page
	import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.service.*, com.gesto.ecommerce.service.impl.*, java.util.*"%>
<div>

		<c:set var="departamentos" value="${requestScope.departamentos}" scope="page"/>
		<c:set var="empleado" value="${requestScope.empleados}" scope="page"/>
		<c:set var="supervisor" value="${requestScope.supervisor}" scope="page"/>
	
<h2><c:out value="${empleado.nombre}"/> <c:out value="${empleado.apellido}"/></h2>
<br>
<div class="jumbotron">
	<form>
		<div class="form-row">
			<div class="form-group col-md-2">
		    </div>
			<div class="form-group col-md-2">
			<img src="/GestoWeb/images/dynamic/<c:out value="${empleado.idEmpleado}"/>.jpg" height="120" width="100" alt="Logo <c:out value="${empleado.nombre}"/> " title="Logo <c:out value="${empleado.nombre}"/>"/>
		    </div>
		</div>
	  	<div class="form-row">
		   	<div class="form-group col-md-2">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="usuario"><fmt:message key="usuario" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="usuario" placeholder="<c:out value="${empleado.usuario}"/>"  disabled>
		    </div>
		    <div class="form-group col-md-2">
		      <label for="extUsuario"><fmt:message key="extension" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="extUsuario" placeholder="<c:out value="${empleado.extDepartamento}"/><c:out value="${empleado.ext}"/>" disabled>
		    </div>
		 	<div class="form-group col-md-1">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="departamento"><fmt:message key="departamento" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="departamento" placeholder="<c:out value="${departamentos.descripcion}"/>" disabled>
		    </div>
		   	<div class="form-group col-md-2">
		   		<c:if test='${not empty empleado.idiomas}'>	
		   			<label for="Idiomae"><fmt:message key="idioma" bundle="${messages}"/></label> 
					<select id="Idiomae" class="form-control">
	    			<c:forEach items="${empleado.idiomas}" var="idiomae" varStatus="status">
						<option value="<c:out value="${idiomae.idIdioma}"/>"><c:out value="${idiomae.descripcion}"/></option>
	      			</c:forEach>
	      			</select>
	     		</c:if>	    
		    </div>
	  	</div>
	  		<c:if test='${not empty empleado.fechaBaja}'>	
		   			<div class="form-row">
						<div class="form-group col-md-5">
					    </div>
					    <div class="form-group col-md-2">
					      <label for="fechaBaja"><fmt:message key="fecha.baja" bundle="${messages}"/></label>
					      <input type="text" class="form-control" id="fechaBaja" placeholder="<c:out value="${empleado.fechaBaja}"/>"  disabled>
					    </div>
					</div>
	     	</c:if>	
	</form>
</div>

<c:if test='${empleado.idEmpleado != supervisor.idEmpleado}'>			
<h2><fmt:message key="supervisor" bundle="${messages}"/></h2>
<div class="jumbotron">
	<form>
		<div class="form-row">
			<div class="form-group col-md-6">
			<h3><c:out value="${supervisor.nombre}"/> <c:out value="${supervisor.apellido}"/></h3>
		    </div>
		</div>
	  	<div class="form-row">
		   	<div class="form-group col-md-2">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="usuario"><fmt:message key="usuario" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="usuario" placeholder="<c:out value="${supervisor.usuario}"/>"  disabled>
		    </div>
		    <div class="form-group col-md-2">
		      <label for="extUsuario"><fmt:message key="extension" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="extUsuario" placeholder="<c:out value="${supervisor.extDepartamento}"/><c:out value="${supervisor.ext}"/>" disabled>
		    </div>
		 	<div class="form-group col-md-1">
		    </div>
		    <div class="form-group col-md-2">
		      <label for="departamento"><fmt:message key="departamento" bundle="${messages}"/></label>
		      <input type="text" class="form-control" id="departamento" placeholder="<c:out value="${departamentos.descripcion}"/>" disabled>
		    </div>
		   	<div class="form-group col-md-2">
		   		<c:if test='${not empty supervisor.idiomas}'>	
		   			<label for="Idiomas"><fmt:message key="idioma" bundle="${messages}"/></label> 
					<select id="Idiomas" class="form-control">
	    			<c:forEach items="${supervisor.idiomas}" var="idiomas" varStatus="status">
						<option value="<c:out value="${idiomas.idIdioma}"/>"><c:out value="${idiomas.descripcion}"/></option>
	      			</c:forEach>
	      			</select>
	     		</c:if>	  
		    </div>
	  	</div>
	  	<c:if test='${not empty empleado.fechaBaja}'>	
		   		<div class="form-row">
					<div class="form-group col-md-5">
				    </div>
				    <div class="form-group col-md-2">
				      <label for="fechaBaja"><fmt:message key="fecha.baja" bundle="${messages}"/></label>
				      <input type="text" class="form-control" id="fechaBaja" placeholder="<c:out value="${supervisor.fechaBaja}"/>"  disabled>
				    </div>
				</div>
	     </c:if>	
	</form>
</div>
</c:if>				

<%@include file="/html/common/footer.jsp"%>