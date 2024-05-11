<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/css/adminstyles.css" rel="stylesheet" type="text/css">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<title>ZERO</title>
<style type="text/css">
	body{
		min-width: 360px;
	}
	.container-fluid {
		max-width: 1000px;
	}
</style>
<script type="text/javascript">
	$(function() {
	    $("#cs_form").submit(function(e) {
	        var csContent = $("#cs_subject").val().trim();
	        
	        if (/^\s*$/.test(csContent)) { // 스페이스바로만 이루어진 공백 감지
	            e.preventDefault(); // 등록 방지
	            
	            alert("제목을 입력해주세요.");
	        }
	    });
	      
	    $("#cs_form").submit(function(e) {
	        var csContent = $("#cs_content").val().trim();
	        
	        if (/^\s*$/.test(csContent)) { // 스페이스바로만 이루어진 공백 감지
	            e.preventDefault(); // 등록 방지
	            
	            alert("내용을 입력해주세요.");
	        }
	    });
	});
</script>
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
					<h1 class="mt-4">고객센터관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">공지사항 작성</li>
					</ol>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>
							공지사항 작성
						</div>
						<div class="card-body">		
							<%-- main 내용 작성 영역 --%>
							<form action="admin_cs_notice_write_pro" id="cs_form" method="post" enctype="multipart/form-data">
								<input type="hidden" name="cs_type" value="공지" ><%-- 공지사항 유형 정보 전송용 --%>						
								<table class="table table-striped text-center align-middle">
								<tbody>
<!-- 									<tr> -->
<!-- 								      <td scope="col" class="align-middle" width="100">번호</th> -->
<!-- 								      <td scope="col" class="align-middle" width="400"><input type="text" class="form-control" aria-label="cs_type_list_idx" name="cs_type_list_idx" id="cs_type_list_idx" readonly></td> -->
<!-- 								    </tr> -->
									<tr>
								      <td scope="col" class="align-middle" width="100">제목</th>
								      <td scope="col" class="align-middle"><input type="text" class="form-control" aria-label="cs_subject" name="cs_subject" id="cs_subject"></td>
								    </tr>
									<tr>
								      <td scope="col" class="align-middle" width="100">작성자</th>
								      <td scope="col" class="align-middle">
								      	<input type="text" class="form-control" aria-label="member_id" name="member_id">
<%-- 									     <input type="text" class="form-control" aria-label="member_id" name="member_id" value="${sessionScope.member_id }" readonly> --%>
								      </td>
								    </tr>
									<tr>
								      <td scope="col" class="align-middle" width="100">내용</th>
								      <td scope="col" class="align-middle"><textarea class="form-control" rows="10" cols="200" name="cs_content" id="cs_content"></textarea></td>
								    </tr>
									<tr>
								      <td scope="col" class="align-middle" width="100">사진첨부</th>
								      <td scope="col" class="align-middle">
					<!-- 			      <input type="file" class="form-control" aria-label="cs_file" name="cs_multi_file"> -->
								      <input type="file" class="form-control" aria-label="cs_file" name="file" />
								      </td>
								    </tr>
									<tr>
										<td scope="col" class="align-middle"></td>
										<td scope="col" class="align-middle">
											<button class="btn btn-dark" type="submit">&nbsp;&nbsp;&nbsp;등록&nbsp;&nbsp;&nbsp;</button>
											<button class="btn btn-outline-dark" type="button" onclick="history.back()">돌아가기</button>
										</td>
								    </tr>
					
								</table>
							</form>
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