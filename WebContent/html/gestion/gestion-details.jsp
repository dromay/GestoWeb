<%@include file="/html/common/header.jsp"%>
<%@ page
	import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.service.*, com.gesto.ecommerce.service.impl.*, java.util.*"%>
	
	<c:set var="tickets" value="${requestScope.tickets}" scope="page"/>
	<c:set var="empleados" value="${requestScope.empleados}" scope="page"/>
	<c:set var="contactos" value="${requestScope.contactos}" scope="page"/>
	<c:set var="idGestion" value="${requestScope.idgestion}" scope="page"/>

	<h1><fmt:message key="gestion" bundle="${messages}"/> #<c:out value="${idGestion}"/></h1>
	<hr>
	<form action="/GestoWeb/TicketServlet" method="post">
		<input type="hidden" name="<%=ParameterNames.ACTION%>" value="<%=ParameterNames.PRECREATE_TICKET%>"/>
		<input type="hidden" name="<%=ParameterNames.ID_GESTION%>" value="<c:out value="${idGestion}"/>"/>
		<button type="submit" class="btn btn-dark"><fmt:message key="ticket.crear" bundle="${messages}"/></button>
	</form>
	<br>
	<div class="table-responsive">          
	  	<table class="table">
	    	<thead class="thead-dark">
	      		<tr>
	      			<th>ID <fmt:message key="ticket" bundle="${messages}"/></th>
			        <th><fmt:message key="usuario" bundle="${messages}"/></th>
			        <th><fmt:message key="contacto.nombre" bundle="${messages}"/></th>
			        <th><fmt:message key="fecha.inicio" bundle="${messages}"/></th>
			        <th><fmt:message key="razon" bundle="${messages}"/></th>
			        <th><fmt:message key="comentario" bundle="${messages}"/></th>
			        <th></th>
	      		</tr>
	    	</thead>
	    	<c:if test='${not empty tickets}'>
				<tbody>
			    	<c:forEach items="${tickets}" var="ticket"  varStatus="status">
						    <tr>
									<td><c:out value="${status.index+1}"/></td>
					        		<td><c:out value="${empleados[status.index].usuario}"/></td>
					        		<td><c:out value="${contactos[status.index].contactoNombre}"/></td>
					        		<td><c:out value="${ticket.fechaInicio}"/></td>
					        		<td><c:out value="${ticket.tipoTicket}"/></td>
					        		<td><c:out value="${ticket.comentario}"/></td>
					        		
					        		<td>
					        			<form action="/GestoWeb/TicketServlet" method="post">
											<input type="hidden" name="<%=ParameterNames.ACTION%>" value="<%=ParameterNames.TICKET_DETAIL%>"/>
											<input type="hidden" name="<%=ParameterNames.ID_GESTION%>" value="${ticket.idGestion}"/>
											<input type="hidden" name="<%=ParameterNames.USER_EMPLEADO%>" value="<c:out value="${empleados[status.index].usuario}"/>"/>
											<input type="hidden" name="<%=ParameterNames.ID_TICKET%>" value="<c:out value="${ticket.idTicket}"/>"/>
											<button type="submit" class="btn btn-dark"><fmt:message key="ticket.ver" bundle="${messages}"/></button>
										</form>
									</td>
	      					</tr>	
					</c:forEach>
				  </tbody>
		  	<p><c:out value="${fn:length(tickets)}"/> <fmt:message key="resultados" bundle="${messages}"/></p>
		</c:if>
  		</table>
	</div>
<%@include file="/html/common/footer.jsp"%>