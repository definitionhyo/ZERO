<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/default.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/sidebar.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/member.css"
	rel="stylesheet" type="text/css">

	
<%-- vue.js 링크 --%>
<!-- <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script> -->
<!-- <style type="text/css"> /*# sourceMappingURL=contenteditable.vue.map */</style> -->




<title>중고거래 사이트</title>
<style>

/* .content_area[data-v-2b15bea4] { */
/*     margin: 0 auto; */
/*     padding: 60px 0 160px; */
/*     width: 400px; */
/* } */


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<script type="text/javascript">

	<%-- 프로필 사진 변경 --%>
	function updateImage(obj) {
		 
		let profileForm = $('#profileForm')[0];  // 이녀석도 배열로 리턴이 된다.
		console.log(profileForm);
// 		let profileForm = obj.files;  // 이녀석도 배열로 리턴이 된다.
		if(profileForm.files == '') {
			alert('프로필 사진을 선택해 주세요');
		} else {
				
		    let formData = new FormData(profileForm);  // 폼의 모든 데이터를 가지고 있다.
			    
		    $.ajax({
		      type: "POST",
		      url: "${pageContext.request.contextPath }/ajax/profileUpdate",
		      contentType: false,  // x-www 으로 파싱하지 마라 
		      processData: false, // 쿼리스트링으로 파싱하지 마라
		      data: formData,
		      enctype: "multipart/form-data",
		      dataType: "text",
		      success: function(result){
// 		    	  alert(result);
		      },
		      error: function(err){
		    	  alert('프로필 등록 실패');
		      }
		    }).done((res) => {
	// 	      alert(res.msg);
		      location.reload();
		    });
		    
		}
		   
	}
	
	<%-- 이미지 이외의 정보 변경 --%>
	$(function(){
		
		// 자기소개 줄바꿈 제한
		$('#member_intro').keydown(function(){
	        var rows = $('#member_intro').val().split('\n').length;
	        var maxRows = 3;
	        if( rows > maxRows){
	            alert('3줄 까지만 가능합니다');
	            modifiedText = $('#member_intro').val().split("\n").slice(0, maxRows);
	            $('#member_intro').val(modifiedText.join("\n"));
	        }
   		});
		
		$(".btn_update").on("click", function(){ // 삭제, 변경 버튼 클릭 시 
			var buttonName = $(this).attr("name");
			let column2;
			let value2; 
		    console.log("클릭한 버튼의 name 속성 값: " + buttonName);
		    console.log("입력 값: " + $("#member_intro").val());
		    

			if(buttonName == 'profile_delete') { // 삭제 버튼 클릭 시
				column2 = 'member_image';
				value2 = null;
			} else if(buttonName == 'member_intro') { // 자기소개 변경 버튼 
				column2 = 'member_intro';
				value2 = $("#member_intro").val();
			} else { // 닉네임 변경 버튼
				column2 = 'member_nickname';
				value2 = $("#member_nickname").val();
			}
			
			$.ajax({
			      type: "POST",
			      url: "${pageContext.request.contextPath }/ajax/profileUpdateInfo",
			      data: {
			    	  "column2":column2,
			    	  "value2":value2
			      },
			      dataType: "json",
			      success: function(result){
			    	  console.log(result);
			    	  alert(result);
			      },
			      error: function(err){
			    	  alert('닉네임 중복으로 변경 실패');
			      }
			 }).done((res) => {
// 				  alert(res.msg);
			      location.reload();
			}); // ajax 끝

		}); // $(".btn_update") 온클릭 끝
		
	});
	

	
</script>

