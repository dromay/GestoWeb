<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="com.gesto.ecommerce.model.*, com.gesto.ecommerce.web.controller.*"%>

<fmt:setLocale value='${sessionScope["user-locale"]}' scope="session"/>
<fmt:setBundle basename = "resources.Messages" var = "messages" scope="session"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  	<title>Gesto</title>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  	<link rel="stylesheet" href="/GestoWeb/css/Gesto.css">
  	<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet"> 
  	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.9/css/all.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</head>
<body>	

	<c:set var="empleado" value="${sessionScope.user}" scope="page"/>
	<c:set var="cliente" value="${sessionScope.client}" scope="page"/>
	<c:set var="empresa" value="${sessionScope.company}" scope="page"/>
	<c:set var="contacto" value="${sessionScope.contact}" scope="page"/>
	<c:set var="idiomaCall" value="${sessionScope.idiomacall}" scope="page"/>
	
<fmt:setLocale value='${idiomaCall.idIdioma}' scope="page"/>
<fmt:setBundle basename = "resources.Messages" var = "saludo" scope="page"/>

		<div class="container-fluid ">
			<header class="row">
		        <div class="col-sm-2 header" style="background-color:white;">
					<img src="/GestoWeb/images/static/Gesto.JPG" class="img-fluid" alt="Logo Gesto" title="Logo Gesto" id="gesto"/>
		        </div>
		        <div class="col-sm-3 header">
			        <c:if test="${not empty contacto && not empty empleado && not empty empresa}">
			         	<p><c:out value="${contacto.getContactoTlf()}"/></p>
			         	<p><c:out value="${contacto.getContactoCorreo()}"/></p>
		    			<p><c:out value="${idiomaCall.descripcion}"/></p>
					</c:if>
		        </div>
		        <div class="col-sm-5 header" >
		        <c:if test="${not empty contacto && not empty empleado && not empty empresa}">
		        	<p><c:out value="${empresa.descripcion}"/><fmt:message key="bienvenida.atiende" bundle="${saludo}"/> <c:out value="${empleado.nombre}"/><fmt:message key="bienvenida.ayudar" bundle="${saludo}"/> <c:out value="${contacto.contactoNombre}?"/> </p>
			        <p><c:out value="${cliente.tipo}"/> <c:out value="${cliente.nombre}"/></p>
		        </c:if>
		        </div>
		        	<!-- Tile de usuario -->
		            <%@include file="/html/user/user-profile.jsp"%>
		    </header>
			<!-- Barra de navegación, Categorías, o similar -->
			<div class="row content">
				<%@include file="/html/common/aside.jsp"%>	
	
				<!-- Inicio del frame / tile / sección de contenido -->
				<div class="col-sm-10">