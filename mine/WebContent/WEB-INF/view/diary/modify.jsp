<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="board_category_section">
	<div class="inner_container">
		<div class="diary_img">
			<img src="/img/diary.png"/>
		</div>
		<div class="board_container">
			<div class="wrap_container">
				<div class="select_wrap">
					<div class="folder">
						<select>
							<option value="choose">폴더선택</option>
							<option>아성</option>
							<option>보라</option>
						</select>
					</div>
					<div class="date">
						<select>
							<c:forEach var="i" begin="0" end="50">
								<option>${2017-i }</option>
							</c:forEach>
						</select>
						<span>년</span>
						<select>
							<c:forEach var="i" begin="1" end="12">
								<option>${i }</option>
							</c:forEach>
						</select>
						<span>월</span>
					</div>
				</div>
				<div class="list_wrap">
					<div class="list">
						<c:forEach var="t" items="${list }">
							<div class="txt">
								<span>${t.title }</span>
								<span class="day">${t.day }</span>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<form action="/diary/modifySave" id="diaryModifyForm" method="post">
				<input type="hidden" name="num" value="${diary.auto }"/>
				<div class="wrap_container">
					<div class="write_select">
						<select id="diary_modify_folder" name="folder">
							<option value="choose">폴더선택</option>
							<option ${diary.folder eq '아성' ? 'selected' : '' }>아성</option>
							<option ${diary.folder eq '보라' ? 'selected' : '' }>보라</option>
						</select>
					</div>
					<div class="title_wrap">
						<div class="txt">제목</div>
						<input type="text" id="diary_modify_title" name="title" value="${diary.title }"/>
					</div>
					<div class="content_container content_container2">
						<div class="content_wrap content_wrap2">
							<div class="write_txt">내용</div>
							<textarea id="diary_modify_content" name="content">${diary.content }</textarea>
						</div>
						<div class="btn_wrap">
							<div class="btn" onclick="diary_modify()">저장</div>
							<div class="btn" onclick="history.back()">취소</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>

<script>
	CKEDITOR.replace("diary_modify_content", {
		enterMode: '2',
		shiftEnterModel: '3',
		height: '410px'
	});
</script>