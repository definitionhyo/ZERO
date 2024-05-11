<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- -->
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/defualt.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<%-- 반응형웹페이지위한 설정 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>ZERO</title>

<!-- 제이쿼리 -->
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<script type="text/javascript">

	//전역변수 pageNum, maxPage 미리저장
	let pageNum = 1;	// 임의로 설정
	let maxPage = 1;	// 최대 페이지 번호 미리 저장

	
	
	
	//상품번호넘기기 -- 반복문()
// 	$(function(){
// 		let secondhand_idx = $("#secondhand_idx").val();
// 		alert('$("#secondhand_idx").val()');
		
// 		let url = "secondhandList_Json?secondhand_idx=" + secondhand_idx
			
// 		$.ajax({
// 			type : "get",
// 			dataType : "json",
// 			url : url,
// 			success : function(data){
// 				alert('상품번호넘김성공');
// 			},
// 			error:function(){
// 				alert('상품번호넘김실패');
// 			}
			
// 		});//ajax끝
		
// 	});//window.onload함수끝
	
	
		
		
		
		
		
		
		let searchType = $("#searchType").val();
		let searchKeyword= $("#searchKeyword").val();
// 		loadList(searchType, searchKeyword);
		
		// 무한스크롤 추가
		// 스크롤바가 바닥에 닿으면->다음목록조회(loadList())
		$(window).on("scroll", function(){ // 스크롤 동작시 이벤트처리
			console.log("scroll");
			//1.
			let scrollTop = $(window).scrollTop(); // 스크롤바의 현재위치
			let windowHeight = $(window).height(); // 브라우저 창의 높이
			let documentHeight = $(document).height(); // 문서의 높이(창의 높이보다 크거나 같음)
			console.log("scrollTop=" + scrollTop + "windowHeight=" + windowHeight + "documentHeight=" + documentHeight);
			
			//2.x+스크롤바위치값+창높이>문서전체 높이 일경우 ⇒ 다음페이지 게시물목록 로딩 → 하단에 추가			
			let x = 1;
			if(scrollTop + windowHeight + x >= documentHeight){
				// 다음페이지 글 목록 로딩 loadList()호출
				// 스크롤바가 바닥에 닿을때마다 pageNum+1 => 다음페이지목록 지정
				
				//최대페이지 번호 초과시 다음페이지로딩 요청않도록
				if(pageNum < maxPage){
					pageNum++;
					loadList(searchType, searchKeyword);
				} else {
					alert("다음페이지 X");
				}
			}
		});//무한스크롤 이벤트처리 끝
	});
	
	
	
	
	
	
	
	
	
	
	function category(categoryId) {
		//기존값에 카테고리 추가
		var category = $("#item_category").val();
		var str = '';
		
		switch(categoryId) {
			case "fashion": str += "패션/의류/잡화/뷰티"; break;
			case "pc": str += "가전제품/모바일/PC"; break;
			case "interior": str += "가구/인테리어"; break;
			case "book": str += "도서/음반/문구/티켓"; break;
			case "game": str += "게임/스포츠/취미"; break;
			case "child": str += "유아동/반려동물"; break;
			case "etc": str += "기타"; break;
			case "all": 
		}
		
		// 중복 카테고리 처리
		if(str != "" && category.includes(str)) return;
		
		
		// 카테고리 필터에 추가
		if(str != "") {
			var title = str;
			var tagStr = '';
			tagStr += '<div class="tagListTag">';
			tagStr += '<div class="tagListName" data-cd="1">';
			tagStr += title;
			tagStr += '</div>';
			tagStr += '<img src="https://ccimage.hellomarket.com/img/web/search/filter/mweb/ico_close_tag.png" alt="remove" class="tagListRemove"></div>';
			$(".tagListFilterBox").append(tagStr);
		}
		
		// all이면 null 넘김
		if(categoryId == "all") {
			$("#item_category").val("");
			$(".tagListName[data-cd='1']").parent().remove();
		} else {
			if(category != ""){
				category += "/";
			}
			category += str;
			$("#item_category").val(category);
		}
		marketItemList();
	}
	
	

	
	
	// 조회 결과 없을 때 div 생성
	function makeEmptyDiv() {
		var str = '<div class="EmptyEmptyBox">';
		str += '<div class="EmptyTitle">아쉽게도, 현재 검색된 상품이 없어요</div>';
		str += '<div class="EmptyGuide">필터를 재설정하거나 전체 상품 보기를 선택해주세요</div>';
		str += '<div class="EmptyBtnBox" onclick="location.reload();">';
		str += '<img src="https://ccimage.hellomarket.com/img/web/common/refresh_mark.svg" alt="초기화 마크" class="EmptyResetMark-xvqyzf-4 YrGaN">';
		str += '<div class="EmptyShowAllText">전체 상품 보기</div></div></div>';
		$(".itemWrapper").append(str);
	}
	
	
	
	
	
	// ajax에서 받은 데이터로 div 생성
	function makeDiv(response) {
		for(let item of response) {
			let category = item.item_category;
			let subject = item.item_subject;
			let price = item.item_price;
			let tags = item.item_tag;
			let tag = tags.split(',');
			let date = item.item_date;
			let code = item.item_code;
			let image = item.image_name;
			let count = item.total_count;
			let status = item.item_status;
			var wish = item.wish_code;
			
			price = priceReplace(price);
			

			
			
			var itemDate = date;
			var formattedDate = moment(itemDate).format("YYYY-MM-DD HH:mm");
			
			

			
// 			if(image == null) {
// 				image = "/Moneytto/resources/images/main/noThumbnail.jpg";
// 			}
			
// 			if(wish == null) {
// 				wish = '<img src="/Moneytto/resources/images/main/ico_heart_off_x3.png" alt="좋아요 아이콘" class="WishWishImg wish" onclick="wish.call(this)"/>'
// 			}else{
// 				wish = '<img src="/Moneytto/resources/images/main/ico_heart_on_x3.png" alt="좋아요 아이콘" class="WishWishImg" onclick="wish.call(this)" />'
// 			}

			var str = '<div class="itemThumbnailBox item" data-cd="';
			str += code;
			str +=	'">';
			str += '<div class="itemThumbnailBox">';
			str += '<img src="' + image + '" alt="썸네일" class="itemThumbnail" style="cursor: pointer">';
			str += '<input type="button" value="';
			str += status;
			str += '" class="status active">';
			str += wish;
			str += '</div>';
			str += '<div class="itemTextBox">';
			str += '<div class="itemCategory">';
			str += category;
			str += '</div>';
			str += '<div class="itemText subject">';
			str += subject;
			str += '</div>';
			str += '<div class="itemText">';
			str += price + '원';
			str += '</div>';
			
			
			if(tag != "") {
				str += '<div class="itemTagBox">';
				
				for(var i = 0; i < tag.length; i++) {
					str += '<div class="itemSizeTag">';
					str += tag[i];
					str += '</div>';
				}
				str += '</div>';
			}
			
			str += '<div class="itemTimeTag">';
			str += formattedDate;
			str += '</div></div>';
			
			$(".itemWrapper").append(str);
			$(".Count").empty().append(count);
			
		}
		
			var more = '<div class="chall_more">MORE</div>';
			$(".itemListWrapper").after(more);
			
			$(".itemThumbnailBox").hide();
			$(".itemThumbnailBox").slice(0, 20).show();
			
			if($(".itemThumbnailBox:hidden").length == 0) {
				$(".chall_more").fadeOut(100);
			}
	}
	
	
	// 중복 구분자 제거
	function removeChar(str, character){
		var doubleChar = character + character;
		
		if(str[0] == character){
			str = str.substring(1);
		}

		if(str[str.length - 1] == character){
			str = str.slice(0, -1);
		}

		if(str.includes(doubleChar)) {
			str = str.replace(doubleChar, character);
		}

		return str;
	}
	
	
	// 상품 리스트 불러오기
	function marketItemList() {
		$(".itemThumbnailBox").remove();
		$(".chall_more").remove();
		$(".EmptyEmptyBox").remove();

		var item_category = $("#item_category").val();
		var item_tag = $("#tag").val();
		var item_status = $("#item_status").val();
		var item_price_min = $("#item_price_min").val();
		var item_price_max = $("#item_price_max").val();
		var member_grade = $("#member_grade").val();
		var sort = $("#sort").val();
		
		
		// 중복 구분자 제거
		item_category = removeChar(item_category, "/");
		item_tag = removeChar(item_tag, "|");
		$("#item_category").val(item_category);
		$("#tag").val(item_tag);
		
//			console.log("------ marketItemList 요청 시 들어가는 값 ------")
//			console.log("item_category : " + item_category);
//			console.log("item_tag : " + item_tag);
//			console.log("item_status : " + item_status);
//			console.log("item_price_min : " + item_price_min);
//			console.log("item_price_max : " + item_price_max);
//			console.log("member_grade : " + member_grade);
//			console.log("sort : " + sort);
		
		
		
		
		$.ajax({													
 			type: "GET",
 			url: "marketItemList", 
 			data: { 
 				item_category	: item_category,
//  				item_tag		: item_tag, 
 				item_status 	: item_status,
 				item_price_min 	: item_price_min,
 				item_price_max 	: item_price_max,
//  				member_grade 	: member_grade,
 				sort 			: sort
 			},
 			dataType: "json",
 			success: function(response) { 
 				console.log("marketItemList : 요청처리성공");
 				
 				 if (response.length == 0) {
 		           let count = 0;
 		           $(".Count").empty().append(count);
 		           makeEmptyDiv();
 		           return;
 				 } 
 				 // div 생성
 				 makeDiv(response);
 			},
 			error: function(xhr, textStatus, errorThrown) {
 				console.log("marketItemList : 요청처리실패");
 			}
 		});
	}
	
	
	
	
	$(function () {
		marketItemList();
		
		// 상단 이동 버튼
		// 보이기 | 숨기기
		$(window).scroll(function() {
			if ($(this).scrollTop() > 250) {
				$('#toTop').fadeIn();
			} else {
				$('#toTop').fadeOut();
			}
	    });
	    // 버튼 클릭시
	    $("#toTop").click(function() {   
	    $('html, body').animate({scrollTop : 0}, 400);          // 속도 400
	    	return false;
	    });
		
		
		// 더보기
		$(document).on("click", ".chall_more", function(e) {
			e.preventDefault();
			$(".itemThumbnailBox:hidden").slice(0, 20).show();
			if($(".itemThumbnailBox:hidden").length == 0) {
				$(".chall_more").fadeOut(100);
			}
		});

		
		
		// 카테고리 클릭
		$(".FilterCategory").on("click", function(e) {
			toggleFilter(".categoryDetail", ".priceDetail");
		});
		
		// 가격 클릭
		$(".FilterPrice").on("click", function(e) {
			toggleFilter(".priceDetail", ".categoryDetail");
		});
		
		
		// 카테고리 선택
		$(document).on("click", ".ListNonSelected", function(e) {
			$(".ListSelected").attr("class", "ListNonSelected");
			$(this).attr("class", "ListSelected");
			
			var categoryId = $(this).attr("id");
			category(categoryId);
			
			
		});


		// 필터 remove
		$(document).on("click", ".tagListRemove", function(e) {
			let text = this.parentElement.textContent;
			var category = $("#item_category").val();
			var item_tag = $("#tag").val();
			var item_price_min = $("#item_price_min").val();
			var item_price_max = $("#item_price_max").val();
			
			/*
				1: 카테고리
				2: 가격
				3: 태그
			*/
			var data = $(this).parent().find(".tagListName").data("cd");
			
			switch(data) {
				case 1: 
					// 카테고리 처리
					$("#item_category").val(category.replace(text, ""))
					break;
				case 2: 
					// 가격 처리
					$("#item_price_min").val(0);
					$("#item_price_max").val(999999999999999);
					break;
				case 3: 
					// 태그 처리
					$("#tag").val(item_tag.replace(text, ""))
			}
			
			marketItemList();
			
			
			$(this).parent().remove();
		});
		
		
		// 필터 초기화
		$(document).on("click", ".tagListReset", function(e) {
			location.reload();	
		});
		
		
		
		// 가격 설정
		$(document).on("click", ".priceApplyBtn", function(e) { //적용하기버튼누를경우
			var item_price_min = uncomma($(".item_price_min").val());
			var item_price_max = uncomma($(".item_price_max").val());
			
			if(item_price_min == "" && item_price_max == "") return;
			
			if(item_price_min == "") {
				$("#item_price_min").val(0);
			} else {
				$("#item_price_min").val(item_price_min);
			}
			
			if(item_price_max == "") {
				$("#item_price_max").val(999999999999999);
			} else {
				$("#item_price_max").val(item_price_max);
			}
			
			// 가격 필터에 추가
			if($(".tagListFilterBox").find(".tagPrice").length > 0) {
				$(".tagPrice").remove();
			}
			var tagStr = '';
			tagStr += '<div class="tagPrice">';
			tagStr += '<div class="tagListTag">';
			tagStr += '<div class="tagListName" data-cd="2">';
			
			if(item_price_min != "") {
				tagStr += item_price_min;
				tagStr = priceReplace(tagStr);
				tagStr += '원';
			}
			
			tagStr += '~';
			
			if(item_price_max != "") {
				tagStr += item_price_max;
				tagStr = priceReplace(tagStr);
				tagStr += '원';
			}
			
			tagStr += '</div>';
			tagStr += '<img src="https://ccimage.hellomarket.com/img/web/search/filter/mweb/ico_close_tag.png" alt="remove" class="tagListRemove"></div></div>';
			
			
			$(".tagListFilterBox").append(tagStr);
			
			marketItemList();
		});
		
		
		// 거래완료 체크
		$(document).on("click", "#complete", function(e) {
			var completeChecked = $("#complete").prop("checked")
			if(completeChecked) {
				$("#item_status").val("1");
			} else {
				$("#item_status").val("");
			}
			marketItemList();
		});
		
		
		// 등급 체크
		$(document).on("click", "#grade", function(e) {
			var gradeChecked = $("#grade").prop("checked")
			if(gradeChecked) {
				$("#member_grade").val("1");
			} else {
				$("#member_grade").val("");
			}
			marketItemList();
		});
		
		
		// 정렬 박스 열기
		$(document).on("click", ".sortSortBox", function(e) {
			$('.SortListWrapper').toggle();
		});
		
		
		// 정렬 선택
		$(document).on("click", ".SortListList", function(e) {
			$(".sortSortBox").remove();
			var title = $(this).attr("title");
			
			// 정렬 글자 변경
			var str = '';
			str += '<div class="sortSortBox">';
			str += '<div class="sortSort">';
			str += title;
			str += '</div>';
			str += '<img src="https://ccimage.hellomarket.com/img/web/search/itemList/ico_sort.png" alt="정렬 아이콘" class="sortSortImg"/></div>';
			
			$(".SortListWrapper").after(str);
			$('.SortListWrapper').toggle();
			
			var sort = $(this).attr("id");
			$("#sort").val(sort);
			marketItemList();
		});
		
		

		
		// 제목 클릭, 이미지 클릭
		$(document).on("click", ".itemThumbnail, .subject", marketDetail);
		
		
		

		
		$(".searchSearch input").keydown(function(event) {
            if(event.which === 13) {
				event.preventDefault(); // 엔터 키 기본 동작 막기
				$("#searchForm").submit(); // 폼 제출
            }
        });
		
		
		// tag list 초기화
		var availableTag = [];
		
		// tagList
		function tagList() {
			$.ajax({													
	 			type: "GET",
	 			url: "tagList", 
	 			dataType: "json",
	 			success: function(response) { 
	 				console.log("tagList : 요청처리성공");
	 				for(let item of response) {
						let tags2 = item.item_tag;
	 					let tag2 = tags2.split(',');
	 					
	 					for (let tag of tag2) {
							if (!availableTag.includes(tag)) {
								availableTag.push(tag);
							}
						}
	 				}
	 				// 자동완성
	 			    implementAutocomplete();
	 			},
	 			error: function(xhr, textStatus, errorThrown) {
	 				console.log("tagList : 요청처리실패");
	 			}
	 		});
		}

		tagList();
	});

	
