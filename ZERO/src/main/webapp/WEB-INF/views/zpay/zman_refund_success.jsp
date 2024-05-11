<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/zpay.css" rel="stylesheet" type="text/css">
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<title>ZERO</title>
<style type="text/css">
	html {
		height: 100%
	}
	
	body {
		height: 89vh;
	}

	.container {
		padding-bottom: 0;
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
				<div class="successContentArea">
					<div class="targetArea">
						<div class="icon">
							<img alt="zpay_success" src="${pageContext.request.contextPath }/resources/img/zpay_success.png">
						</div>
						<p class="targetMessage">
							<strong>${zpay.zpay_bank_name } ${zpay.zpay_bank_account }  </strong>로<br>
							<em class="amount">
								<fmt:formatNumber value="${zmanRefundHistory.zman_net_profit}" pattern="#,##0"/>원 정산완료
							</em>
						</p>
						<p class="targetAccountInfo">
							${zpay.zpay_bank_name } ${zpay.zpay_bank_account }
						</p>
					</div>
<!-- 					<div class="successInfoArea"> -->
<!-- 						<div class="balanceArea"> -->
<!-- 							<div class="balanceArea_label"> -->
<!-- 								ZPAY 잔액 -->
<!-- 							</div> -->
<!-- 							<strong class="balanceArea_balance"> -->
<%-- 								<fmt:formatNumber value="${zpay_balance}" pattern="#,##0"/>원 --%>
<!-- 							</strong>	 -->
<!-- 						</div> -->
<!-- 						<div class="accountInfoArea"> -->
<!-- 							<div class="accountInfoArea_label"> -->
<!-- 								환급계좌 -->
<!-- 							</div> -->
<!-- 							<div class="accountInfoArea_accountNum"> -->
<%-- 								${zpay.zpay_bank_name } ${zpay.zpay_bank_account } --%>
<!-- 							</div>	 -->
<!-- 						</div> -->
<!-- 						<div class="successNoticeArea"> -->
<!-- 							ZPAY는 ZPAY 홈에서 무료로 즉시 인출가능합니다. -->
<!-- 						</div> -->
<!-- 					</div> -->
					<div class="buttonArea">
<!-- 						<a href="zpay_charge_form" class="btn btn-outline-secondary btn-lg moreCharge">충전하기</a> -->
						<a href="zman_main" class="btn btn-secondary btn-lg zpayHistory">ZMAN 홈으로 이동</a>
					</div>
				</div><%-- successContentArea 영역 끝 --%>	
			</div><%-- contentArea 영역 끝 --%>
		</div><%-- container 영역 끝 --%>
	</article>
	<footer>
		<%@ include file="../inc/footer.jsp"%>
	</footer>

</body>
</html>