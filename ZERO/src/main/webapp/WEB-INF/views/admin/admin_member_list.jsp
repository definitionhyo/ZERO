<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<!-- Bootstrap -->
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/css/adminadminstyles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

<!-- 토스트그리드 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<!-- 
토스트그리드 - 페이징
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script> 보다 위에 있어야 작동함
 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<title>ZERO</title>
<script type="text/javascript">
	window.onload = function(){
		$.ajax({
			url : "GetMemberList",
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
				perPage: 10
			},
			columns: [
				{
					header: '이름',
					name: 'member_name',
					sortingType: 'desc',
					sortable: true
				},
				{
					header: '아이디',
					name: 'member_id'
				},
				{
					header: '생년월일',
					name: 'member_birth'
				},
				{
					header: '탈퇴여부',
					name: 'member_status', 
// 					filter: { type: 'text', showApplyBtn: true, showClearBtn: true }, 
					filter: 'select', 
// 					formatter: 'listItemText',
// 					editor: {
// 						type: 'select',
// 						options: {
// 							listItems: [
// 								{ text: '회원', value: '회원' },
// 								{ text: '탈퇴', value: '탈퇴' },
// 								{ text: '관리자', value: '관리자' }
// 							]
// 						}
// 					}
				}, 
				{
					header: '회원타입',
					name: 'member_type', 
					filter: 'select', 
				}, 
				{
					header: '상세보기',
					name: 'member_idx', 
					formatter: function(row, column, value){
						let url = 'GetMember?member_idx=' + JSON.stringify(row.value);
						return '<a class="btn btn-sm btn-outline-dark" href="' + url + '">상세보기</a>'; 
					}
				},
			]
		});
		
	};
	
</script>
<style type="text/css">
	body{
		min-width: 360px;
	}
</style>
</head>
<body class="sb-nav-fixed">
	<header>
		<%@ include file="../inc/admin_header.jsp" %>
		<%@ include file="../inc/admin_sidebar.jsp" %>	
	</header>
	<div id="layoutSidenav">
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">회원관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">회원목록</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div id="grid"></div>
					
				</div>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<%@ include file="../inc/admin_footer.jsp" %>	
			</footer>	
		</div>
	</div>
<!-- 이 스크립트들은 위로 올리면 작동하지 않음 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/demo/chart-area-demo.js"></script>
<script src="${pageContext.request.contextPath }/resources/demo/chart-bar-demo.js"></script>
<script src="${pageContext.request.contextPath }/resources/demo/chart-pie-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/datatables-simple-demo.js"></script>
</body>
</html>