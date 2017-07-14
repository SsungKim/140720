<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="top_wrap">
	<c:choose>
		<c:when test="${login==null }">
			<div class="login_container">
				<div class="login_txt"><span>로그인</span></div>
				<div class="login_wrap">
					<div class="txt_wrap">
						<div class="txt"><span>ID</span></div>
						<input type="text" id="login_id"/>
					</div>
					<div class="txt_wrap">
						<div class="txt"><span>PW</span></div> 
						<input type="password" id="login_pw"/>
					</div>
					<div class="btn_wrap">
						<div class="btn" onclick="login()">Login</div>
						<div class="btn">Join</div>
					</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="logon_container">
				<div class="logon_txt">${login.nick }님 반갑습니다.</div>
				<div class="btn_wrap">
					<div class="btn">My</div>
					<div class="btn" onclick="logout()">Logout</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<div class="menu_container">
	<div class="logo_wrap">
		<img src="/img/logo.png" onclick="location.href='/'"/>
	</div>
	<div class="menu_wrap">
		<ul>
			<li onclick="location.href='/culture'">Culture</li>
			<li onclick="location.href='/travel'">Travel</li>
			<li onclick="location.href='/play'">Play</li>
			<li onclick="location.href='/picture'">Picture</li>
			<li onclick="location.href='/diary'">Diary</li>
			<li onclick="location.href='/visitors'">Visitors</li>
		</ul>
	</div>
</div>