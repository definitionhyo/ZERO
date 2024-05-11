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
<link href="${pageContext.request.contextPath }/resources/css/cs.css" rel="stylesheet" type="text/css">


  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="UTF-8">


<!-- 토스트그리드 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<!-- 
토스트그리드 - 페이징
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script> 보다 위에 있어야 작동함
 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<title>Insert title here</title>
<script type="text/javascript">
	window.onload = function(){
		$.ajax({
			url : "getDeliveryDoneList",
			method :"GET",
			dataType : "JSON",
			success : function(result){
				grid.resetData(result);
			}, 
			error : function () {
				alert("요청 실패");
			}
		});
		
		const grid = new tui.Grid({
			el: document.getElementById('grid'),
			scrollX: true,
			scrollY: false,
			rowHeaders: ['rowNum'],
			pageOptions: {
				useClient: true,
				perPage: 5
			},
			columns: [
// 				{
// 					header: '배달 번호',
// 					name: 'zman_delivery_idx',
// 					sortingType: 'desc',
// 					sortable: true
// 				},
// 				{
// 					header: '출발지',
// 					name: 'zman_delivery_startspot'
// 				},
// 				{
// 					header: '도착지',
// 					name: 'zman_delivery_endspot'
// 				},
				{
					header: '배달 물품',
					name: 'order_secondhand_product'
				},
				{
					header: '배달료',
					name: 'zman_delivery_commission'
				},
				{
					header: '수락 시간',
					name: 'zman_delivery_accepttime'
// 					sortingType: 'desc',
// 		            sortable: true
				},
				{
					header: '출발 시간',
					name: 'zman_delivery_starttime'
// 					sortingType: 'desc',
// 		            sortable: true
				},
				{
					header: '도착 시간',
					name: 'zman_delivery_endtime'
// 					sortingType: 'desc',
// 		            sortable: true
				},
// 				{
// 					header: '배달 상태',
// 					name: 'zman_delivery_status', 
// 				}, 
// 				{
// 					header: '회원타입',
// 					name: 'member_type', 
// 					filter: 'select', 
// 				}, 
// 				 {
// 		            header: '상세보기',
// 		            name: 'member_idx',
// 		            formatter: function(row, column, value) {
// 		                let zman_delivery_idx = row.value.zman_delivery_idx;
// 		                let url = 'GetDeliveryDoneDetail?zman_delivery_idx=' + 'zman_delivery_idx';
// 		                return '<a class="btn btn-sm btn-outline-dark" href="' + url + '">상세보기</a>';
// 		            }
				{
					header: '상세보기',
					name: 'zman_delivery_idx', 
					formatter: function(row, column, value){
						let url = 'GetDeliveryDoneDetail?zman_delivery_idx=' + JSON.stringify(row.value);
						return '<a class="btn btn-sm btn-outline-dark" href="' + url + '">상세보기</a>'; 
					}
				},
			]
		});
		
	};
	
</script>
<style type="text/css">
	#user_membership {
		margin: 25px;
	}

	.content_title[data-v-88eb18f6] {
	    display: flex;
	    padding: 5px 0 6px;
	    padding-bottom: 16px;
	    border-bottom: 3px solid #222!important;
	}

	#sec01 {
		display: flex;
		justify-content: center;
		align-items: center;	
	}
</style>
<script>

</script>
</head>
<body>
	<%-- 헤더 영역 --%>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
		
	<article id="mainArticle">
		<div class="container">
			<%-- 사이드 바 영역 --%>
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/zman_sidebar.jsp"></jsp:include>
			</nav>
			<div class="contentArea">
				<div id="main">
<!-- 				<h1>배달 완료</h1> -->
				<div data-v-88eb18f6="" data-v-cf6a6ef4="" class="content_title">
					<div data-v-88eb18f6="" class="title">
						<h3 data-v-88eb18f6="">배달 완료</h3>
						
						<nav class="navbar navbar-light"><%-- 사이드바 사라졌을 때 햄버거 메뉴 --%>
							<a class="navbar-brand" href="#"></a>
							<button class="navbar-toggler collapsed border-0 hidden_nav" type="button" data-toggle="collapse" data-target="#csCollapse" aria-controls="csCollapse" aria-expanded="false" aria-label="Toggle navigation">
								<span class="navbar-toggler-icon"></span>
							</button>
							<jsp:include page="/WEB-INF/views/inc/zman_sidebar_hidden.jsp"></jsp:include>
						</nav>
					</div>
				</div>
									
				<%--ZMAN 프로필 영역 --%>
				<section id="sec01">
					<div class="user_membership" data-v-32a5de90="" data-v-412d8616="">
						<div class="user_detail" data-v-32a5de90="">
							<div class="user_thumb01" data-v-32a5de90="">
								<br>
								
								<strong class="name" data-v-32a5de90="">${zman.zman_name }</strong> &nbsp;|&nbsp;
								<strong class="email" data-v-32a5de90="">${sessionScope.member_id }</strong>&nbsp;|&nbsp;
								<strong class="phone" data-v-32a5de90="">${zman.zman_phone }</strong>&nbsp;|&nbsp;
								<strong class="phone" data-v-32a5de90="">${zman.zman_transport }</strong>&nbsp;|&nbsp;
								<strong class="phone" data-v-32a5de90="">${zman.zman_status }</strong>
									<%-- 프로필 관리는 사이드바로 빼기 --%>
<!-- 										<a href="/my/profile-edit" type="button" -->
<!-- 											class="btn btn outlinegrey small" data-v-43813796="" -->
<!-- 											data-v-32a5de90=""> 프로필 관리 </a> -->
							</div>
						</div>
					</div>
				</section>
				
				<hr>
					<%-- main 내용 작성 영역 --%>
					<div id="grid"></div>
					
				
				</div> <%-- <div id="main">  --%>
			</div>
		</div>
	</article>
</body>
</body>
</html>