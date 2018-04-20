<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value='${sessionScope["user-locale"]}' scope="session"/>
<fmt:setBundle basename = "resources.Messages" var = "messages" scope="session"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
  	<title>Gesto</title>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  	<link rel="stylesheet" href="/GestoWeb/css/Error.css">
  	<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet"> 
</head>
<body>
	<div class="wrapper row2">
	  <div id="container" class="clear">
	    <section id="fof" class="clear">
	      <div class="hgroup">
	        <h1><span><strong>5</strong></span><span><strong>0</strong></span><span><strong>0</strong></span></h1>
	        <h2><fmt:message key="error" bundle="${messages}"/> <span><fmt:message key="error.500.interno" bundle="${messages}"/></span></h2>
	      </div>
	      	<p><fmt:message key="error.500.nota" bundle="${messages}"/></p>
			<p><fmt:message key="error.500.tarde" bundle="${messages}"/></p>
	     <!-- <p>For Some Reason The Page You Requested Could Not Be Found On Our Server</p>-->
	      <p><a href="javascript:history.go(-1)" class="btn btn-secondary btn-lg active" role="button">&laquo; <fmt:message key="atras" bundle="${messages}"/></a>  <a href="/GestoWeb" class="btn btn-secondary btn-lg active" role="button"><fmt:message key="continuar" bundle="${messages}"/> &raquo;</a></p>
	    </section>
	  </div>
	</div>
</body>
</html>