// 	function loadList(searchType,searchKeyword){
// 		let url;
// 		// searchKeyword 없을경우, pageNum전달 -> BoardListJson 서블릿 요청
// 		// or pageNum, searchType, searchKeyword 전달
		
// 		// -> 검색타입/검색키워드 존재유무 컨트롤러에서 판별
// 		url="BoardListJson?pageNum=" + pageNum + "&searchType=" + searchType +"&searchKeyword=" + searchKeyword;

// 		$.ajax({
// 			type:"get",
// 			dataType:"json",
// 			url:url,
// 			success:function(data){
				
// 				// 글목록, 최대 페이지 번호를 함께 받은경우
// 				//1. 최대페이지번호 꺼내기
// 				maxPage = data.maxPage; 
// 				console.log("maxPage=" + maxPage)
				
// 				//json 데이터 반복문사용하여 차례접근 후 데이터 출력
// 					for(secondhand of data){
// 						// 테이블에 표시할 JSON 객체 1개 출력문 생성(= 1개 게시물) => 반복
// 						let item = "<tr height='50'>"
// 									+ "<td>" + board.board_num + "</td>" 
// 									+ "<td id='subject'>"
// 										+ space
// 										+ "<a href='BoardDetail?board_num=" + board.board_num + "'>"
// 										+ board.board_subject 
// 										+ "</a>"
// 									+ "</td>" 
// 									+ "<td>" + board.board_name + "</td>" 
// //	 								+ "<td>" + board.board_date + "</td>" 
// 									+ "<td>" + getFormatDate(board.board_date) + "</td>" 
// 									+ "<td>" + board.board_readcount + "</td>" 
// 									+ "</tr>"
// 						$("table").append(item);	
					
					
					
