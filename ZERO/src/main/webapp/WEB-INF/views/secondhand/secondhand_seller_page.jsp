<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/defualt.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<%-- 반응형웹페이지위한 설정 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ZERO</title>
<%-- 제이쿼리 --%>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<script type="text/javascript">


// 거래중상품탭이 웹페이지 로드시 자동으로 선택되어 보여지도록
	document.addEventListener('DOMContentLoaded', function() {
	    document.querySelector('.tablinks.active').click();
	});

// 탭 설정
function openTab(evt, dealStatus) {
	
	  document.getElementById("dealingTab").style.display = "block";
	  evt.currentTarget.className += " active";
	
	  var i, tabcontent, tablinks;
	  tabcontent = document.getElementsByClassName("tabcontent");
	  
	  
	  for (i = 0; i < tabcontent.length; i++) {
	    tabcontent[i].style.display = "none";
	  }
	  
	  tablinks = document.getElementsByClassName("tablinks");
	  
	  for (i = 0; i < tablinks.length; i++) {
	    tablinks[i].className = tablinks[i].className.replace(" active", "");
	  }
	  
	  document.getElementById(dealStatus).style.display = "block";
	  evt.currentTarget.className += " active";
	  
	}
</script>


<style>
article {
	margin-top: 150px;
}
a {
	color:black;
}
.container {
  position: relative;
  margin-top: 100px;
}
body {font-family: Arial;}

/* 카드이미지 위에 거래상태 버튼 css */
.photoDiv {
	position: relative;
}
.dealStatus{
		font-size: 0.9rem;
		position: absolute;
		top: 136px;
		right: 0px;
/* 		border: 3px double gray;  */
		border-radius: 50%
}

.card-text{
	text-align: left;
	margin-top: 5px;
}


/* Style the tab */
.tab {
  overflow: hidden;
/*   border: 1px solid #ccc; */
/*   background-color: #f1f1f1; */
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  color:lightgray;
}

/* Create an active/current tablink class */
.tab button.active {
  color:darkgray;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
/*   border: 1px solid #ccc; */
  border-top: none;
}
h3, h5, button {
	margin-bottom:20px;
} 


#sellerAdderess {
	color:gray;
	font-size: 13px;
}




/* 찜하기 버튼 (이미지 오버) */
.likebtn { 
		font-size: 1.0rem;
		position: absolute;
		top: 263px;
		left: 10px;
		border-radius: 10%;
/* 		background-color:white; */
		

}
/* 거래상태 버튼(이미지 오버) */
.dealStatus {
		font-size: 0.7rem;
		position: absolute;
		top: 263px;
		right: 0px;
		border-radius: 40%;
}

.card-text{
	text-align: center;
	margin-top: 5px;
}

.card-body{
	font-size:0.9rem;
}


/* 거래가능상품보기 라디오박스? */
.form-check {
	margin-bottom:10px;
	margin-left:10px;
}


/* 목록 카드 css */
.card-img-top{
	width:250x;
	height:300px;
}
row{
	margin:20px;
	padding:20px;
}
/* 카드 카테고리 */
.category {
	color:gray;
	font: bold;
/* 	background-color:lightgray; */
}

</style>
</head>
<body>
<header><%@ include file="../inc/header.jsp"%></header>

<article id="mainArticle">
	<div class="container">
		<div class="row row-cols-2">
			<!-- 왼쪽섹션 - 회원프로필 -->
			<div class="col-3">
					<%-- 프로필이미지 - 설정된 프로필 없을경우 기본이미지 설정 --%>
						<c:choose>
							<c:when test="${not empty seller.member_image }">
								<img src="${pageContext.request.contextPath }/resources/upload/${seller.member_image}" width="120px" height="120px" style="margin:20px; border-radius: 50%; ">
							</c:when>
							<c:otherwise>
								<img src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" width="120px" height="120px" style="margin:20px; border-radius: 50%; ">
							</c:otherwise>
						</c:choose>
					
					<h5> ${seller.member_nickname } 님</h5>
					<!--<button class="btn btn-primary btn-lg" style="font-size:1em;" > 채팅하기 </button> -->
					
					<%-- 2-1.세션아이디 없을경우(미로그인) -> 로그인알람창띄우고 로그인페이지로 이동 --%>
					<c:if test="${empty sessionScope.member_id }">
						<%--<button type="button" class="btn btn-outline-danger" id="likeMovieNo${i.index }" data-toggle="modal" data-target="#needLogin">♡찜하기</button> --%>
						<div class="d-grid gap-2">
							<button class="btn btn-dark" id="chatting" 
									data-toggle="modal" data-target="#needLogin" 
									style="font-size:1em;">
								채팅하기
							</button>
						</div>
					</c:if>
					<%--2.2 세션아이디 있을경우(판매자아닌 일반회원) -> 채팅하기 누를경우 채팅창으로 이동 --%>
					<c:if test="${not empty sessionScope.member_id && sessionScope.member_id ne seller.member_id }">
							<form action="doChat" method="POST">
								<input type="hidden" value="${seller.member_id }" name="seller_id">
								<input type="hidden" value="${seller.member_id }" name="seller_id">
								<div class="d-grid gap-2">
									<input type="submit" class="btn btn-dark" style="font-size:1em;" value="채팅하기">
								</div>
							</form>
					</c:if>
	
					<div id="sellerAdderess"> ${seller.member_address1 } </div>
					<div> 판매상품 ${sellerProduct }개 </div>
			</div>
			
			
			
			
			<!-- 오른쪽섹션  -->
			<div class="col-9">
				<div class="tab">
				  <button class="tablinks active" onclick="openTab(event, 'dealingTab')">거래 중 상품</button>
				  <button class="tablinks" onclick="openTab(event, 'dealEndTab')">거래 완료 상품</button>
				  <button class="tablinks" onclick="openTab(event, 'reviewTab')">받은 후기</button>
				</div>
				
				
				<div id="dealingTab" class="tabcontent current">
					<!-- 
						거래상태(secondhand_deal_status)가 '판매중'일 경우 && '예약중'일 경우
						거래상태(secondhand_deal_status)가 '판매완료'일 경우
						판매자(member_id)가 session과 동일한 secondhand정보받아오기
						=> 목록(List)
						secondhand_deal_status ne '판매완료'
					 -->
