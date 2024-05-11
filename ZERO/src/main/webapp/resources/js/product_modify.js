


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
	
	function proInfoModify() {
		
		/* 세션으로부터 받은 member_idx 값 */
		var member_id = $("#member_id").val().trim();
		
		var p_name = $("#p_name").val().trim();
		var c_idx = $("#c_idx").val();
		
		var p_delivery_type = $("input:checkbox[id=p_delivery_type]:checked").val();
		
		var p_delivery_type2 = $("input:checkbox[id=p_delivery_type2]:checked").val();
		var p_delivery_type3 = $("input:checkbox[id=p_delivery_type3]:checked").val();
		var p_delivery_type4 = $("input:checkbox[id=p_delivery_type4]:checked").val();

		var p_paymentType = $("input:checkbox[id=p_paymentType]:checked").val();
		var p_paymentType2 = $("input:checkbox[id=p_paymentType2]:checked").val();
		
		var p_location = $("#p_location").val().trim();
//		var p_location_detail = $("#p_location_detail").val().trim();
		
		var p_price = $("#p_price").val().trim();
		var p_exp = $("#p_exp").val().trim();
//		var sumimage = $("#sumimage").val();
		
		// 보안상이유로 file의 value값 미리 정할 수 없다고 함
		// => 배열로 이미지 해결
		
		if(preview_array[0]==false){
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
			$("input:radio[name=c_idx]").focus();
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
		
//		if(p_location==''){
//			alert('거래지역을 입력해 주세요.');
//			$("#p_location").val('');
//			$("#p_location").focus();
//			return;			
//		}
//		
//		if(p_location_detail==''){
//			alert('상세주소를 입력해 주세요.');
//			$("#p_location_detail").val('');
//			$("#p_location_detail").focus();
//			return;			
//		}
		
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
		// 체크박스 감지 이벤트
		$(function() {

			// 전체선택 체크박스 상태 변화 감지 이벤트
			$(".allCheck").on("change", function() {
				// 전체선택 체크 시 모든 체크박스 체크, 체크 해제 시 모두 해제
			 			if($(".allCheck").prop("checked")) { // 체크 시
			 				alert("체크!");
			 			} else { // 체크해제 시
			 				alert("체크해제!");
			 			}
				
				if($(".allCheck").is(":checked")) { // 체크 시
					// 체크박스들의 checked 속성값을 체크 상태(true)로 변경 - prop() 활용
					// => input[type=checkbox] 대신 가상선택자 :checkbox 사용 가능
					// => prop() 메서드 파라미터로 속성명, 속성값 전달 시 속성 변경 가능
					$(":checkbox").prop("checked", true); // 체크 상태를 체크(true)로 변경

					// each() 메서드를 통해 체크박스 반복으로 각 요소의 상태 변경도 가능함
					$(":checkbox").each(function(index, item) {
						$(item).prop("checked", true);
							$(this).prop("checked", true);
		 			});
				} else { // 체크해제 시
					$(":checkbox").prop("checked", false); // 체크 상태를 체크해제(false)로 변경
				}
			});
		});
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
		
		//수정에서 추가됨
		formData.append('secondhand_idx',p_idx);				// 수정하려는 상품 idx
		formData.append('change_image',change_image)  // 이미지 수정정보
		
		
		/*	
			파일 데이터를 ajax처리 하기 위해선
			반드시 processData,contentType 들을 false 해주기
		 */
		
	 	$.ajax({
			
			url 	 : 'secondhandModifyPro',
			type	 : 'POST',
			data	 : formData,
			processData : false,
			contentType : false,
			dataType : 'json',
			success  : function(res){
				
				if(res	== true){
					alert('상품수정 성공!');
// 					location.href='../mainpage/list.do';
// 					location.href='../secondhand/secondhand_regist_form';
				}
				
			},error	: function(err){
				alert('수정에 실패했습니다. 관리자에게 문의하세요.');
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



