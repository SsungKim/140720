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
						<select id="diary_folder">
							<option value="choose">폴더선택</option>
							<option>전체</option>
							<option>아성</option>
							<option>보라</option>
						</select>
					</div>
					<span class="search" onclick="diary_search()">검색</span>
					<div class="date">
						<select id="diary_year">
							<c:forEach var="i" begin="0" end="50">
								<option>${2017-i }</option>
							</c:forEach>
						</select>
						<span>년</span>
						<select id="diary_month">
							<c:forEach var="i" begin="1" end="12">
								<option>${i }</option>
							</c:forEach>
						</select>
						<span>월</span>
					</div>
				</div>
				<div class="list_wrap" id="diary_list_wrap">
					<c:choose>
						<c:when test="${list.size() > 0}">
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
				</div>
			</div>
			<div class="wrap_container" id="diary_content_wrap">
				<div class="title_wrap">
					<c:choose>
						<c:when test="${login != null }">
							<div class="title">${diary.title }</div>
							<div class="day">${diary.day }</div>
						</c:when>
						<c:otherwise>
							<div class="title">로그인 후 볼 수 있습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="content_container">
					<div class="content_wrap">
						<div class="content">
							<c:choose>
								<c:when test="${login != null }">
									<div class="txt">${diary.content }</div>
								</c:when>
								<c:otherwise>
									<div class="txt">로그인 후 볼 수 있습니다.</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="btn_wrap">
						<c:if test="${login != null }">
							<div class="btn" onclick="location.href='/diary/write'">작성</div>
						</c:if>
						<c:if test="${login.id == diary.id }">
							<div class="btn" onclick="location.href='/diary/modify/${diary.auto }'">수정</div>
							<div class="btn" onclick="remove('diary', '${diary.auto}')">삭제</div>
						</c:if>
					</div>
					<div class="reply_wrap">
						<c:if test="${login != null }">
							<div class="txt">댓글달기</div>
							<input type="text" id="diary_reply" maxlength="30"/>
							<div class="btn" onclick="diary_reply_submit(${diary.auto })">등록</div>
						</c:if>
						<div class="replies">
							<div class="reply_scroll">
								<c:choose>
									<c:when test="${login != null }">
										<c:choose>
											<c:when test="${reply.size() > 0 }">
												<c:forEach var="t" items="${reply }">
													<div class="reply">
														<div class="reply_txt_wrap">
															<div class="reply_txt">${t.reply }</div>
														</div>
														<div class="reply_btn_wrap">
															<div class="txt">${t.nick }</div>
															<div class="day">${t.day }</div>
															<c:if test="${login.id == t.id }">
																<div class="txt_btn">삭제</div>
																<div class="txt_btn">수정</div>
															</c:if>
														</div>
													</div>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<div class="reply">
													<div class="reply_txt_wrap">
														<div class="reply_txt">등록된 댓글이 없습니다.</div>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<div class="reply">
											<div class="reply_txt_wrap">
												<div class="reply_txt">로그인 후 볼 수 있습니다.</div>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
	$(document).ready(function(){
		var save = "${save }";
		if(save == "true"){
			alert("저장되었습니다.");
			location.href="/diary";
		} else if(save == "false"){
			alert("저장에 실패하였습니다.\n잠시후 다시 시도해주세요.");
			location.href="/diary";
		}
		var modify = "${modify }";
		if(modify == "true"){
			alert("수정되었습니다.");
			location.href="/diary";
		} else if(modify == "false"){
			alert("수정에 실패하였습니다.\n잠시후 다시 시도해주세요.");
			location.href="/diary";
		}
	});
</script>