// 					}
					
				
				
// 			},
		
// 	}//loadList함수 끝	
	
	
	



	//카테고리, 가격대 선택 탭
	$(document).ready(function(){
		$('ul.tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');
			
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
		
			$(this).addClass('current');
			$("#"+tab_id).addClass('current');
			})
		})
	});
	





</script>
<style>
#mainArticle {
	margin-top: 150px;
}
a {
	color:black;
}

.photoDiv {
	position: relative;
}
/* 찜하기 버튼 (이미지 오버) */
.likebtn { 
		font-size: 1.0rem;
		position: absolute;
		top: 263px;
		left: 10px;
		border-radius: 10%;
/* 		background-color:white; */
		

}
/* 거래상태 버튼(이미지 오버) */
.dealStatus {
		font-size: 0.7rem;
		position: absolute;
		top: 263px;
		right: 0px;
		border-radius: 40%;
}

.card-text{
	text-align: center;
	margin-top: 5px;
}

.card-body{
	font-size:0.9rem;
}


/* 거래가능상품보기 라디오박스? */
.form-check {
	margin-bottom:10px;
	margin-left:10px;
}




/* 탭 css */
ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	color: #222;
}

.tab-content{
	display: none;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}


/* 목록 카드 css */
.card-img-top{
	width:250x;
	height:300px;
}
row{
	margin:20px;
	padding:20px;
}
/* 카드 카테고리 */
.category {
	color:gray;
	font: bold;
/* 	background-color:lightgray; */
}
.Secondhandcount {
	font-size:15px;
	color:darkgray;
	margin-bottom:20px;
}
</style>
</head>
<body>



