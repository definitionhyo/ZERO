<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>


<!-- <!-- 부트스트랩 --> 
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script> -->
<!-- <!-- daum API --> 
<!-- <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> -->
<!-- <!-- 제이쿼리 --> 
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script> -->
<!-- <!-- 반응형웹페이지위한 설정 -->  
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<script type="text/javascript">


$(function(){
    var savedImageUrl = "${jsonData}";
   	var image1Url=saveImageUrl.image1Url;
   	var image2Url=saveImageUrl.image2Url;
   	var image3Url=saveImageUrl.image3Url;
});

//<!-- 이미지 추가버튼 스크립트 -->--------------------
// var image_list = [
// 		if(${secondhandProduct.secondhand_image1} != null){
// 			${secondhandProduct.secondhand_image1}	
			
// 		} else if(${secondhandProduct.secondhand_image2} != null){
// 			, ${secondhandProduct.secondhand_image2}
			
// 		}  else if(${secondhandProduct.secondhand_image3} != null){
// 			,  ${secondhandProduct.secondhand_image3}	
// 		}
// 	];
var preview_array  = [false, false, false];
// var change_image = ["0","0","0","0","0","0","0","0","0"];

// for(var y=0; y<${ fn:length(vo.image_list) }; y++){
// 	preview_array[y] = true;
// }
for(var y=0; y < image_list.length(); y++){
	preview_array[y] = true;
}

//이미지 미리보기 등록 작업
function img_preview() {
	for(var i=0; i<preview_array.length; i++){
		
		/* i가 0일때 */
		if(i==0){	
			/* 0번사진 비어있으면 */
			if(preview_array[0]==false){
				/* 섬네일사진 */
				/* 0번사진 인풋태그 호출 */
				
				send_0();
				return;
			}
		}
		
		/* i가1일때 */
		if(i==1){	
			/* 1번사진이 비어있으면 */
			if(preview_array[1]==false){
				/* 1번사진 인풋태그 호출 */
				send_1();
				return;
			}
		}
		
		/* i가 2일때 */
		if(i==2){
			/* 2번사진 비어있으면 */
			if(preview_array[2]==false){
				/* 2번사진 인풋태그 호출 */
				send_2();
				return;
			}
		}
			
	}/*  for end */
	alert("더이상 등록할 수 없습니다.");
	return;
}/* 이미지 미리보기 end */
</script>


