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
						<li class="breadcrumb-item active">회원리뷰</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>
							회원리뷰 목록
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>작성자 이름</th>
										<th>작성자 아이디</th>
										<th>제목</th>
										<th>작성일</th>
										<th>상세보기</th>
									</tr>
								<tbody>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td><a class="btn btn-sm btn-outline-dark" href="#">상세보기</a></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>					
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