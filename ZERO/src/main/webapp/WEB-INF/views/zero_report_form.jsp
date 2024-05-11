<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<title>ZERO</title>
<script type="text/javascript">
	
	// 신고사유 셀렉트 박스
	function categoryChange(e) {
	    var report_member = ["도배 행위", "사기 행위", "욕설", "비매너"];
	    var report_zman = ["불친절", "배달 누락"];
	    var report_goods = ["주류, 담배", "전문 의약품, 의료기기", "위조상품"];
	    var target = document.getElementById("report");
	 
	    if(e.value == "member") var d = report_member;
	    else if(e.value == "zman") var d = report_zman;
	    else if(e.value == "goods") var d = report_goods;
	 
	    target.options.length = 0;
	 
	    for (x in d) {
	        var opt = document.createElement("option");
	        opt.value = d[x];
	        opt.innerHTML = d[x];
	        target.appendChild(opt);
	    }    
	}
</script>
<style type="text/css">
	.modal-title{
	 font-size: 17px;
	 text-align:left;
	 font-weight: bold;
	}
	.modal_table{
	  width:100%;
	}
	#modal_userImg{
	  width:50px;
	  height:50px;
	  border-radius: 75%;
	}
	#modal_userId{
	  width:200px;
	}
	#modal_userFollow{
	  margin:10px;
	  text-align: right;
	}
</style>
</head>
<body>
	<header>
		<%@ include file="inc/header.jsp"%>
	</header>
	
	<article>
		<div class="container">
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
<%-- 				<jsp:include page="/WEB-INF/views/inc/cs_sidebar.jsp"></jsp:include> --%>
			</nav>
			
			<%-- 메인영역 --%>
			<div class="contentArea">
			
				
				<%-- 신고 모달로 해보기 --%>
				<%-- 모달 출력 버튼 --%>
				<button class="btn btn-default" data-target="#layerpop" data-toggle="modal">
					<img src="https://ccimage.hellomarket.com/img/web/item/detail/ico_report.png"
					 	 alt="신고하기" class="TopNavigationIcon report">
				</button><br/>
				<div class="modal fade" id="layerpop" >
					<div class="modal-dialog">
						<div class="modal-content">
							<!-- header -->
							<div class="modal-header">
								<!-- header title -->
								<h4 class="modal-title">header</h4>
							</div>
							
							<!-- body -->
							<form action="zero_report" method="POST" name="fr">								
								<div class="modal-body">
								    <%-- 신고하려는 내용 알려주기 --%>
									<div class="1st_report">
										<dl class="report_area">
											<h2>신고 제목</h2>
									</div>
									
									<%-- 신고 이유 선택하기 --%>				
									<div class="reportReason">
										<h4>사유선택</h4>
										<div>
											<select onchange="categoryChange(this)">
											    <option>신고 타입을 선택해주세요</option>
											    <option value="member">회원</option>
											    <option value="zman">ZMAN</option>
											    <option value="goods">상품</option>
											</select>
					 					</div>
					 					
					 					<div>
											<select id="report">
												<option>사유 선택</option>
											</select>
										</div>
									</div>
								</div> <%-- <div class="modal-body"> --%>
								
								<!-- Footer -->
								<div class="modal-footer">
									<button type="submit" class="btn btn-default" data-dismiss="modal">신고하기</button>
								</div>
							</form>
						</div> <%-- <div class="modal-content"> --%>
					</div>
				</div>
				
				
				
				
				
				
				
			</div> <%-- <div class="contentArea"> 끝 --%>
		</div> <%-- <div class="container"> 끝 --%>
	</article>
	
	<footer>
	</footer>
</body>
</html>