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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">


<title>상품수정</title>
<style>

body{
	  font-family: 'Gowun Dodum', sans-serif;
	  
	}
.container{

	margin-top:300px;

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
</head>
<body>





<header><%@ include file="../inc/header.jsp"%></header>


	<div class="container">
<!-- 	<form id="imageForm" enctype="multipart/form-data"> -->
<!-- 	  <input type="file" id="imageInput1" accept="image/*"> -->
<!-- 	  <input type="file" id="imageInput2" accept="image/*"> -->
<!-- 	  <input type="file" id="imageInput3" accept="image/*"> -->
<!-- 	  <button type="button" id="uploadButton">Upload</button> -->
<!-- 	</form> -->



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
			
			
			
			
			
				<div id="imagePreviewContainer">
					<form id="imageForm" enctype="multipart/form-data">
<!-- 					  <input type="file" id="imageInput1" accept="image/*"> -->
<!-- 					  <input type="file" id="imageInput2" accept="image/*"> -->
<!-- 					  <input type="file" id="imageInput3" accept="image/*"> -->
<!-- 					  <button type="button" id="uploadButton">Upload</button> -->
				
				
				
				<c:choose>
					<c:when test="${not empty secondhandProduct.secondhand_image1}">
						<img id="imagePreview1" src="${secondhandProduct.secondhand_image1 }" alt="Image Preview1">
						<input type="file" id="imageInput1" accept="image/*">
						<button type="button" id="deleteButton1">X</button>
					</c:when>
					
					<c:otherwise>
						 <img id="imagePreview1" src="#" alt="Image Preview1">
						<input type="file" id="imageInput1" accept="image/*">
					    <button type="button" id="deleteButton1">X</button>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${not empty secondhandProduct.secondhand_image2}">
						<img id="imagePreview2" src="${secondhandProduct.secondhand_image2 }" alt="Image Preview2">
											  <input type="file" id="imageInput2" accept="image/*">
						
						<button type="button" id="deleteButton2">X</button>
					</c:when>
					
					<c:otherwise>
						 <img id="imagePreview2" src="#" alt="Image Preview2">
						 					  <input type="file" id="imageInput2" accept="image/*">
						 
					    <button type="button" id="deleteButton2">X</button>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${not empty secondhandProduct.secondhand_image3}">
						<img id="imagePreview3" src="${secondhandProduct.secondhand_image3 }" alt="Image Preview3">
											  <input type="file" id="imageInput3" accept="image/*">
						
						<button type="button" id="deleteButton3">X</button>
					</c:when>
					
					<c:otherwise>
						 <img id="imagePreview3" src="#" alt="Image Preview3">
						 					  <input type="file" id="imageInput3" accept="image/*">
						 
					    <button type="button" id="deleteButton3">X</button>
					</c:otherwise>
				</c:choose>
				
				<!--   <img id="imagePreview1" src="#" alt="Image Preview1"> -->
				<!--     <button type="button" id="deleteButton1">Delete</button> -->
				  
				<!--   <img id="imagePreview2" src="#" alt="Image Preview2"> -->
				<!--     <button type="button" id="deleteButton2">Delete</button> -->
				  
				<!--   <img id="imagePreview3" src="#" alt="Image Preview3"> -->
				<!--   	<button type="button" id="deleteButton3">Delete</button> -->
				</form>
				
				</div>

			</table>
		</div>
	<div style="min-height: 200px;"></div>
	</div>


</div><%--컨테이너끝 --%>

<script>
document.addEventListener("DOMContentLoaded", function () {
	  const imageInput1 = document.getElementById("imageInput1");
	  const imageInput2 = document.getElementById("imageInput2");
	  const imageInput3 = document.getElementById("imageInput3");
	  
	  const uploadButton = document.getElementById("uploadButton");
	  const imagePreviewContainer = document.getElementById("imagePreviewContainer");
	  const imagePreview1 = document.getElementById("imagePreview1");
	  const imagePreview2 = document.getElementById("imagePreview2");
	  const imagePreview3 = document.getElementById("imagePreview3");
	  
	  const deleteButton1 = document.getElementById("deleteButton1");
	  const deleteButton2 = document.getElementById("deleteButton2");
	  const deleteButton3 = document.getElementById("deleteButton3");

	  imageInput1.addEventListener("change", function (event) {
	    const file = event.target.files[0];
	    if (file) {
	      const reader = new FileReader();
	      reader.onload = function (e) {
	    	  imagePreview1.src = e.target.result;
	    	  imagePreview1.style.display = "block";
	      };
	      reader.readAsDataURL(file);
	    }
	  });
	  imageInput2.addEventListener("change", function (event) {
		    const file = event.target.files[0];
		    if (file) {
		      const reader = new FileReader();
		      reader.onload = function (e) {
		    	  imagePreview2.src = e.target.result;
		    	  imagePreview2.style.display = "block";
		      };
		      reader.readAsDataURL(file);
		    }
		  });
	  
	  imageInput3.addEventListener("change", function (event) {
		    const file = event.target.files[0];
		    if (file) {
		      const reader = new FileReader();
		      reader.onload = function (e) {
		    	  imagePreview3.src = e.target.result;
		    	  imagePreview3.style.display = "block";
		      };
		      reader.readAsDataURL(file);
		    }
		  });
	  
	  

	  uploadButton.addEventListener("click", function () {
	    // Upload the image to the server and save to the database
	    // Implement your upload logic here
	    // After successful upload, you can display a success message or perform other actions
	  });
	  
	  
	  

	  deleteButton1.addEventListener("click", function () {
		  imagePreview1.style.display = "none";
	    imagePreview1.src = "#";
	    imageInput1.value = ""; // Clear the selected file
	  });
	  deleteButton2.addEventListener("click", function () {
		  imagePreview2.style.display = "none";
		    imagePreview2.src = "#";
		    imageInput2.value = ""; // Clear the selected file
		  });
	  deleteButton3.addEventListener("click", function () {
		 	imagePreview3.style.display = "none";
		    imagePreview3.src = "#";
		    imageInput3.value = ""; // Clear the selected file
		  });
	  
	  
	  
	});
</script>



</body>
</html>