<%--머니또.참조 --%>
<input type="hidden" id="item_category" name="item_category" value="">
<input type="hidden" id="item_status" name="item_status" value="1">
<input type="hidden" id="item_price_min" name="item_price_min" value="0">
<input type="hidden" id="item_price_max" name="item_price_max" value="999999999999999">
<input type="hidden" id="sort" name="sort" value="default">
<input type="hidden" id="item_code" name="item_code" value="">
<input type="hidden" id="tag" name="tag" value="">


<header><%@ include file="../inc/header.jsp"%></header>
<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1로 설정) --%>
<c:set var="pageNum" value="1" />
<c:if test="${not empty param.pageNum }">
	<c:set var="pageNum" value="${param.pageNum }" />
</c:if>



	<article id="mainArticle">
		<div class="container">
		<hr>
		<div><h1 style="margin-top: 48px;font-size: 30px;"></h1></div>
			<div class="webWrapper">
				<div class="barWrapper">
					<div class="FilterBoxWrapper FilterCategory">
						<div class="FilterBoxTopic" >
							<div class="FilterBoxName">#카테고리</div>
						</div>
						<img src="https://ccimage.hellomarket.com/img/web/search/filter/blue_arrow.svg" alt="화살표 아래 아이콘" class="FilterBoxArrow">
					</div>
					<div class="FilterBoxWrapper FilterPrice">
						<div class="FilterBoxTopic">
							<div class="FilterBoxName">#가격</div>
						</div>
						<img src="https://ccimage.hellomarket.com/img/web/search/filter/blue_arrow.svg" alt="화살표 아래 아이콘" class="FilterBoxArrow">
					</div>
				<!-- 등급 -->
					<div class="FilterBoxWrapper FilterGrade">
						<div class="FilterBoxTopic">
							<div class="FilterBoxName"><label for="grade"><input type="checkbox" value="checked" id="grade"/>새싹 등급 이상 판매자</label></div>
						</div>
					</div>
		          	 
		        <!-- 거래완료 제외하고 보기 -->
					<div class="FilterBoxWrapper FilterCompleted">
						<div class="FilterBoxTopic">
							<div class="FilterBoxName"><label for="complete"><input type="checkbox" value="checked" id="complete" checked="checked"/>거래 완료 물품 제외</label></div>
						</div>
					</div>
		   		</div>
	         </div>
		<div id="__next">
				<div class="layout__Header-sc-1fg0dfe-0 iSTjqT"></div>
				<div class="layout__Children-sc-1fg0dfe-2 jjXXzz"></div>
				<div class="newSearch__Wrapper-sc-1v1g3nr-0 dVIBtK">
					<div class="web__Wrapper-sc-5x22ci-0 jDBdAO">
						<div class="toggle__Wrapper-skglus-0 dEBCMS">
							<!-- 카테고리상세 -->
							<div class="categoryDetail" style="display: none;">
								<div class="category__CategoryBox-sc-187sq7k-1 kGtMUL">
									<div class="List__Wrapper-rd56hw-0 cmyJpu">
										<div class="ListNonSelected" id="all" title="전체">전체</div>
										<div class="ListNonSelected" id="fashion" title="패션/의류/잡화/뷰티">패션/의류/잡화/뷰티</div>
										<div class="ListNonSelected" id="pc" title="가전제품/모바일/PC">가전제품/모바일/PC</div>
										<div class="ListNonSelected" id="interior" title="가구/인테리어">가구/인테리어</div>
										<div class="ListNonSelected" id="book" title="도서/음반/문구/티켓">도서/음반/문구/티켓</div>
										<div class="ListNonSelected" id="game" title="게임/스포츠/취미">게임/스포츠/취미</div>
										<div class="ListNonSelected" id="child" title="유아동/반려동물">유아동/반려동물</div>
										<div class="ListNonSelected" id="etc" title="기타">기타</div>
									</div>
								</div>
							</div>
								<!-- 카테고리상세 end -->
							
							<!-- 가격상세 -->
							<div class="priceDetail fEjcIX" style="display: none;">
								<input type="text" placeholder="최저금액" class="item_price_min cRHAEh" value="" onkeyup="this.value=this.value.replace(/[^-0-9]/g,''); priceInput(this);">
								<div class="price__StartPointText-sc-1yxjw4n-1 cOhRDO">원 부터~</div>
								<input type="text" placeholder="최고금액" class="item_price_max dfgaGw" value=""  onkeyup="this.value=this.value.replace(/[^-0-9]/g,''); priceInput(this);">
								<div class="price__EndPointText-sc-1yxjw4n-4 ecxgoB">원 까지</div>
								<button class="priceApplyBtn ezrKUu">적용하기</button>
							</div>

						</div>
					</div>
				</div>
			</div>
		
		
				<div id="hello" class="tagListWrapper">
				<div class="tagListFilterBox">
					<div class="tagListReset">
						<div class="tagListResetText">필터초기화</div>
						<img
							src="https://ccimage.hellomarket.com/img/web/search/filter/refresh.svg" alt="reset" class="tagListResetImg">
					</div>
				</div>
			</div>
		
		                    <!-- 정렬 -->
					<div class="SortListWrapper">
						<div class="SortListList" id="default" 	 title="최근 등록순">최근 등록순</div>
						<div class="SortListList" id="lowPrice"  title="낮은 가격순">낮은 가격순</div>
						<div class="SortListList" id="highPrice" title="높은 가격순">높은 가격순</div>
						<div class="SortListList" id="highGrade" title="높은 등급순">높은 등급순</div>
                   	</div>
                   	<!-- 현재 정렬 -->
                    <div class="sortSortBox">
                    	<div class="sortSort">최근 등록순</div>
                        <!-- 정렬버튼 이미지 -->
                        <img src="https://ccimage.hellomarket.com/img/web/search/itemList/ico_sort.png" alt="정렬 아이콘" class="sortSortImg"/>
                        </div>
		
		                   	<!-- 목록 -->
                    <div class="infinite-scroll-component " style="height:auto;">
						<div class="itemListWrapper">
							<div class="itemWrapper"></div>
						</div>
					</div>
		
		
			 	<img src="/Moneytto/resources/images/top.jpg" id="toTop">
		
		
			<hr>	
			<div class="category">
				<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1"> 카테고리 선택하기</li>
					<li class="tab-link" data-tab="tab-2"> 가격대 선택하기</li>		
				</ul>
				<!-- 카테고리 선택 영역 -->
				<div id="tab-1" class="tab-content">
					<c:forEach var="category" items="${categorylist }">
						<button class="btn btn-light" style="margin-top:10px;">${category.category_name }</button><br>
					</c:forEach>
				</div>
				<!-- 가격대 선택 영역 -->
				<div id="tab-2" class="tab-content">
					<input type="text" placeholder="최저가"> ~ <input type="text" placeholder="최고가"><button class="btn btn-light"> 적용하기</button>
				</div>
				<!-- 초기화,내상품등록 -->
				<div class="secondhandRegist" align="right" style="margin-top:20px;">
					<button class="btn btn-dark"> 필터초기화 </button>
					<a href="secondhandRegistForm"><button class="btn btn-dark"> 내 상품 등록하기 </button></a>
				</div>
			</div>
			
			<!-- 거래중 상품만 보기 -->
			<div class="form-check form-switch">
     			 <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
      			<label class="form-check-label" for="flexSwitchCheckDefault"> 거래가능 상품만 보기 </label>
    		</div>
			
			<hr>
			<!-- 상품개수표시 -->
			<div class="Secondhandcount"> 상품 개수 <b style="color:gray;">${listCount }</b> 개</div>
			

			
			
			
			
			
			
			
			
			
			

		
		<div class="row" align="left">
		<c:forEach var="secondhand" items="${secondhandList }">
			
			<div class="col-lg-3 col-mid-4">
						<div class="card border-0" >
						
							<!-- 썸네일이미지 - 서버 업로드시 경로 재설정 필요할수도 -->
							<div class="photoDiv">	
								<a href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
									<%--<img src="${image1 }" class="card-img-top" > --%>
									<%-- <img src="<spring:url value='${secondhand.secondhand_image1}'/>" class="card-img-top"/> --%>
									<img src="${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1}" class="card-img-top" >
									<%-- <img src="<%= request.getContextPath()%> + ${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1} "/> --%>									
									<%-- <img src="http://localhost:8089/zero/${secondhand.secondhand_image1}" class="card-img-top" > --%>
								</a>
								
								<!-- 찜하기 버튼 -->
								<span class="likebtn">
									<a href="#" style="align:right;">
										<img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="30px" height="30px">
									</a>
								</span>

								<!-- 거래상태 버튼 -->
								<span class="dealStatus"><button class="btn btn-dark">${secondhand.secondhand_deal_status}</button></span>
							</div>
							
							
							
							<div class="card-body">
								<!-- 카테고리 가져오기 -->
								<%-- <input type="hidden" id="seoncdhand_idx" value="${secondhand.secondhand_idx}"> --%>
								<div class="category" style="font-size:0.8rem; ">
									${secondhand.category_name }
								</div>
								
								<div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
									<!-- 제목 링크 -->
									<a href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
										${secondhand.secondhand_subject}
									</a>
									<!-- 찜하기 버튼 -->
