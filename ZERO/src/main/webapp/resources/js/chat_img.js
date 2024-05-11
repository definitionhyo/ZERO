/*!
  * Bootstrap v4.4.1 (https://getbootstrap.com/)
  * Copyright 2011-2019 The Bootstrap Authors (https://github.com/twbs/bootstrap/graphs/contributors)
  * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
  */
  
  // ----- 사진 보내기 관련 스크립트 --------------------
//	var preview_array  = [false, false, false];
	var preview_array  = [false];
	
	// 이미지 등록시 미리보기 추가 작업
	function img_preview() {
		
		for(var i = 0; i < preview_array.length; i++){
			/* i가 0일때 */
			if(i==0){
				/* 0번사진 비어있으면 */
				if(preview_array[0] == false){
					/* 섬네일사진 */
					/* 0번사진 인풋태그 호출 */
					send_0();
					return;
				}
			}
			
			/* i가1일때 */
			if(i==1){
				/* 1번사진이 비어있으면 */
				if(preview_array[1] == false){
					/* 1번사진 인풋태그 호출 */
					send_1();
					return;
				}
			}
			
			/* i가 2일때 */
			if(i==2){
				/* 2번사진 비어있으면 */
				if(preview_array[2] == false){
					/* 2번사진 인풋태그 호출 */
					send_2();
					return;
				}
			}
			
		}/*  for end */
		
		alert("더이상 등록할 수 없습니다.");
		return;
		
	}/* 프리뷰 end */
	
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
		       // 스크롤 위치 조정
				// 요소 가져오기
				let scrollContainer = document.querySelector('#msgArea');
				// 요소 영역의 높이와 스크롤 높이 가져오기
				let scrollHeight = scrollContainer.scrollHeight;
				let containerHeight = scrollContainer.clientHeight;
				// 스크롤 위치 조정
				scrollContainer.scrollTop = scrollHeight - containerHeight;
				
				preview_array[0] = true;
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
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
//-----------------------------------------------------------

//<!-- 이미지미리보기삭제 -->--------------------------------

	function del_sum(num) {
		switch(num) {
			case 1: {
				/* 실제 DB에 들어가는 input value 지움 */
				$('#sumimage').val('');
				
		      	$("#img_preview0").css("display","none");
				$('#imgup_sum').hide();
				$("#del_sum").hide(); 
				
				/* 썸네일 비움 */
				preview_array[0] = false;
		//		console.log(preview_array[0] + "," + preview_array[1] + "," + preview_array[2]);
				
				break;
			}
			case 2: {
				$('#imageFile1').val('');
				
				$("#img_preview1").css("display","none");
				$('#imgup_1').hide();
				$("#del_img1").hide();
				
				/* 1번사진 비움 */
				preview_array[1] = false;
				break;
			}
			case 3: {
			$('#imageFile2').val('');
			
			$("#img_preview2").css("display","none");
			$('#imgup_2').hide();
			$("#del_img2").hide();
			
			/* 2번사진 비움 */
			preview_array[2] = false;
			}	
		}
		// 등록된 이미지가 없을 때
//		if(!(preview_array[0] || preview_array[1] || preview_array[2]) ) {
//			$("#img_zone").hide();
//		}
		
	}

//-----------------------------------------------------------

// 이미지를 업로드 처리한 후에 해당 이미지 URL을 클라이언트에게 전송
// => 웹소켓 메시지에서 이미지 URL을 문자열 형태로 담아서 클라이언트에게 전송
//let imageURL = '';
//sendMessage(sender);


  