<%-- 				<c:if test="${sellerProductList.secondhand_deal_status == '판매중' or sellerProductList.secondhand_deal_status == '예약중' }"> --%>
					<p> 거래 중 상품 ${dealProductCount } 개 </p>
					
					<div class="row" align="left">
						<!--  거래 중 상품이 존재하지 않을 경우 -->
						<c:if test="${dealProductCount eq 0 }">
								<div style="margin-left:20px; color:gray;"> 거래 완료된 상품이 존재하지 않습니다 </div>
						</c:if>
					
						<c:forEach var="secondhand" items="${dealProductList }">			
							<div class="col-lg-3 col-mid-4">
								<div class="card border-0" >
									<!-- 썸네일이미지 - 서버 업로드시 경로 재설정 필요할수도 -->
									<div class="photoDiv">	
										<a href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
											<img src="${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1}" class="card-img-top" >
											<%-- <img src="<%= request.getContextPath()%> + ${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1} "/> --%>									
											<%-- <img src="http://localhost:8089/zero/${secondhand.secondhand_image1}" class="card-img-top" > --%>
										</a>
										
										<!-- 찜하기 버튼 -->
										<span class="likebtn">
											<a href="#" style="align:right;">
												<img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="30px" height="30px">
											</a>
										</span>
		
										<!-- 거래상태 버튼 -->
										<span class="dealStatus"><button class="btn btn-dark">${secondhand.secondhand_deal_status}</button></span>
									</div>
									
									<div class="card-body">
										<!-- 카테고리 가져오기 -->
										<%-- <input type="hidden" id="seoncdhand_idx" value="${secondhand.secondhand_idx}"> --%>
										<div class="category" style="font-size:0.8rem; ">
											${secondhand.category_name }
										</div>
										
										<div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
											<!-- 제목 링크 -->
											<a href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
												${secondhand.secondhand_subject}
											</a>
										</div>
										<p><fmt:formatNumber pattern="#,###" value="${secondhand.secondhand_price }"/>원</p>								
										<p>${secondhand.secondhand_first_date }</p>
									</div><!-- cardbody끝 -->
								</div><!-- card끝 -->
							</div>
						</c:forEach>
					</div><%--row끝 --%>
				

					</div><!-- 거래중 상품(dealingTab) 끝 -->
				
				
				
				
				
				
				<div id="dealEndTab" class="tabcontent">
					<p>거래 완료 상품  ${soldOutProductCount } 개</p>
					
					<div class="row" align="left">
						<!--  거래완료된 상품이 존재하지 않을 경우 -->
						<c:if test="${soldOutProductCount eq 0 }">
							<div style="margin-left:20px; color:gray;"> 거래 완료된 상품이 존재하지 않습니다 </div>
						</c:if>
						<c:forEach var="secondhand" items="${soldOutProductList }">			
						<div class="col-lg-3 col-mid-4">
							<div class="card border-0" >
								<!-- 썸네일이미지 - 서버 업로드시 경로 재설정 필요할수도 -->
								<div class="photoDiv">	
									<a href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
										<img src="${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1}" class="card-img-top" >
										<%-- <img src="<%= request.getContextPath()%> + ${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1} "/> --%>									
										<%-- <img src="http://localhost:8089/zero/${secondhand.secondhand_image1}" class="card-img-top" > --%>
									</a>
									
									<!-- 찜하기 버튼 -->
									<span class="likebtn">
										<a href="#" style="align:right;">
											<img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="30px" height="30px">
										</a>
									</span>
	
									<!-- 거래상태 버튼 -->
									<span class="dealStatus"><button class="btn btn-dark">${secondhand.secondhand_deal_status}</button></span>
								</div>
								
								<div class="card-body">
									<!-- 카테고리 가져오기 -->
									<%-- <input type="hidden" id="seoncdhand_idx" value="${secondhand.secondhand_idx}"> --%>
									<div class="category" style="font-size:0.8rem; ">
										${secondhand.category_name }
									</div>
									
									<div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
										<!-- 제목 링크 -->
										<a href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
											${secondhand.secondhand_subject}
										</a>
									</div>
									<p><fmt:formatNumber pattern="#,###" value="${secondhand.secondhand_price }"/>원</p>								
									<p>${secondhand.secondhand_first_date }</p>
								</div><!-- cardbody끝 -->
							</div><!-- card끝 -->
						</div>
					</c:forEach>
				</div><%--row끝 --%>
				</div><%-- 거래완료상품(dealEndTab) 끝 --%>
				
				
				
				<%-- 받은 리뷰 탭 --%>
				<div id="reviewTab" class="tabcontent">
					<%-- 리뷰개수 --%>
					<div class="reviewCount"> 전체 후기 <span>${reviewListCount } 개</span></div>
					
					<c:if test="${reviewListCount eq 0 }">
						<div style="color:gray; margin:10px;"> 받은 리뷰내역이 존재하지 않습니다</div>
					</c:if>
					
					<c:forEach var="review" items="${reviewList }">			
						<div class = "row">
							<%-- 리뷰리스트 --%>
							<div class = "col-2">
								<img src="${pageContext.request.contextPath }/resources/upload/${review.member_image}" width="50px" height="50px" style="margin:20px;">
							</div>
							<div class = "col-10" style="margin-top:20px;">
								<p> ${review.member_nickname} </p>
								<p>	${review.member_review_content }</p>
								<hr>
							</div>
						</div>
					</c:forEach>
				</div>	
				
				
				
				