<!-- 									<br> -->
<!-- 									<a href="#" style="align:right;"> -->
<%-- 										<img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="20px" height="20px"> --%>
<!-- 									</a> -->
								</div>
								<p><fmt:formatNumber pattern="#,###" value="${secondhand.secondhand_price }"/>원</p>
								
								<p>${secondhand.secondhand_first_date }</p>
							</div><!-- cardbody끝 -->
						</div><!-- card끝 -->
				
				</div>
			</c:forEach>
		</div><%--row끝 --%>
							
<!-- 						<div class="card"> -->
<!-- 							<div class="photoDiv"> -->
<!-- 								<a href="secondhand_detail"> -->
<%-- 									<img src="${pageContext.request.contextPath }/resources/img/슬라이드1.jpg" class="card-img-top" alt="..." > --%>
<!-- 								</a> -->
<!-- 								<span class="dealStatus"><button>판매중</button></span> -->
<!-- 							</div> -->
<!-- 						<div class="card-body"> -->
<!-- 							<button class="btn btn-light">패션/잡화/의류/뷰티</button> -->
<!-- 							<p class="card-text"> -->
<!-- 								<a href="secondhand_detail">제목입니다</a> -->
<%-- 								<a href="#" style="margin-left:50px"><img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="20px" height="20px"></a> --%>
<!-- 							</p> -->
<!-- 							<p>14,000원</p> -->
<!-- 							<p>2023-08-01 11:00:00</p> -->
<!-- 						</div> -->


		
<!-- 			<div class="row col col-3"> -->
<!-- 				<hr> -->
<!-- 				<div class="productArea"> -->
	
