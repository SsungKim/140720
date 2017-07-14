<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="delete_popup1" id="delete_popup1"></div>
<div class="delete_popup2" id="delete_popup2">
	<div class="delete_container">
		<div class="logo_wrap">
			<img src="/img/logo.png"/>
		</div>
		<div class="txt_wrap">
			<div class="txt">정말 <span>삭제</span>하시겠습니까?</div>
		</div>
		<div class="btn_wrap">
			<div class="btn" onclick="remove_yes()">예</div>
			<div class="btn" onclick="$('#delete_popup1').hide(), $('#delete_popup2').hide(), $('body').css('overflow', 'auto')">아니오</div>
		</div>
	</div>
</div>