<!-- 				<div id="reviewTab" class="tabcontent"> -->
<!-- 					<p>전체 후기 nn 개</p> -->
						
<!-- 					<div class = "row"> -->
<!-- 						<div class = "col-2"> -->
<%-- 							<img src="${pageContext.request.contextPath }/resources/img/profile.png" width="50px" height="50px" style="margin:20px;"> --%>
<!-- 						</div> -->
<!-- 						<div class = "col-10" style="margin-top:20px;"> -->
<!-- 							<p> 닉네임 </p> -->
<!-- 							<p> 리뷰내용</p> -->
<!-- 							<hr> -->
<!-- 						</div> -->
<!-- 					</div> -->

<!-- 					<div class = "row"> -->
<!-- 						<div class = "col-2"> -->
<%-- 							<img src="${pageContext.request.contextPath }/resources/img/profile.png" width="50px" height="50px" style="margin:20px;"> --%>
<!-- 						</div> -->
<!-- 						<div class = "col-10" style="margin-top:20px;"> -->
<!-- 							<p> 닉네임 </p> -->
<!-- 							<p> 리뷰내용</p> -->
<!-- 							<hr> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class = "row"> -->
<!-- 						<div class = "col-2"> -->
<%-- 							<img src="${pageContext.request.contextPath }/resources/img/profile.png" width="50px" height="50px" style="margin:20px;"> --%>
<!-- 						</div> -->
<!-- 						<div class = "col-10" style="margin-top:20px;"> -->
<!-- 							<p> 닉네임 </p> -->
<!-- 							<p> 리뷰내용</p> -->
<!-- 							<hr> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class = "row"> -->
<!-- 						<div class = "col-2"> -->
<%-- 							<img src="${pageContext.request.contextPath }/resources/img/profile.png" width="50px" height="50px" style="margin:20px;"> --%>
<!-- 						</div> -->
<!-- 						<div class = "col-10" style="margin-top:20px;"> -->
<!-- 							<p> 닉네임 </p> -->
<!-- 							<p> 리뷰내용</p> -->
<!-- 							<hr> -->
<!-- 						</div> -->
<!-- 					</div> -->

<!-- 				</div>reviewTab 끝		 -->
			</div><!--grid나누기위한컬럼-->
	
			
			
		</div><%--레이아웃 row 끝 --%>
	</div><%--conatiner끝 --%>
	
	<%-- 찜하기 안내 모달 영역 --%>
	<div class="modal fade" id="needLogin" tabindex="-1" role="dialog" aria-labelledby="needSessionId" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="needSessionId">로그인 안내</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center" id="modalMsg">
	      	<%-- 메세지가 표시되는 부분 --%>
		  	회원 로그인이 필요한 작업입니다. 로그인 하시겠습니까?
	      </div>
	      <div class="modal-footer justify-content-center">
	      	<c:choose>
	      		<c:when test="${empty sessionScope.member_id}">
		        	<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath }/member_login'">로그인</button>
			        <button type="button" class="btn btn-light" data-dismiss="modal" aria-label="Close">아니오</button>
		        </c:when>
		        <c:otherwise>
			        <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">확인</button>
		        </c:otherwise>
	      	</c:choose>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
</article>

	<!-- footer -->
	<footer>
		<%@ include file="../inc/footer.jsp"%>
	</footer>
	
</body>
</html>