<!-- 					<div class="productListArea"> -->
<!-- 						<div class="card"> -->
<!-- 							<div class="photoDiv"> -->
<%-- 								<img src="${pageContext.request.contextPath }/resources/img/슬라이드1.jpg" class="card-img-top" alt="..." onclick="location.href='secondhand/secondhand_detail.jsp'"> --%>
<!-- 								<span class="dealStatus"><button>판매중</button></span> -->
<!-- 							</div> -->
<!-- 						<div class="card-body"> -->
<!-- 							<button class="btn btn-light">패션/잡화/의류/뷰티</button> -->
<!-- 							<p class="card-text"> -->
<!-- 								<a href="secondhand/secondhand_detail.jsp">제목입니다</a> -->
<%-- 								<a href="#" style="margin-left:50px"><img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="20px" height="20px"></a> --%>
<!-- 							</p> -->
<!-- 							<p>14,000원</p> -->
<!-- 							<p>2023-08-01 11:00:00</p> -->
<!-- 						</div> -->
<!-- 						</div> -->
						
						
<!-- 						<div class="card"> -->
<!-- 							<div class="photoDiv"> -->
<%-- 								<img src="${pageContext.request.contextPath }/resources/img/슬라이드1.jpg" class="card-img-top" alt="..." onclick="location.href='secondhand/secondhand_detail.jsp'"> --%>
<!-- 								<span class="dealStatus"><button>판매중</button></span> -->
<!-- 							</div> -->
<!-- 						<div class="card-body"> -->
<!-- 							<button class="btn btn-light">패션/잡화/의류/뷰티</button> -->
<!-- 							<p class="card-text"> -->
<!-- 								<a href="secondhand/secondhand_detail.jsp">제목입니다</a> -->
<%-- 								<a href="#" style="margin-left:50px"><img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="20px" height="20px"></a> --%>
<!-- 							</p> -->
<!-- 							<p>14,000원</p> -->
<!-- 							<p>2023-08-01 11:00:00</p> -->
<!-- 						</div> -->
<!-- 						</div> -->
						
						
<!-- 						<div class="card"> -->
<!-- 							<div class="photoDiv"> -->
<%-- 								<img src="${pageContext.request.contextPath }/resources/img/슬라이드1.jpg" class="card-img-top" alt="..." onclick="location.href='secondhand/secondhand_detail.jsp'"> --%>
<!-- 								<span class="dealStatus"><button>판매중</button></span> -->
<!-- 							</div> -->
<!-- 						<div class="card-body"> -->
<!-- 							<button class="btn btn-light">패션/잡화/의류/뷰티</button> -->
<!-- 							<p class="card-text"> -->
<!-- 								<a href="secondhand/secondhand_detail.jsp">제목입니다</a> -->
<%-- 								<a href="#" style="margin-left:50px"><img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="20px" height="20px"></a> --%>
<!-- 							</p> -->
<!-- 							<p>14,000원</p> -->
<!-- 							<p>2023-08-01 11:00:00</p> -->
<!-- 						</div> -->
<!-- 						</div> -->
						
