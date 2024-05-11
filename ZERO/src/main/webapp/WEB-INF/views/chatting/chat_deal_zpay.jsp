<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
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
	
	function submitNclose(type) {
		switch(type) {
			case 'submit' : 
				console.log(${map.order_secondhand_idx });
				var form = document.getElementById("zpay_send_form");
		        form.submit();
		        // 채팅창에(부모창) 안내 메세지 띄우기
				let typeMsg = "${map.buyer_nickname}" + "님이 Z페이"
							+ "${map.order_secondhand_price }원을 보냈어요";
		        window.opener.subNotice('zpay', typeMsg)
		        window.close();
				break;
			case 'close' :
				window.close();
				break;
		}
	}
	
</script>
<style type="text/css">
	.chargeInputArea {
		min-height: 400px;
	}
	.chargeContentArea {
		margin-top: 10px;
	}
	/* 잔액 */
	.balanceAccountNum {
		margin-left: 20px;
		margin-top: 5px;
		font-size: 16px;
		color: gray;
	}
	/* 밑에 버튼 영역 */
	.chargeButtonArea {
		margin: auto;
		padding-top: 10px;
	}
	
</style>
</head>
<body>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	<article>
		<div class="container">
			<div class="contentArea">
			<%-- 메인영역 --%>
				<form action="zpay_send_form" method="get" id="zpay_send_form">
					<input type="hidden" name="order_secondhand_idx" value="${map.order_secondhand_idx }">
					<div class="chargeContentArea">
						<div class="chargeInputArea">
							<div class="title">
								ZPAY 송금하기
							</div>
							<div class="withdrawalAccountArea">
								<div class="title">
									${map.seller_nickname }님에게
								</div>
									<c:choose>
										<%--  --%>
										<c:when test="${map.order_secondhand_type eq 'Z맨' }">
											<div class="withdrawalAccount_info">
												<div class="withdrawalBankName">
			<%-- 									${map.order_secondhand_price + 3000}원 --%>
													<fmt:formatNumber pattern="###,###" value="${map.order_secondhand_price + 3000}"/>원
												</div>
											</div>
											<div class="withdrawalAccount_info">
												<div class="withdrawalAccountNum">
													<fmt:formatNumber pattern="###,###" value="${map.order_secondhand_price}"/>(상품가격)  + 3,000(배달수수료)</div>
											</div>
										</c:when>
										<c:otherwise>
											<div class="withdrawalAccount_info">
												<div class="withdrawalBankName">
													<fmt:formatNumber pattern="###,###" value="${map.order_secondhand_price}"/>원
												</div>
											</div>
											<div class="withdrawalAccount_info">
												<div class="withdrawalAccountNum">
													<fmt:formatNumber pattern="###,###" value="${map.order_secondhand_price}"/>(상품가격)</div>
											</div>
											
										</c:otherwise>
									</c:choose>
<!-- 								<div class="balanceAccountNum">페이잔액 : xxx,xxx원</div> -->
								
							</div><%-- withdrawalAccountArea 영역 끝 --%>
						</div><%-- chargeInputArea 영역 끝 --%>
						<div class="chargeButtonArea">
							<button type="button" class="btn btn-dark" onclick="submitNclose('submit')">보내기</button>
							<button type="button" class="btn btn-dark" onclick="submitNclose('close')">취소</button>
						</div><%-- chargeButtenArea 영역 끝 --%>
					</div><%-- chargeContetnArea 영역 끝 --%>
				</form>
			</div><%-- contentArea 영역 끝 --%>
		</div><%-- container 영역 끝 --%>
	</article>
	<footer>
		<%@ include file="../inc/footer.jsp"%>
	</footer>

</body>
</html>