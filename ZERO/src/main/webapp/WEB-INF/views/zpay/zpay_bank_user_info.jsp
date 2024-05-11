<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/zpay.css" rel="stylesheet" type="text/css">
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<title>ZERO</title>
<script type="text/javascript">
	$(function() {
		$("#zpayBankAuthButton").on("click", function() {
			// 새 창에서 사용자 인증 페이지 요청
			// => 입금 이체 API 사용을 위해 scope 항목에 oob추가
			let requestUri = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
					+ "response_type=code"
					+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
// 					+ "&redirect_uri=http://localhost:8089/zero/callback"
					+ "&redirect_uri=http://c5d2302t1.itwillbs.com/ZERO/callback"
					+ "&scope=login inquiry transfer oob"
					+ "&state=12345678901234567890123456789012"
					+ "&auth_type=0";
			
			window.open(requestUri, "authWindow", "width=600, height=800");
		});
	});
</script>
</head>
<body>
	<%-- 세션 아이디가 없을 경우 "로그인 후 사용 가능합니다" 출력 후 로그인 페이지로 이동 --%>
	<%-- 아니면, 엑세스토큰이 없을 경우 "계좌 인증 후 사용 가능합니다" 출력 후 회원정보 페이지로 이동 --%>
	<c:choose>
		<c:when test="${empty sessionScope.member_id }">
			<script>
				alert("로그인 후 사용 가능합니다");
				location.href = "./";
			</script>
		</c:when>
		<c:when test="${empty sessionScope.access_token }">
			<script>
				alert("계좌 인증 후 사용 가능합니다");
				location.href = "MemberInfo";
			</script>
		</c:when>
	</c:choose>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	<article>
		<div class="container">
			<div class="contentAreaZpay">
			<%-- 메인영역 --%>
				<div class="zpayManageArea">
					<div class="profileArea">
						<a class="profileLink" href="#">
							<span class="profileImg">
							<c:choose>
								<c:when test="${not empty member.member_image }">
									<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${member.member_image }" alt="사용자 이미지" class="thumb_img" width=50px height=50px>
								</c:when>
								<c:otherwise>
									<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" alt="사용자 이미지" class="thumb_img" width=50px height=50px>
								</c:otherwise>
							</c:choose>		
							</span>
							<span class="profileInfo">
								<strong class="profileName">
									${sessionScope.member_id } 님
<!-- 									홍길동 님 -->
								</strong>
								${member.member_nickname }
<!-- 								hong -->
							</span>
						</a>
					</div>
					<div class="payWalletWidgetArea">
						<div class="zpayArea">
							<div class="balanceArea">
								<strong class="title">
									ZPAY에 계좌 등록
								</strong>
								<div class="balance">
									<c:choose>
										<c:when test="${empty sessionScope.member_id}">
											로그인이 필요한 서비스입니다.
										</c:when>
										<c:otherwise>
<!-- 											ZPAY에 등록할 계좌를 선택해 주세요 -->
											대표 계좌를 선택해주세요.
										</c:otherwise>
									</c:choose>	
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="zpayHistoryArea">
					<div class="zpayHistoryListArea">
						<ul>
							<li>
								<div class="zpayHistoryItem">
									<div class="zpayHistoryItem_date">
										예금주명
									</div>
									<div class="zpayHistoryItem_infoArea">
										<div class="zpayHistoryItem_info">
											은행명&nbsp;&nbsp;&nbsp;계좌번호
											<div class="zpayHistoryItem_info_sub">
												<span class="payTime">
													핀테크이용번호
												</span>
												<span class="paymentType">${account.fintech_use_num }</span>
											</div>
										</div>
									</div>
								</div>
							</li>
							<c:forEach var="account" items="${userInfo.res_list }">
								<li>
									<div class="zpayHistoryItem">
										<div class="zpayHistoryItem_date">
											${account.account_holder_name }
										</div>
										<div class="zpayHistoryItem_infoArea">
											<div class="zpayHistoryItem_info">
												${account.bank_name }(${account.bank_code_std })&nbsp;&nbsp;&nbsp;${account.account_num_masked }
												<div class="zpayHistoryItem_info_sub">
													<span class="payTime">
														핀테크이용번호
													</span>
													<span class="paymentType">${account.fintech_use_num }</span>
												</div>
											</div>
											<div class="zpayHistoryItem_amountArea">
												<strong class="zpayHistoryItem_amount">
													
												</strong>
												<div class="zpayBalance">
													<%-- 2.3.1. 잔액조회 API 요청을 위한 폼 --%>
													<form action="zpay_passwd_regist" method="post">
														<%-- hidden 타입으로 예금주명, 계좌번호(마스킹), 핀테크이용번호 전달 --%>
														<input type="hidden" name="user_name" value="${userInfo.user_name }">
														<input type="hidden" name="fintech_use_num" value="${account.fintech_use_num }">
														<input type="hidden" name="bank_name" value="${account.bank_name }">
														<input type="hidden" name="account_num_masked" value="${account.account_num_masked }">
														<input type="submit" class="btn btn-sm btn-dark" value="등록하기">
													</form>
												</div>
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div><%-- zpayHistoryListArea 영역 끝 --%>
				</div>
			</div><%-- contentArea 영역 끝 --%>
		</div><%-- container 영역 끝 --%>
	</article>
	<footer><%@ include file="../inc/footer.jsp"%>
	</footer>

</body>
</html>