<script type="text/javascript">
//<!-- 이미지 미리보기 -->------------------------------------------------------

	// 1. 썸네일사진
	function send_0() {
		$("#sumimage").click();		
	}
	
	$(function(){	
		$("#sumimage").on('change',function(){
			if( $("#sumimage")[0].files[0]==undefined) {
				return;
			}			
			imgcheck0(this);
		})
	});

	function imgcheck0(input) {
		/* 이미지파일명 체크 */
		var myfile_sub = input.value.lastIndexOf('\\');
		var myreal_file = input.value.substring(myfile_sub+1, input.length);
		
		/* 이미지 확장자 파일체크 */
		var file_kind = input.value.lastIndexOf('.');
		var file_name = input.value.substring(file_kind+1,input.length);
		var file_type = file_name.toLowerCase();
	
		var check_array = new Array( 'jpg','png','jpeg' );
		
		$('#sumimage').val();
		if(check_array.indexOf(file_type)==-1){
			
			/* 사용자에게 알려주고 */
			alert('이미지 파일만 선택할 수 있습니다.');
			/* 실제 업로드 되는 input태그 vlaue값 지우기 */
			$('#sumimage').val('');
			return;
		} 
	
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
		        $('#imgup_sum').attr('src', e.target.result);
		        	
				/* 수정한 사진이면.. */
// 		        if('${ not empty vo.image_list[0].i_idx}' == 'true'){
		        if('${ not empty secondhandProduct.secondhand_image1}' == 'true'){
		        	change_image[0] = '${secondhandProduct.secondhand_image1}';
		        } else{
		        	/* 추가한 사진이면.. */
		        	change_image[0] = "changePhoto";
		        }
		        change_image[1] = myreal_file;
	
		        $("#img_preview0").css("display","inline-block");
				$("#imgup_sum").show();
		        $("#del_sum").show();
		       
				preview_array[0] = true;
				
				/* 이미지넘버 변경 */
				img_num();
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	
	// 2. 1번사진
	
	function send_1() {
		$("#imageFile1").click();
	}
	$(function(){	
		$("#imageFile1").on('change',function(){
			
			// 파일선택 취소시 
			if( $("#imageFile1")[0].files[0]==undefined) {		
				return;
			}
			imgcheck1(this);
		})
	});
	
	function imgcheck1(input) {	
		/* 이미지파일명 체크 */
		var myfile_sub = input.value.lastIndexOf('\\');
		var myreal_file = input.value.substring(myfile_sub+1, input.length);
		
		/* 이미지 확장자 파일체크 */
		var file_kind = input.value.lastIndexOf('.');
		var file_name = input.value.substring(file_kind+1,input.length);
		var file_type = file_name.toLowerCase();
	
		var check_array = new Array( 'jpg','png','jpeg' );
	
		if(check_array.indexOf(file_type)==-1){		
			alert('이미지 파일만 선택할 수 있습니다.');
			/* 실제 업로드 되는 input태그 vlaue값 지우기 */
			$('#imageFile1').val('');
			return;
		} 
		
		
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	        
	        	$('#imgup_1').attr('src', e.target.result);
	        	
	        	/* 수정한 사진이면.. */
	        	if('${ not empty secondhandProduct.secondhand_image2}' == 'true'){
	        		change_image[2] = '${secondhandProduct.secondhand_image2}';
	        	}else{
	        		/* 추가한 사진이면.. */
	        		change_image[2] = "changePhoto";
	        	}
	        	
	        	change_image[3] = myreal_file;
				
	        	$("#img_preview1").css("display","inline-block");
	        	$("#imgup_1").show();
	        	$("#del_img1").show();
	        	
	        	//배열에 트루값주기, 트루면 업로드 못함
	        	preview_array[1] = true;
				
	        	/* 이미지넘버 변경 */
	        	img_num();
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	// 2번 사진
	
	function send_2() {
		$("#imageFile2").click();
	}
	$(function(){
		$("#imageFile2").on('change',function(){
			/* 파일선택 취소했을때 */
			if( $("#imageFile2")[0].files[0]==undefined) {
				return;
			}
			imgcheck2(this);
		})
	});
	
	function imgcheck2(input) {
		
		/* 이미지파일명 체크 */
		var myfile_sub = input.value.lastIndexOf('\\');
		var myreal_file = input.value.substring(myfile_sub+1, input.length);
		
		/* 이미지 확장자 파일체크 */
		var file_kind = input.value.lastIndexOf('.');
		var file_name = input.value.substring(file_kind+1,input.length);
		var file_type = file_name.toLowerCase();
	
		var check_array = new Array( 'jpg','png','jpeg' );
	
		if(check_array.indexOf(file_type)==-1){
			alert('이미지 파일만 선택할 수 있습니다.');
			/* 실제 업로드 되는 input태그 vlaue값 지우기 */
			$('#imageFile2').val('');
			
			return;
		} 
		
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
				$('#imgup_2').attr('src', e.target.result);
				
	        	/* 수정한 사진이면.. */
	        	if('${ not empty secondhandProduct.secondhand_image3}' == 'true'){
	        		change_image[4] = '${secondhandProduct.secondhand_image3}';
	        	} else{
	        		/* 추가한 사진이면.. */
	        		change_image[4] = "changePhoto";
	        	}
	        	change_image[5] = myreal_file;
				
				$("#img_preview2").css("display","inline-block");
				$("#imgup_2").show();
				$("#del_img2").show();
				
				preview_array[2] = true;
	        	/* 이미지넘버 변경 */
				img_num();
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
//------------------------------------------------------------------------------
</script>

<script type="text/javascript">
//<!-- 이미지미리보기삭제 -->---------------------------------------------------
	
	function del_sum() {
		alert('썸네일이미지 지움');
		
		/* 실제 DB에 들어가는 input value 지움 */
		$('#sumimage').val('');
		
	    $("#img_preview0").css("display","none");
		$('#imgup_sum').hide();
		$("#del_sum").hide(); 
		
		/* 썸네일 비움 */
		preview_array[0] = false;
		/* 이미지 넘버변경 */
		img_num();
		
		return;
	}
	
	
	function del_img1() {
		alert('1번이미지 지움');	
		$('#imageFile1').val('');
		
		$("#img_preview1").css("display","none");
		$('#imgup_1').hide();
		$("#del_img1").hide();
		
		/* 1번사진 비움 */
		preview_array[1] = false;
		
		/* 삭제한 사진이면.. */
        if('${ not empty secondhandProduct.secondhand_image2}' == 'true'){
        	change_image[2] = '${secondhandProduct.secondhand_image2}';
        	change_image[3] = "delPhoto";
        }
		
		/* 이미지 넘버변경 */
		img_num();
		
		return;
	}
	
	function del_img2() {
		/* alert('2번이미지 지움'); */
		
		$('#imageFile2').val('');
		
		$("#img_preview2").css("display","none");
		$('#imgup_2').hide();
		$("#del_img2").hide();
		
		/* 2번사진 비움 */
		preview_array[2] = false;
		
		/* 삭제한 사진이면.. */
        if('${ not empty secondhandProduct.secondhand_image3}' == 'true'){
        	change_image[4] = '${secondhandProduct.secondhand_image3}';
        	change_image[5] = "delPhoto";
        }
		
		/* 이미지 넘버변경 */
		img_num();
		
		return;
	}


</script>


<style>

body{
	  font-family: 'Gowun Dodum', sans-serif;
	}
	#root {
		/* 		background: #ccffcc; */
		width: 100%;
		height: 100%;
	}
	
	/* 실제 전체 div */
	#modify_box {
		width: 1020px;
		margin: auto;
		padding-top : 160px;
		/* 		background: gray; */
		min-height: 1000px;
		text-align: center;
	}
	
	/* 인클루드 한 메인프레임 */
	#mainframe {
		/* position : absolute; */
		/* z-index: 999; */
	}
	
	
	#title {
		font-size: 40px;
	}
	
	/* span태그 */
	.pro_info {
		font-size: 20px;
	}
	
	/* 전체 인풋태그 css */
	.input-tag {
		display: inline-block;
		height: 35px;
		padding: 5px;
		vertical-align: middle;
		border: 1px solid black;
		width: 100%;
		color: black;
		font-size: 15px;
		border-radius: 5px;
	}
	
	/* 이미지 미리보기 css */
	#img_preview0, #img_preview1, #img_preview2, #img_preview3, #img_preview4, #img_preview5{
		display: none;
		position: relative;
		
		margin:5px;
		
		width: 150px;
		height: 150px; 
		
