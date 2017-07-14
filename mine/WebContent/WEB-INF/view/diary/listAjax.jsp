<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<c:when test="${list.size() > 0 }">
		<div class="list">
			<c:forEach var="t" items="${list }">
				<div class="txt">
					<span onclick="diary_view(${t.auto})">${t.title }</span>
					<span class="day">${t.day }</span>
					<span class="day">${t.nick }</span>
				</div>
			</c:forEach>
		</div>
	</c:when>
	<c:otherwise>
		<div class="list">
			<div class="txt">등록된 글이 없습니다.</div>
		</div>
	</c:otherwise>
</c:choose>