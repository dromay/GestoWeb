<%@include file="/html/common/header.jsp"%>

<c:set var="error" value="${requestScope.error}" scope="page" />
<c:set var="usuario" value="${requestScope.usuario}" scope="page" />
<c:set var="errorUser" value="${requestScope.erroruser}" scope="page" />
<c:set var="errorPassword" value="${requestScope.errorpassword}" scope="page" />

<div class="container">
	<h1>
		<fmt:message key="autenticarse" bundle="${messages}" />
	</h1>
	<br>
	<c:if test="${not empty error}">
		<div class="alert alert-danger">
			<strong><fmt:message key="${error}" bundle="${messages}"/></strong>
		</div>
	</c:if>
	<form class="form-horizontal" action="<%=ViewPaths.USER_SIGN_IN%>"
		method="post">
		<div class="form-group">
			<label class="control-label col-sm-2" for="empleado"><fmt:message
					key="usuario" bundle="${messages}" /></label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="empleado" value="<c:out value="${usuario}"/>"
					name="<%=ParameterNames.USER_EMPLEADO%>" />
			</div>
		</div>
		<c:if test="${not empty errorUser}">
		    <div class="form-row">
		    	<div class="form-group col-md-3">
		    	</div>
				<div class="alert alert-danger col-sm-3 text-center">
	    			<strong><fmt:message key="${errorUser}" bundle="${messages}"/></strong>
	 			</div>
	 		</div>
		</c:if>
		<div class="form-group">
			<label class="control-label col-sm-2" for="pwd"><fmt:message
					key="password" bundle="${messages}" /></label>
			<div class="col-sm-10">
				<input type="password" class="form-control" id="pwd"
					name="<%=ParameterNames.PASSWORD%>" />
			</div>
		</div>
		<c:if test="${not empty errorPassword}">
		    <div class="form-row">
		    	<div class="form-group col-md-3">
		    	</div>
				<div class="alert alert-danger col-sm-3 text-center">
	    			<strong><fmt:message key="${errorPassword}" bundle="${messages}"/></strong>
	 			</div>
	 		</div>
		</c:if>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-default">
					<fmt:message key="enviar" bundle="${messages}" />
				</button>
			</div>
		</div>
	</form>
</div>


<%@include file="/html/common/footer.jsp"%>