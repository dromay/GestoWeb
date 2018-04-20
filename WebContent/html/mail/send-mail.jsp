<%@include file="/html/common/header.jsp"%>

<c:set var="error" value="${requestScope.error}" scope="page" />
<c:set var="success" value="${requestScope.success}" scope="page" />
<c:set var="asunto" value="${requestScope.asunto}" scope="page" />
<c:set var="mensaje" value="${requestScope.mensaje}" scope="page" />
<c:set var="para" value="${requestScope.to}" scope="page" />

<h1>
	<fmt:message key="correo.enviar" bundle="${messages}" />
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

<div class="jumbotron">
	<form action="/GestoWeb/MailServlet" method="post">
		<div class="form-row">
			<div class="form-group col-md-3"></div>
			<div class="form-group col-md-3">
				<label for="asunto"><fmt:message key="asunto"
						bundle="${messages}" /></label> <input type="text" class="form-control"
					id="asunto" value="<c:out value="${asunto}"/>" name="<%=ParameterNames.SUBJECT%>">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-3"></div>
			<div class="form-group col-md-3">
				<label for="para"><fmt:message key="para"
						bundle="${messages}" /></label> <input type="email" class="form-control"
					id="para" value="<c:out value="${para}"/>"
					name="<%=ParameterNames.TO%>">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-3"></div>
			<div class="form-group col-md-6">
				<label for="mensaje"><fmt:message key="mensaje"
						bundle="${messages}" /></label>
				<textarea class="form-control" id="mensaje"
					name="<%=ParameterNames.MESSAGE%>" rows="10" cols="70"><c:out value="${mensaje}"/></textarea>
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-5"></div>
			<div class="form-group col-md-2">
				<button type="submit" class="btn btn-dark">
					<fmt:message key="enviar" bundle="${messages}" />
				</button>
			</div>
		</div>
	</form>
</div>


<%@include file="/html/common/footer.jsp"%>