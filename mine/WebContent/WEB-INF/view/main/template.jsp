<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tile" uri="http://tiles.apache.org/tags-tiles" %>

<html>
	<head>
		<c:import url="/WEB-INF/view/main/head.jsp"/>
	</head>
	
	<body>
		<c:import url="/WEB-INF/view/main/deletePopup.jsp"/>
		<div class="inner">
			<header>
				<tile:insertAttribute name="header"/>
			</header>
			<article>
				<tile:insertAttribute name="article"/>
			</article>
			<footer>
				<tile:insertAttribute name="footer"/>
			</footer>
		</div>
	</body>
	
	<script>
		
	</script>
</html>