/* 		border: 2px solid black; */
	
	}
	/* 미리보기 삭제버튼 css */
	#sum_style{
		text-align:center;
		width:75px;
		height:20spx;
	    position:absolute; 
		font-size:12px;
		outline:none;
		border:none;
		border-radius:15px;
	    right:70px;
	    bottom:130px;
	    /* z-index:1; */
	    background-color:rgba(0,0,0,0.5);
	    color:white;
	}
	.chk_style{
		vertical-align: middle;
		text-align:center;
		
		width:28px;
		height:28px;
	    position:absolute; 
		/* font-size:20px; */
		outline:none;
		border:none;
		border-radius:18px;
	    right:9px;
	    bottom:115px;
	    /* z-index:1; */
	    background-color:rgba(0,0,0,0.5);
	    color:#ffcccc;
	}
	
		
	/* 미리보기 삭제 css */
	#del_img1, #del_img2, #del_img3, #del_img4, #del_img5,#del_sum{
		cursor: pointer;
		display: none;
	}
	
	#imgup{
		margin-top: 5px;
	}
	
	/* 이미지 미리보기 css */
	#imgup_1,#imgup_2, #imgup_3, #imgup_4, #imgup_5,#imgup_sum {
		cursor: pointer;
		display: none;
	}
	
	
	.input-tag:focus{
		outline: none;
		border: 1px solid black;
	}
	
	/* 제목입력창 넓이 */
	#p_name {
		width: 88%;
	}
	
	
	
	/* 제품설명 textarea css */
	#p_exp {
		padding: 15px;
		width: 100%;
		height: 150px;
		resize: none;
	}
	
	/* 주소버튼 */
	#addrfind, #myaddr{
		
		background: white;
		cursor: pointer;
		border: 1px solid black;
		width: 90px;
		height: 40px;
		
	}
	
	/* 상품 상태 */