</head>
<body>
 <%--네비게이션 바 영역 --%>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	
	<article id="mainArticle">
	
		<div class="container my lg">
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/member_sidebar_hyo.jsp"></jsp:include>
			</nav>
		
			<div data-v-473e7c14="" class="contentArea">
			<%-- 메인영역 --%>
			

				<div  class=" my lg">
					<div >
			
					<%-- 본문 - 프로필 관리 --%>
						<div class="content_area" data-v-2b15bea4="">
							<form action="user/profileUpdate" method="post" enctype="multipart/form-data" id="profileForm">
								<div data-v-75326462="" class="my_profile">
									<div data-v-88eb18f6="" data-v-75326462="" class="content_title">
										<div data-v-88eb18f6="" class="title">
											<h3 data-v-88eb18f6="">프로필 관리</h3>
										</div>
									</div>
									
									<div data-v-cf6a6ef4="" class="profile_info">
									
										<div data-v-4b474860="" data-v-75326462="" class="user_profile" >
											<input type="file" accept=".jpg,.jpeg,.png" id="profile" name="profile" hidden="hidden" onchange="updateImage(this)">
											<div data-v-4b474860="" class="profile_thumb">
											<c:choose>
												<c:when test="${not empty member.member_image }">
													<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${member.member_image }" alt="사용자 이미지" class="thumb_img">
												</c:when>
												<c:otherwise>
													<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" alt="사용자 이미지" class="thumb_img">
												</c:otherwise>
											</c:choose>
											</div>
											<div data-v-4b474860="" class="profile_detail">
												<strong data-v-4b474860="" class="name">${member_id }</strong>
												<div data-v-4b474860="" class="profile_btn_box">
													<label for="profile">
														<div data-v-43813796="" data-v-4b474860="" class="btn outlinegrey small" >이미지 변경</div>
		<!-- 												<button data-v-43813796="" data-v-4b474860="" type="button" class="btn outlinegrey small" >이미지 변경</button> -->
													</label>
													<button data-v-43813796="" data-v-4b474860="" type="button" class="btn outlinegrey small btn_update" id="profile_delete" name="profile_delete" data-data-v-4b474860=""> 삭제 </button>
												</div>
											</div>
										</div>
										<div data-v-75326462="" class="user_profile" data-v-cf6a6ef4="">
											<div data-v-8b96a82e="" data-v-75326462="" class="profile_group">
												<h4 data-v-8b96a82e="" class="group_title">프로필 정보</h4>
												<div data-v-0c9f3f9e="" data-v-e5372ca2="" data-v-75326462="" class="unit" data-v-8b96a82e="">
													<h5 data-v-0c9f3f9e="" class="title">이름</h5>
													<div data-v-0c9f3f9e="" class="unit_content">
														<p data-v-24a03828="" data-v-e5372ca2="" class="desc desc_modify" data-v-0c9f3f9e=""> ${member.member_name } </p>
		<!-- 												<button data-v-43813796="" data-v-e5372ca2="" type="button" class="btn btn_modify outlinegrey small btn_update"  data-v-0c9f3f9e=""> 변경 </button> -->
													</div>
												</div>
												<div data-v-0c9f3f9e="" data-v-e5372ca2="" data-v-75326462="" class="unit" data-v-8b96a82e="">
													<h5 data-v-0c9f3f9e="" class="title">닉네임</h5>
													<div data-v-0c9f3f9e="" class="unit_content">
		<%-- 												<p data-v-24a03828="" data-v-e5372ca2="" class="desc desc_modify" data-v-0c9f3f9e=""> ${member.member_nickname } </p> --%>
														<input type="text" id="member_nickname" name="member_nickname" data-v-24a03828="" data-v-e5372ca2="" class="desc desc_modify" data-v-0c9f3f9e="" maxlength="25" value="${member.member_nickname }" style="border:none;">
														<button data-v-43813796="" data-v-e5372ca2="" type="button" class="btn btn_modify outlinegrey small btn_update" data-v-0c9f3f9e="" name="member_nickname"> 변경 </button>
													</div>
												</div>
												<div data-v-0c9f3f9e="" data-v-e5372ca2="" data-v-75326462="" class="unit" data-v-8b96a82e="">
													<h5 data-v-0c9f3f9e="" class="title">자기소개</h5>
													<div data-v-0c9f3f9e="" class="unit_content">
	<%-- 													<p data-v-24a03828="" data-v-e5372ca2="" class="desc desc_modify placeholder" data-v-0c9f3f9e="">${member.member_intro }  </p> --%>
														<textarea id="member_intro" name="member_intro" data-v-24a03828="" data-v-e5372ca2="" class="desc desc_modify" data-v-0c9f3f9e="" cols="20"  rows="3" maxlength="300" style="border:none;">${member.member_intro }</textarea>
														<button data-v-43813796="" data-v-e5372ca2="" type="button" class="btn btn_modify outlinegrey small btn_update" data-v-0c9f3f9e="" name="member_intro"> 변경 </button>
		<!-- 												<button data-v-43813796="" data-v-e5372ca2="" type="button" class="btn btn_modify outlinegrey small btn_update" data-v-0c9f3f9e=""> 변경 </button> -->
													</div>
												</div>
											</div>
											<div data-v-8b96a82e="" data-v-75326462="" class="profile_group">
												<h4 data-v-8b96a82e="" class="group_title">신고내역</h4>
												<div data-v-0c9f3f9e="" data-v-75326462="" class="unit" data-v-8b96a82e="">
													<div data-v-0c9f3f9e="" class="unit_content">
														<p data-v-24a03828="" data-v-75326462="" class="desc" role="button" data-v-0c9f3f9e=""> 신고한 내용이 없습니다 </p>
													</div>
												</div>
											</div>
										</div>
									
									</div>
									
								</div>
								<div data-v-75326462="" class="v-portal" style="display: none;">
								</div>
								
							</form>	
							<div data-v-7bcac446 class="snb_var">
								<nav id="subNav" class="snb">
									<jsp:include page="/WEB-INF/views/inc/member_sidebar_hidden.jsp"></jsp:include>
								</nav>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
  </article>
  


  
  <div id="sieAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
  
  
  <%-- 스크립트 코드 --%>
<!--   <script src="/_nuxt/0fc2b9a.js" defer=""></script> -->
<!--   <script src="/_nuxt/c2849e3.js" defer=""></script> -->
<!--   <script src="/_nuxt/6d1f03a.js" defer=""></script> -->
<!--   <script src="/_nuxt/5402e5b.js" defer=""></script> -->
<!--   <script src="/_nuxt/31641e8.js" defer=""></script> -->
<!--   <link href="/_nuxt/css/6ca5ffb.css" rel="stylesheet" type="text/css"> -->
<!--   <link href="/_nuxt/css/caea5a4.css" rel="stylesheet" type="text/css"> -->
  
</body>