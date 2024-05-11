<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<%-- <%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script> -->
<!-- 반응형웹페이지위한 설정 --> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript">

//<!-- 이미지 추가버튼 스크립트 -->--------------------
	var preview_array  = [false, false, false];
	
	<!-- 이미지 등록시 미리보기 추가 작업 -->
	function img_preview() {

		for(var i=0; i<preview_array.length; i++){

// 			for(var i=0; i<preview_array.length; i++){
// 				if(i=[i]){
// 					if(preview_array[i]==false){
// 						send_[i]();
// 						return;
// 					}
// 				}
// 			}
			
			
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
		
	}/* 프리뷰 end */

//-----------------------------------------------------

//<!-- 이미지 장수 표현 함수 -->-----------------------
	function img_num() {
		var img_number = 0;
		
		for(var i=0; i<preview_array.length; i++ ){
			if(preview_array[i]==true){
				img_number++;
			}	
		}
		/* 이미지 장수 표시 */
		$("#img_number").html('('+ img_number + '/3)');
	}
	
	//-----------------------------------------------------------

	
	
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






//<!-- 이미지 미리보기 -->-----------------------------------

	function imgcheck0(input) {
		
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
	
	
	
	/* 1번사진 */
	
	function send_1() {
		$("#imageFile1").click();
	}
	
	$(function(){
		$("#imageFile1").on('change',function(){
			/* 파일선택 취소했을때 */
			if( $("#imageFile1")[0].files[0]==undefined) {
				return;
			}
			imgcheck1(this);
		})
		
	});
	
	function imgcheck1(input) {
		
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
	        	//배열에 트루값주기, 트루면 업로드 못함
	        
	        	$("#img_preview1").css("display","inline-block");
	        	$("#imgup_1").show();
	        	$("#del_img1").show();
	        	
	        	preview_array[1] = true;
				
	        	/* 이미지넘버 변경 */
	        	img_num();
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}

	/* 2번사진 */

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
	
	
	
//-----------------------------------------------------------





//<!-- 이미지미리보기삭제 -->--------------------------------

	function del_sum() {
		/* alert('썸네일이미지 지움'); */
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
		/* alert('1번이미지 지움'); */
		
		$('#imageFile1').val('');
		
		$("#img_preview1").css("display","none");
		$('#imgup_1').hide();
		$("#del_img1").hide();
		
		/* 1번사진 비움 */
		preview_array[1] = false;
		
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
		
		/* 이미지 넘버변경 */
		img_num();
		
		return;
	}
//-----------------------------------------------------------




//<!-- 주소API -->-------------------------------------------
	function addrFind() {
		
		var width = 500; //팝업의 너비
		var height = 300; //팝업의 높이
		
		
	    new daum.Postcode({
	        oncomplete: function(data) {
	         
	            $("#p_location").val(data.address);
	        },
	    
	    	theme: {
		        searchBgColor: "#7dd87d", //검색창 배경색
		        queryTextColor: "white" //검색창 글자색
		    },
		    
		    width: width, 
		    height: height
		    
	    
	    
	    }).open({
	        left: (window.screen.width / 2) - (width / 2),
	        top: (window.screen.height / 2) - (height / 2) - 200
	    });
		
	}

//-----------------------------------------------------------



//<!-- 데이터 넣기 -->---------------------------------------

	var regular_han = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|a-z|A-Z]/;
	
	function proInfoSend() {
		
		
		/* 세션으로부터 받은 member_idx 값 */
		var member_id = $("#member_id").val().trim();
		
		var p_name = $("#p_name").val().trim();
		var c_idx = $("#c_idx").val();
		
		var p_delivery_type = $("#p_delivery_type").val();
		
		var p_delivery_type2 = $("#p_delivery_type2").val();
		var p_delivery_type3 = $("#p_delivery_type3").val();
		var p_delivery_type4 = $("#p_delivery_type4").val();

		var p_paymentType = $("#p_paymentType").val();
		var p_paymentType2 = $("#p_paymentType2").val();
		
// 		var p_location = $("#p_location").val().trim();
// 		var p_location_detail = $("#p_location_detail").val().trim();
		
		var p_price = $("#p_price").val().trim();
		var p_exp = $("#p_exp").val().trim();
		var sumimage = $("#sumimage").val();
		
		if(sumimage==''){
			alert('대표 이미지를 반드시 등록해주세요.');
			$("#imgup").focus();
			return;
		}
		
		if(p_name==''){
			alert('제목이 비어있습니다. (필수입력, 공백불가)');
			$("#p_name").val('');
			$("#p_name").focus();
			return;
		}
		
		if(c_idx==0){
			alert('카테고리를 선택하세요. ');
			$("#c_idx").focus();
			return;
		}
		
		
		if(p_paymentType=='' && p_paymentType2==''){ // 모두 null일경우
			alert('결제 방법을 한 가지 이상 선택해주세요');
			$("#p_paymentType").val('');
			$("#p_paymentType").focus();
			return;			
		}
		
		if(p_delivery_type=='' && p_delivery_type2=='' && p_delivery_type3=='' && p_delivery_type4=='' ){
			alert('거래 방법을 한 가지 이상 선택해 주세요');
			$("#p_delivery_type").val('');
			$("#p_delivery_type").focus();
			return;			
		}
		
// 		if(p_location==''){
// 			alert('거래지역을 입력해 주세요.');
// 			$("#p_location").val('');
// 			$("#p_location").focus();
// 			return;			
// 		}
		
// 		if(p_location_detail==''){
// 			alert('상세주소를 입력해 주세요.');
// 			$("#p_location_detail").val('');
// 			$("#p_location_detail").focus();
// 			return;			
// 		}
		
		if(p_price==''){
			
			alert('가격이 비어있습니다.');
			$("#p_price").val('');
			$("#p_price").focus();
			return;
		}
		
		
		if(p_exp==''){
			
			alert('상품 설명이 비어있습니다. ');
			$("#p_exp").val('');
			$("#p_exp").focus();
			return;
		}

		
		if( regular_han.test(p_price) ){
			alert('숫자만 입력 가능합니다.');
			$("#p_price").val('');
			$("#p_price").focus();
			return;
		} 

		/* 가격 콤마 제거 */
		p_price = p_price.replace(/,/g, "");
		
		if(p_price<100){
			alert('가격은 100원 이상 입력해주세요.');
			$("#p_price").val('');
			$("#p_price").focus();
			return;
		}
		
		
		if(confirm('등록 하시겠습니까?')==false) return;

		
		
		// -----------------------------------------
// 		// 체크박스 감지 이벤트
// 		$(function() {

// 			// 전체선택 체크박스 상태 변화 감지 이벤트
// 			$(".allCheck").on("change", function() {
// 				// 전체선택 체크 시 모든 체크박스 체크, 체크 해제 시 모두 해제
// 			 			if($(".allCheck").prop("checked")) { // 체크 시
// 			 				alert("체크!");
// 			 			} else { // 체크해제 시
// 			 				alert("체크해제!");
// 			 			}
				
// 				if($(".allCheck").is(":checked")) { // 체크 시
// 					// 체크박스들의 checked 속성값을 체크 상태(true)로 변경 - prop() 활용
// 					// => input[type=checkbox] 대신 가상선택자 :checkbox 사용 가능
// 					// => prop() 메서드 파라미터로 속성명, 속성값 전달 시 속성 변경 가능
// 					$(":checkbox").prop("checked", true); // 체크 상태를 체크(true)로 변경

// 					// each() 메서드를 통해 체크박스 반복으로 각 요소의 상태 변경도 가능함
// 					$(":checkbox").each(function(index, item) {
// 						$(item).prop("checked", true);
// 							$(this).prop("checked", true);
// 		 			});
// 				} else { // 체크해제 시
// 					$(":checkbox").prop("checked", false); // 체크 상태를 체크해제(false)로 변경
// 				}
// 			});
// 		});
		// -----------------------------------------
		
		
		
		var form = $("#imgform")[0];
		var formData = new FormData(form);
		
		//이미지
		//필수이미지 = sumimage

		
		
		
		formData.append('file1',$('#sumimage')[0].files[0]);
		if($('#imageFile1')[0].files[0]!=undefined){
			formData.append('file2',$('#imageFile1')[0].files[0]);	
		}
		if($('#imageFile2')[0].files[0]!=undefined){
			formData.append('file3',$('#imageFile2')[0].files[0]);
		}
		
		formData.append('member_id', member_id);				// 유저idx
		formData.append('secondhand_subject',p_name);			// 상품명
		formData.append('category_idx',c_idx);				// 카테고리번호
// 		formData.append('p_location',p_location);	// 지역
// 		formData.append('auction_seller_address_detail',p_location_detail);	// 지역상세

		if($("#p_delivery_type").is(":checked")){
			formData.append('secondhand_deliveryType_ptp',p_delivery_type);	// 거래방법-직거래
		}
		if($("#p_delivery_type2").is(":checked")){
			formData.append('secondhand_deliveryType_parcel',p_delivery_type2);	// 거래방법-택배
		}
		if($("#p_delivery_type3").is(":checked")){
			formData.append('secondhand_deliveryType_zstation',p_delivery_type3);	// 거래방법-zstation
		}
		if($("#p_delivery_type4").is(":checked")){
			formData.append('secondhand_deliveryType_zman',p_delivery_type4);	// 거래방법-zman
		}
		
		
		
		if($("#p_paymentType").is(":checked")){
			formData.append('secondhand_paymentType_ptp',p_paymentType);	// 결제타입
		}
		if($("#p_paymentType2").is(":checked")){
			formData.append('secondhand_paymentType_zpay',p_paymentType2);	// 결제타입-zpay
		}
		
		formData.append('secondhand_price',p_price);			// 가격
		formData.append('secondhand_content',p_exp);				// 상품설명
		
		
		
		
		
		
		/*	
			파일 데이터를 ajax처리 하기 위해선
			반드시 processData,contentType 들을 false 해주기
		 */
		
	 	$.ajax({
			
			url 	 : 'secondhandRegistPro',
			type	 : 'POST',
			data	 : formData,
			processData : false,
			contentType : false,
			dataType : 'json',
			success  : function(res){
				
				if(res == true){
					alert('상품이 정상적으로 등록되었습니다!');
// 					location.href='../mainpage/list.do';
					location.href='${pageContext.request.contextPath }/secondhand_list';
				}
				
			},error	: function(err){
				alert('물품등록에 실패했습니다. 관리자에게 문의하세요.');
			}
			
		});
		
		
	}
	

	/* 상품등록 취소  */	
	function procancel(){
		
		if(confirm('상품등록을 취소하시겠습니까?')==false) return;
		
		history.back();

		
	}
	
//----------------------------------------------------------


//<!-- 가격 함수 (실시간 콤마, 한글입력불가) -->------------
	$(function() {

		$("#p_price").on("propertychange change keyup paste input", function() {
			
			
			var p_price = $(this).val() ;
			
			if(p_price<100 ){
				$("#price_under").show();
				$("#price_under").text('100원 이상만 입력하세요.').css('color','red');
		 		$("#p_price").css('outline','1px solid red');
				$("#p_price").css('border-color','red');
				
			}
			
			if(p_price>=100 || p_price=='' ){
				$("#price_under").hide();
				$("#p_price").css('border-color','black');
				$("#p_price").css('outline','black');
			}
			
			/* 숫자 comma 찍는 함수 */
			p_price = comma(uncomma(p_price));
			
			
			/* console.log(p_price); */
			
			$("#p_price").val(p_price);

		});

	})
	
	
	/* 실제 입력값을 변경해주는 함수 */
	function comma(str) {
	    str = String(str);
	    
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	function uncomma(str) {
	    str = String(str);
	    
	    if(regular_han.test(str)){
	    	alert('숫자만 입력하세요');
	    }
	    
	    return str.replace(/[^\d]+/g, '');
	}
//----------------------------------------------------------


//<!-- 실시간 글자수 체크 코드 -->--------------------------	
	
	
	function numberMaxLength(e) {
		if (e.value.length > e.maxLength) {
			e.value = e.value.slice(0, e.maxLength);
		}
	}

	$(function() {

		$("#p_name").on("propertychange change keyup paste input", function() {

			var p_name = $(this).val().length;

			/* console.log(p_name); */

			$("#name_length").html(p_name + '/40')

		});

	})

	$(function() {

		$("#p_exp").on("propertychange change keyup paste input", function() {

			var p_exp = $(this).val().length;

			$("#exp_length").html(p_exp + '/1000')

		});

	})
//----------------------------------------------------------	



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
	#insert_box {
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

		<div id="insert_box">
			<span id="title">상품등록</span>

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
				<tr>
					<td class="td1" align="left" ><span
						class="pro_info">상품이미지</span> 
						<span class="pro_info" id="img_number">(0/3)</span>
						<span style="color: red">*</span>
						<input type="image" id="imgup" onclick="img_preview();"
								src="${ pageContext.request.contextPath }/resources/img/image_upload.png" width="150px" height="150px">
						</td>
					<td class="td2" align="left">
					
						<!-- 이미지 등록 영역 -->
						<div id="img_zone">
							<div id="img_preview0" >
								<input type="image" id="imgup_sum" onclick="send_0();"
									src="" width="150px" height="150px">
								<span id="sum_style" >대표 이미지</span>
								<!-- 삭제버튼 -->
								<span id="del_sum" class="chk_style"  onclick="del_sum();">x</span>
							</div>
							
								
							<div id="img_preview1" >
								<input type="image" id="imgup_1" onclick="send_1();"
									src="" width="150px" height="150px">
								<!-- 삭제버튼 -->
								<span id="del_img1" class="chk_style" onclick="del_img1();">x</span>
							</div>
							
							<div id="img_preview2">
								<input type="image" id="imgup_2" onclick="send_2();"
									src="" width="150px" height="150px">
								<span id="del_img2" class="chk_style" onclick="del_img2();">x</span>
							</div>

						</div>
						<div id="img_intro">
								
								* <b>대표 이미지</b>는 반드시 <font color="red"><b>등록</b></font>해야 합니다.<br>
								- 이미지를 <b>클릭할</b> 경우 이미지를 <b>수정</b>하실 수 있습니다.<br>
								- 이미지 등록은 좌측 <b>이미지 등록</b>을 눌러 등록할 수 있습니다.<br>
								- 이미지 확장자는 <b>.jpg, .jpeg, .png</b> 만 등록 가능합니다.
						</div>

					</td>
				</tr><!-- 이미지영역끝 -->
				
				
				

				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
				<!-- 제목  -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span
						class="pro_info">제목<span style="color: red">*</span></span></td>
					<td class="td2" align="left">
						<div style="display: inline-block; min-width: 70px; ">
							<span class="pro_info" id="name_length">0/40</span>
						</div>
						<input maxlength="40"
						oninput="numberMaxLength(this);" type="text" id="p_name"
						name="p_name" class="input-tag" placeholder="제목을 입력하세요.">
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
<!-- 								<option value="1">패션의류/신발/잡화/뷰티/미용</option> -->
<!-- 								<option value="2">유아동/유아장난감/유아의류/유아용품</option> -->
<!-- 								<option value="3">가구/인테리어/생활용품</option> -->
<!-- 								<option value="4">도서/문구/게임/취미/쿠폰</option> -->
<!-- 								<option value="5">반려동물/반려동물용품</option> -->
<!-- 								<option value="6">모바일/태블릿/전자악세사리/가전제품</option> -->
						</select>
					</td>
				</tr>

				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
<!-- 				거래지역 -->
<!-- 				<tr> -->
<!-- 					<td class="td1" align="left" style="vertical-align: top;"><span -->
<!-- 						class="pro_info"> 희망 거래지역 </span></td> -->
					
<!-- 					<td align="left"> -->
<!-- 						<input type="button" id="addrfind" value="주소찾기" onclick="addrFind();"> -->
<!-- 						<br> -->
<!-- 						<input type="text" id="p_location" class="input-tag" style="margin-top: 5px;" readonly="readonly"> -->
<!-- 						<input type="text" id="p_location_detail" class="input-tag"  placeholder="상세주소입력" style="margin-top: 5px;" > -->
<!-- 					</td> -->


<!-- 				</tr> -->

<!-- 				<tr> -->
<!-- 					<td colspan="2"><hr></td> -->
<!-- 				</tr> -->
				
<!-- 				상품상태 -->
<!-- 				<tr> -->
<!-- 					<td class="td1" align="left" style="vertical-align: top;"><span -->
<!-- 						class="pro_info">상품상태<span style="color: red">*</span></span></td> -->
<!-- 					<td class="td2" align="left"> -->
<!-- 						<input type="radio" name="p_condition" id="p_condition" value="중고상품" checked="checked"> -->
<!-- 						<span class="pro_info">중고상품</span>  -->
<!-- 						<input type="radio" name="p_condition" id="p_condition" value="새상품">  -->
<!-- 						<span class="pro_info">새상품</span> -->
<!-- 					</td> -->
<!-- 				</tr> -->


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
					<td class="td1" align="left" style="vertical-align: top;"><span
						class="pro_info">가격<span style="color: red">*</span></span></td>
					<td class="td2" align="left"><input type="text" id="p_price" maxlength="11"
						name="p_price" class="input-tag" placeholder="가격"
						oninput="numberMaxLength(this);" style="width: 30%;"> &nbsp; <span class="pro_info">원</span>
						<br>
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
							placeholder="구입연도, 브랜드, 사용감, 하자유무 등 필요한 정보를 넣어주세요. &#13;&#10;구매자의 문의를 좀더 줄일 수 있습니다."></textarea>
						</div>
						<div align="right"><span style="font-size: 18px;"id="exp_length">0/1000</span></div>
					</td>
				</tr>

				<tr>
					<td colspan="2"><hr></td>
				</tr>
				
				<!-- 등록 취소버튼 -->
				<tr>
					<td colspan="2">
						<input class="btn btn-success" type="button" value="등록하기" onclick="proInfoSend();"> 
						<input class="btn btn" type="button" value="취소하기" onclick="procancel()"></td>
				</tr>
			</table>

		</div>
	<div style="min-height: 200px;"></div>
	</div>
</body>
</html>