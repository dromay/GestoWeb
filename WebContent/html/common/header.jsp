<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!-- Controlamos nosotros la inicializacion, en SessionManager -->
<%@page session="false"%>  

<%@page import="com.gesto.ecommerce.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- imports de css, js -->
		<link rel="stylesheet" type="text/css" href="/GestoWeb/css/sacra.css">
	</head>
	<body>
		<div class="header">

			<a href="/GestoWeb/html/index.jsp">
				<img src="/GestoWeb/images/static/sacra-logo.jpg" height="60" width="60"></img>
				Ribeira Sacra Turismo
									
				</div>				
				
				<!-- Tile de usuario -->
				<div class="user-data">			
				<%@include file="/html/user/user-profile.jsp"%>						
				</div>
							
			</a>			
		</div>
		
		<div class="bar">			
			<!-- Barra de navegaciÛn, CategorÌas, o similar -->
			<p>Estrategia | RPG | Guerra | Ciencia Ficci√≥n </p>
		</div>
		
		<!-- Inicio del frame / tile / secciÛn de contenido -->
		<div class="content">
		