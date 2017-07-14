<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="visitors_section">
	<div class="list_container">
		<div class="search_wrap">
			<div class="check_wrap">
				<label for="allVisit">전체공개</label>
				<input type="radio" id="allVisit" name="visitType"/>
				<label for="privateVisit">비밀공개</label>
				<input type="radio" id="privateVisit" name="visitType"/>
			</div>
		</div>
		<div class="list_wrap">
			<div class="list">
				<c:forEach var="i" begin="1" end="30">
					<div class="visit">
						<div class="title">
							<div class="writer">작성자${i }</div>
							<div class="day">2017-04-18</div>
						</div>
						<div class="content">
							내용내용 방명록 내용입네다~ 만나서 반갑습네다~ 홈페이지 잘 꾸미세용~
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="write_container">
		<div class="visit_wrap">
			<div class="visit_title">방명록 작성</div>
			<textarea id="visitContent"></textarea>
			<div class="btn" id="visitWrite">작성하기</div>
		</div>
		<div class="mail_wrap">
			<div class="mail_title">메일 보내기</div>
			<div class="txt_wrap">
				<div class="txt">제목</div>
				<input type="text" id="mail_title"/>
			</div>
			<div class="txt_wrap">
				<div class="txt">메일주소</div>
				<input type="text" id="mail_mail"/>
			</div>
			<div class="txt_wrap">
				<div class="txt">연락처</div>
				<input type="text" id="mail_phone"/>
			</div>
			<div class="txt_wrap">
				<div class="txt">내용</div>
				<textarea id="mail_content"></textarea>
			</div>
			<div class="btn_wrap">
				<div class="btn">전송</div>
				<div class="btn" onclick="mail_clear()">지우기</div>
			</div>
		</div>
	</div>
</section>

<script>
	//visitors - write visitors if you logon
	$(document).ready(function(){
		if(${login == null}){
			$("#visitContent").prop("readonly", true);
			$("#visitContent").val("로그인 후 작성가능합니다.");
			$("#visitWrite").prop("readonly", true);
		}
	});
</script>