<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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