<!-- 						<div class="card"> -->
<!-- 							<div class="photoDiv"> -->
<%-- 								<img src="${pageContext.request.contextPath }/resources/img/슬라이드1.jpg" class="card-img-top" alt="..." onclick="location.href='secondhand/secondhand_detail.jsp'"> --%>
<!-- 								<span class="dealStatus"><button>판매중</button></span> -->
<!-- 							</div> -->
<!-- 						<div class="card-body"> -->
<!-- 							<button class="btn btn-light">패션/잡화/의류/뷰티</button> -->
<!-- 							<p class="card-text"> -->
<!-- 								<a href="secondhand/secondhand_detail.jsp">제목입니다</a> -->
<%-- 								<a href="#" style="margin-left:50px"><img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="20px" height="20px"></a> --%>
<!-- 							</p> -->
<!-- 							<p>14,000원</p> -->
<!-- 							<p>2023-08-01 11:00:00</p> -->
<!-- 						</div> -->
<!-- 						</div> -->
						
<!-- 						<div class="card"> -->
<!-- 							<div class="photoDiv"> -->
<%-- 								<img src="${pageContext.request.contextPath }/resources/img/슬라이드1.jpg" class="card-img-top" alt="..." onclick="location.href='secondhand/secondhand_detail.jsp'"> --%>
<!-- 								<span class="dealStatus"><button>판매중</button></span> -->
<!-- 							</div> -->
<!-- 						<div class="card-body"> -->
<!-- 							<button class="btn btn-light">패션/잡화/의류/뷰티</button> -->
<!-- 							<p class="card-text"> -->
<!-- 								<a href="secondhand/secondhand_detail.jsp">제목입니다</a> -->
<%-- 								<a href="#" style="margin-left:50px"><img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="20px" height="20px"></a> --%>
<!-- 							</p> -->
<!-- 							<p>14,000원</p> -->
<!-- 							<p>2023-08-01 11:00:00</p> -->
<!-- 						</div> -->
<!-- 						</div> -->
						
						
<!-- 					</div> -->
<!-- 				</div> -->
<%-- 			</div>row끝 --%>
		</div><%--container 끝 --%>
		
	</article>
	
	<footer>
	</footer>
</body>

</html>