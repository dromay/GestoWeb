<%@include file="/html/common/header.jsp"%>
<!-- Por que no incluir cabeza y pie? -->

<div class="wrapper row2" align="center">
	<div id="container" class="clear" align="center">
		<section id="fof" class="clear">
			<div class="hgroup">
				<img src="/GestoWeb/images/static/404.jpg" class="img-fluid"
					alt="Logo 404" title="Logo 404" id="404" />
				<h2>
					<span><fmt:message key="error.404.accesible" bundle="${messages}" /></span>
				</h2>
			</div>
			<p>
				<fmt:message key="error.404.servidor" bundle="${messages}" />
			</p>
			<p>
				<a href="javascript:history.go(-1)"
					class="btn btn-secondary btn-lg active" role="button">&laquo; <fmt:message key="atras" bundle="${messages}" />
				</a> 
				<a href="/GestoWeb"
					class="btn btn-secondary btn-lg active" role="button"><fmt:message key="continuar" bundle="${messages}" /> &raquo;
				</a>
			</p>
		</section>
	</div>
</div>

<%@include file="/html/common/footer.jsp"%>