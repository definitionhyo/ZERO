<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- JSTL 의 함수를 사용하기 위해 functions 라이브러리 추가 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	function emptyFile(){
		$("#insertImg").empty();
		$("#insertImg").html(
			'<input type="file" class="form-control" aria-label="cs_file" name="file" />'	
		);
	};
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
					<h1 class="mt-4">고객센터 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">1 : 1 문의글 상세페이지 </li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="content_main">
						<%-- form 태그 시작 --%>
						<c:choose>
							<%-- 답변 없음 - 등록하기 --%>
							<c:when test="${empty cs.cs_reply }"> 
								<form action="admin_cs_qna_reply" method="post" name="fr" enctype="multipart/form-data">								
							</c:when>	
							<%-- 답변 있음 - 수정하기 --%>					
							<c:otherwise>
								<form action="admin_cs_qna_reply_modify" method="post" name="fr" enctype="multipart/form-data">		
							</c:otherwise>
						</c:choose>
							<%-- hidden 영역 --%>
							<%-- 고객센터 cs_type 유형 정보 전송용 : 1:1문의 --%>						
							<input type="hidden" name="cs_type" value="1:1문의" >
							<input type="hidden" name="cs_idx" value="${cs.cs_idx }" >
							<input type="hidden" name="cs_info_idx" value="${cs.cs_info_idx}" >
							<input type="hidden" name="member_id" value="${sessionScope.member_id }" >
							
							<table class="table" >
								<tr>
									<th>
									  	문의 유형
									</th>
									<td>
<%-- 										<input type="text" readonly class="form-control-plaintext" id="cs_info_idx"  value="${cs.cs_info_idx }"> --%>
										<c:choose>
											<c:when test="${cs.cs_info_idx eq 1 }">
												중고거래 문의
											</c:when>
											<c:when test="${cs.cs_info_idx eq 2 }">
												경매 문의
											</c:when>
											<c:when test="${cs.cs_info_idx eq 3 }">
												ZPAY 문의
											</c:when>
											<c:when test="${cs.cs_info_idx eq 4 }">
												ZMAN 문의
											</c:when>
											<c:when test="${cs.cs_info_idx eq 5 }">
												회원 문의
											</c:when>
											<c:when test="${cs.cs_info_idx eq 6 }">
												기타 문의
											</c:when>
										</c:choose>
									</td>
						 		</tr>
						 		<tr>
									<th>
										아이디
									</th>
									<td>
										<%-- 회원만 글쓰기 --%>
										<%-- 아이디(이메일주소)는 읽기전용 --%>
		 								<div class="col-sm-10">
									    	<input type="text" class="form-control-plaintext" id="member_id" value="${cs.member_id }" readonly>
									    </div>
									</td>
								</tr>
						  		<tr>
						    		<th>
						    			제목
						    		</th>
						    		<td>
						    			 <input type="text" name="cs_subject" class="form-control" id="cs_subject" value="${cs.cs_subject }" readonly="readonly">
						    		</td>
						  		</tr>
						  		<tr>
						    		<th>
							    		내용
							    	</th>
							    	<td>
							    		 <textarea class="form-control" name="cs_content" id="cs_content" style="height: 100px" onkeyup="isContent(this.value)" readonly="readonly">
							    		 	${cs.cs_content }
							    		 </textarea>
						    		</td>
						  		</tr>
						  		<tr>
						    		<th>
						    			이미지 첨부
						    		</th>
						    		<td>
						    			<%-- 만일 특정파일 유형만 허용하려면 accpet 속성을 사용한다 --%>
						    			<%-- 사진 파일 1개만 업로드 허용 --%>
	    						      	<%-- 첨부파일 다운로드를 위해 하이퍼링크 생성=> download 속성 지정 시 다운로드 가능
					   						(단, 다운로드 시 파일명 변경하여 다운하려면 download="변경할 파일명" 형식으로 지정 --%>
<!-- 						    			<input type="file" name="file" id="file" accept=".JEPG, .JPG, .PNG"> -->
											<c:choose>
												<c:when test="${empty cs.cs_file }">
													등록된 사진이 없습니다.
												</c:when>
												<c:otherwise>
													<a href="${pageContext.request.contextPath }/resources/upload/${cs.cs_file }" download="${fn:split(cs.cs_file, '_')[1] }">
														${cs.cs_file }
													</a>
												</c:otherwise>
											</c:choose>
						    		</td>
						  		</tr>
						  		<tr>
						    		<th>
							    		관리자 답변</em>
							    	</th>
							    	<td>
							    		<c:choose>
											<c:when test="${empty cs.cs_reply }">
<!-- 												<input type="text" name="cs_reply" class="form-control" id="cs_reply" > -->
												<textarea class="form-control" name="cs_reply" id="cs_reply" style="height: 100px"></textarea>
											</c:when>
							  				<c:otherwise>
<%-- 												<input type="text" name="cs_reply" class="form-control" id="cs_reply" value="${cs.cs_reply }">	 --%>
												<textarea class="form-control" name="cs_reply" id="cs_reply" style="height: 100px">${cs.cs_reply }</textarea>			  				
							  				</c:otherwise>
										</c:choose>							  			
						    		</td>
						  		</tr>
						  		<tr>
							  		<td colspan="2" style="text-align: center">
<!-- 										<button class="btn btn-dark" disabled="disabled" type="submit">등록</button>	 -->
											<button class="btn btn-dark" type="button" onclick="history.back()">돌아가기</button>
												<%-- 답변하기 또는 수정하기 버튼  --%>
												<c:choose>
													<%-- 답변이 없을 때 - 답변하기 버튼 출력 --%>
													<c:when test="${empty cs.cs_reply }">
														<button class="btn btn-dark" type="submit">답변하기</button>
													</c:when>
													<%-- 답변이 있을 때 - 수정하기 버튼 출력 --%>
									  				<c:otherwise>
														<button class="btn btn-dark" type="submit">수정하기</button>
									  				</c:otherwise>
												</c:choose>		
											<button type="button" class="btn btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#confirmDeleteNotice">
												&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;
											</button>	
											<%-- 1:1  삭제 확인 모달창 --%>
											<div class="modal fade" id="confirmDeleteNotice" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteNoticeTitle" aria-hidden="true">
												<div class="modal-dialog modal-dialog-centered">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title fs-5" id="confirmDeleteNoticeTitle">1:1 문의글 삭제</h5>
															<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
														</div>
														<div class="modal-body">
															삭제 후 복구가 불가합니다.<br>
															정말 삭제하시겠습니까?<br>
														</div>
														<div class="modal-footer">
															<button type="button" id="${cs.cs_idx }" class="btn btn-dark" onclick="location.href='admin_cs_qna_delete?cs_idx=${cs.cs_idx}'">삭제</button>
															<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
														</div>
													</div>
												</div>
											</div> 
									</td>
						  		</tr>
							</table>
						<c:choose>
							<c:when test="${empty cs.cs_reply }"> <%-- 답변 없음 - 등록하기 --%>
								</form>
							</c:when>						
							<c:otherwise> <%-- 답변 있음 - 수정하기 --%>
								</form>
							</c:otherwise>
						</c:choose>
					</div><!-- content_main 끝 -->
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
</html>
</body>