/* 	#p_condition { */
/* 		width: 15px; */
/* 		height: 15px; */
/* 	} */
	
	/* 거래 방법*/
	#p_delivery_type {
		width: 15px;
		height: 15px;
	}
	
	/* 결제방법 */
	#p_paymentType {
		width: 15px;
		height: 15px;
	}
	
	
	input {
		accent-color: red;
	}
	
	/* 테이블 간의 간격 */
	td {
		width: 1020px;
		padding: 0.8em 1.4em 0.5em 0.8em;
	}
	
	.td1{
		width: 20%;
		vertical-align: top;
	}
	
	.td2{
		width: 80%;
	}
	#img_zone{
		
		/* background-color: black; */
		margin: auto; 
		width: 65%; 
		min-height: 50px;
		margin-bottom: 50px;
	}
	#img_intro{
		
		font-size:16px;
		color : skyblue;
		/* background-color: #ccffcc; */
		margin: auto; 
		width: 65%; 
		min-height: 50px;
	}

</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/product_modify.js"></script>

<title>Insert title here</title>
</head>

<body>
<header><%@ include file="../inc/header.jsp"%></header>
	<!-- 파일업로드 용 폼 -->
	<form enctype="multipart/form-data" id="imgform" method="post">
		<input type="file" id="sumimage"   style="display: none;" accept=".jpg, .jpeg, .png">
		<input type="file" id="imageFile1" style="display: none;" accept=".jpg, .jpeg, .png">
		<input type="file" id="imageFile2" style="display: none;" accept=".jpg, .jpeg, .png">
	</form>

	<div id="root">
		<input type="hidden" id="member_id" value="${sessionScope.member_id }">
		<input type="hidden" id="secondhand_idx" value="${secondhandProduct.secondhand_idx }">
		<input type="hidden" id="pageNum" value="${param.pageNum }">
		
		<div id="modify_box">
			<span id="title">상품수정</span>

			<table style="margin-top: 30px;">
				<!-- 기본정보 -->
				<tr>
					<td colspan="2" align="left"><span class="pro_info">기본정보</span>
						&nbsp;&nbsp;&nbsp; <span style="font-size: 14px; color: red">*필수항목</span></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>

				<!-- 상품이미지 -->
				<!-- 기존등록된 상품이미지 표시 된 상태 -->
				<tr>
					<td class="td1" align="left" ><span
						class="pro_info">상품이미지</span> 
						<!-- 이미지 데이터 존재하는 개수 반환 -->
						<span class="pro_info" id="img_number">(${ fn:length(image_list) }/3)</span>
						<span style="color: red">*</span>
						<input type="image" id="imgup" onclick="img_preview();"
								src="${ pageContext.request.contextPath }/resources/img/image_upload.png" width="150px" height="150px">
						</td>
					<td class="td2" align="left">
					
					
					
						<!-- 이미지 등록 영역 -->
						<div id="img_zone">
							<div id="img_preview0" >
								<input type="image" id="imgup_sum" onclick="send_0();"
									src="${ pageContext.request.contextPath }/resources/upload/${secondhandProduct.secondhand_image1 }" width="150px" height="150px">
								<span id="sum_style" >대표 이미지</span>
								<!-- 삭제버튼 -->
								<span id="del_sum" class="chk_style"  onclick="del_sum();">x</span>
							</div>
							
							<!-- 1번이미지 데이터가 있으면 -->	
							<c:if test="${ not empty secondhandProduct.secondhand_image2}">
								<div id="img_preview1" >
									<input type="image" id="imgup_1" onclick="send_1();"
										src="${ pageContext.request.contextPath }/resources/upload/${secondhandProduct.secondhand_image2 }" width="150px" height="150px">
									<!-- 삭제버튼 -->
									<span id="del_img1" class="chk_style" onclick="del_img1();">x</span>
								</div>
							</c:if>
							<!-- 1번이미지 데이터 없으면  -->
							<c:if test="${ empty secondhandProduct.secondhand_image2}">
								<div id="img_preview1" style="display: none;">
									<input type="image" id="imgup_1"  style="display: none;" onclick="send_1();"
										src="" width="150px" height="150px">
									<!-- 삭제버튼 -->
									<span id="del_img1"  class="chk_style" style="display: none;" onclick="del_img1();">x</span>
								</div>
							</c:if>	
							
							
							<!-- 2번이미지 데이터가 있으면 -->	
							<c:if test="${ not empty secondhandProduct.secondhand_image3}">
								<div id="img_preview3">
									<input type="image" id="imgup_2" onclick="send_2();"
										src="${ pageContext.request.contextPath }/resources/upload/${secondhandProduct.secondhand_image3 }" width="150px" height="150px">
									<!-- 삭제버튼 -->
									<span id="del_img2" class="chk_style" onclick="del_img2();">x</span>
								</div>
							</c:if>
							
							
							<!-- 2번이미지 데이터가 없으면 -->	
							<c:if test="${empty secondhandProduct.secondhand_image3}">
								<div id="img_preview2" style="display: none;">
									<input type="image" id="imgup_2" style="display: none;" onclick="send_2();"
										src="" width="150px" height="150px">
									<!-- 삭제버튼 -->
									<span id="del_img2" class="chk_style" style="display: none;" onclick="del_img2();">x</span>
								</div>
							</c:if>
						</div>
						
						
						<div id="img_intro">
							* <b>대표 이미지</b>는 반드시 <font color="red"><b>등록</b></font>해야 합니다.<br>
							- 이미지를 <b>클릭할</b> 경우 이미지를 <b>수정</b>하실 수 있습니다.<br>
							- 이미지 등록은 좌측 <b>이미지 등록</b>을 눌러 등록할 수 있습니다.<br>
							- 이미지 확장자는 <b>.jpg, .jpeg, .png</b> 만 등록 가능합니다.
						</div>
					</td>
				</tr>

				<tr><td colspan="2"><hr></td></tr>
				
				<!-- 제목  -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span
						class="pro_info">제목<span style="color: red">*</span></span></td>
					<td class="td2" align="left">
						<div style="display: inline-block; min-width: 70px; ">
							<span class="pro_info" id="name_length">0/40</span>
						</div>
						<input maxlength="40" value="${secondhandProduct.secondhand_subject}"
						oninput="numberMaxLength(this);" type="text" id="p_name"
						name="p_name" class="input-tag" placeholder="기존제목내용">
					</td>
				</tr>

				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
				<!-- 카테고리 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;">
						<span class="pro_info">카테고리<span style="color: red">*</span></span>
					</td>
					<td class="td2" align="left">
						<select class="input-tag" id="c_idx" name="c_idx" style="width: 30%; height: 35px;">
								<option value="0">카테고리 선택</option>
								<c:forEach var="category" items="${categorylist }">
									<option value="${category.category_idx }"> ${category.category_name }</option>
								</c:forEach>
						</select>
					</td>
				</tr>

				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
				
				
				<!-- 거래지역 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span
						class="pro_info"> 희망 거래지역 </span></td>
					
					<td align="left">
						<input type="button" id="myaddr" value="내주소" onclick="myAddr();">
						<input type="button" id="addrfind" value="주소찾기" onclick="addrFind();">
						<br>
						<input type="text" id="p_location" class="input-tag" style="margin-top: 5px;" readonly="readonly">
					</td>
				</tr>

				<tr>
					<td colspan="2"><hr></td>
				</tr>



				<!-- 거래방법 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;">
						<span class="pro_info">거래방법
							<span style="color: red">*</span>
						</span>
						<div class="pro_info" style="font-size: 15px; color:gray;"> 중복 선택 가능 </div>
					</td>
					<td class="td2" align="left">

						<input type="checkbox" name="p_delivery_type" id="p_delivery_type" value="직거래" >
						<span class="pro_info">직거래</span> 
						
						<input type="checkbox" name="p_delivery_type" id="p_delivery_type2" value="택배거래"> 
						<span class="pro_info">택배거래</span>
						
						<input type="checkbox" name="p_delivery_type" id="p_delivery_type3" value="Z스테이션"> 
						<span class="pro_info">Z스테이션</span>
						
						<input type="checkbox" name="p_delivery_type" id="p_delivery_type4" value="Z맨"> 
						<span class="pro_info">Z맨</span>
					</td>
				</tr>
				
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
				
				<!-- 결제방법 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;">
						<span class="pro_info">결제방법
							<span style="color: red">*</span>
						</span>
						<div class="pro_info" style="font-size: 15px; color:gray;"> 중복 선택 가능 </div>
					</td>
					<td class="td2" align="left">
					
		
						<input type="checkbox" name="p_paymentType" id=p_paymentType value="직접송금"> 
						<span class="pro_info">직접송금</span>
						
						<input type="checkbox" name="p_paymentType" id="p_paymentType2" value="Z페이" >
						<span class="pro_info">Z페이</span> 
					</td>
				</tr>




				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
				<!-- 가격  -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;">
						<span class="pro_info">
							가격
							<span style="color: red">*</span>
						</span>
					</td>
					
					<td class="td2" align="left">
						<input type="text" id="p_price"
							maxlength="11" name="p_price" class="input-tag" placeholder="가격"
							value="<fmt:formatNumber pattern="#,###" value="${ secondhandProduct.secondhand_price }"/>"
							oninput="numberMaxLength(this);"
							style="width: 30%;"> &nbsp; 
						<span class="pro_info"> 원
						</span> <br> 
						<span class="pro_info" id="price_under"></span>
					</td>
				</tr>

				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
				<!-- 상품설명 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span
						class="pro_info">상품설명<span style="color: red">*</span></span></td>
					<td align="left">
					
						<br>
						<div>
						<textarea class="input-tag"
							id="p_exp" name="p_exp" maxlength="1000"
							oninput="numberMaxLength(this);"
							placeholder="구입연도, 브랜드, 사용감, 하자유무 등 필요한 정보를 넣어주세요. &#13;&#10;구매자의 문의를 좀더 줄일 수 있습니다.">${ secondhandProduct.secondhand_content }</textarea>
						</div>
						<div align="right"><span style="font-size: 18px;"id="exp_length">${ fn:length(secondhandProduct.secondhand_content) }/1000</span></div>
					</td>
				</tr>

				<tr>
					<td colspan="2"><hr></td>
				</tr>
				

				<!-- 등록 취소버튼 -->
				<tr>
					<td colspan="2">
						<input class="btn btn-success" type="button" value="수정하기" onclick="proInfoModify();"> 
						<input class="btn btn" type="button" value="취소하기" onclick="procancel()"></td>
				</tr>
				
			</table>
		</div>
	<div style="min-height: 200px;"></div>
	</div>
</body>
</html>