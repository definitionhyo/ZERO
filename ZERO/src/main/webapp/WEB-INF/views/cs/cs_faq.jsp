<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/cs.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/button.css" rel="stylesheet" type="text/css">
<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script> --%>
<title>ZERO</title>
<style>
	.searchFaq {
		position: relative;
/* 		height: 40px; */
		margin: 16px 0 16px;
	}
	/* a링크 활성화 색상 변경 */
a:hover, a:active{
	color:  #ff5050 !important;
	text-decoration: none;
}

	.seachArea{
		margin: 1.2em 0;
	}
	/* 검색창안에 검색아이콘 넣기 위한 설정 */
	.board-search {
 		margin: 0.8em 0;
 		width: 300px; 
 		height: 2em;
 		border-radius: 3px; 
 		border: 1px solid #ccc; 
/* 		display: flex; */
/* 		justify-content: center; */
/* 		align-items: center; */
		vertical-align: center;
 		z-index: 1;
 		opacity: 1;
	}
	.board-search>#searchTxt {
		width: 200px;
		height: 1.5em;
		border: none;
/* 		-webkit-appearance: none; */
		text-align: left;
		margin-left: 10px;
		overflow: auto;	/* 검색어가 길어졌을 때 오른쪽으로 검색되도록 하기 위해*/
		z-index: -1;
		font-size: 15px;
	}
	.board-search>#searchTxt:focus {
		outline: none;
/* 		width: 300px; */
/* 		text-align: left; */
	}
	/* 검색버튼 */
	#searchBtn {
		outline: none;
		width: 25px;
		height: 25px;
	}
	/* 버튼안 아이콘 */
	material-symbols-outlined {
		line-height: 0;
		font-size: 20px;
	}
	
	/* 검색어없이 검색버튼 클릭 시 중앙에 값 표시하기 */
	.none {
		margin: 5em auto;
	}
	
	.clear {
		clear: both;
	}
	.qPart {
		background-color: #eee;
		border: 1px dotted #ddd;
		margin: 0;
		padding: 15px 10px;
		width: 100%
	}
 	.qPart:hover {background-color: #ddd; }
  	.checkbox {display: none;}  
	.target {
/*  		display: none; */
		margin: 0 15px 0.5em;
		padding: 5px;
	}
	#pageBtn-group {
		text-align: center;
		margin: 1em auto;
	}
	.pageBtn {
		margin: 2px;	/* 페이지 버튼 사이 간격 조절*/
	}
	/* 카테고리 글자 강조 */
	strong {
		padding-left: 0.5em;
		color: #596757;
	}


#csCategory {
	overflow-y: hidden;
	overflow-x: scroll;
}

#csCategory::-webkit-scrollbar {
    width: 10px;  /* 세로축 스크롤바 폭 너비 */
    height: 10px;  /* 가로축 스크롤바 폭 너비 */
}
/* 스크롤바 막대 */
#csCategory::-webkit-scrollbar-thumb {
    background: #aaa; /* 스크롤바 막대 색상 */
    border: 2px solid #dfdfdf; /* 스크롤바 막대 테두리 설정  */
    border-radius: 12px 12px 12px 12px;
    height: 6px;
}
#csCategory::-webkit-scrollbar-thumb:hover {
	background-color:#777;
}
</style>
<script type="text/javascript">
$(function() {
	// 화면 처음 로딩 시 '전체' 질문, 답변 들고오기
	// 카테고리 : '전체'면 모두 들고 오게 mapper에서 설정
	let cs_type = '전체';
	// pageNum은 1로 설정
	let pageNum = 1;
	
	$.ajax({
		// 요청타입, 요청할 주소, 요청시 파라미터(배열타입), 리턴타입
		type: 'GET',
		url: '<c:url value="/faq_data"/>',
		data: {'cs_type': cs_type},
		dataType: 'JSON',	// 응답데이터 json형식으로 전달받음
		success: function(result) {	// 요청 성공 시(파라미터 : 요청 응답 데이터)
			
			// 총 몇 건인지 안내
			$("#totalCnt").text(result.length);
			
			// 페이지 당 첫 글 번호, 마지막 글 번호
			let start = pageNum * 5 - 4;
			let limit = pageNum * 5;
			
			// 한 페이지에 들어가는 글 수 만큼 반복(글 내용)
			for(let i = 0; i <= (limit - start); i++) {
				// 답변 내용을 db에서 받아올때 줄바꿈 형식을 태그로 바꿔서 줄바꿈 구현
				let content = result[i].cs_content;
				let fomattedContent = content.replace(/\n/g, "<br>");
				// 지정한 div안에 내용 추가([카테고리] Q. 질문)
				// 결과값이 List타입으로 배열 안 데이터에 접근하듯 사용
				$("#faqContents").append(
						"<label class='qPart' id='check" + i + "' data-target='target" + i + "'>"
						+ "<input type='checkbox' class='checkbox' id='check" + i + "' data-target='target" + i + "' />"
						+ "<strong>[" + result[i].cs_type + "]</strong> <br>" + " Q. " + result[i].cs_subject 
						+ "</label>"
						);
				// 지정한 div안에 내용 추가(A. 답변)
				$("#faqContents").append(
						"<div class='target' id='target" + i + "' > A. " + fomattedContent + "</div>"
						);
			}
			// 답변 영역 사라지게하기
			$(".target").hide();
			
			// 페이지(버튼) 갯수
			// 올림(가져온 결과값 / 한 페이지당 글 수)
			let pageCount = Math.ceil(result.length / 5);
			
			// 페이지(버튼) 개수만큼 버튼 생성
			for(let i = 1; i <= pageCount; i++) {
				$("#pageBtn-group").append(
						"<button class='pageBtn btn btn-outline-dark' id='btn" + i + "'>" + i + "</button>"
						);
			}
			// 첫번째 버튼 색있는 버튼으로 만들기(클래스 변경)
			$("button[id='btn1']").removeClass("btn-outline-dark");
			$("button[id='btn1']").addClass("btn-dark");
			
		},
		// ajax로 값을 가져오지 못했을 경우 alert창 띄우기
		error: function() {
			alert('에러');
		}
	});
	
	// 카테고리 버튼 클릭 시 카테고리별 질문 & 답변 들고오기, 페이지 버튼 생성
	$(".btn-group>button").click(function() {
		// 클릭된 버튼의 value값(카테고리명)을 받아 DB에서 받아오기
		let cs_type = $(this).val();	// 클릭한 버튼의 value값을 가져와 변수에 저장
		let pageNum = 1;	// 카테고리 클릭 시 첫 페이지 보여주기
//				console.log(cs_type);
			
			$.ajax({
				type: 'GET',
				url: '<c:url value="/faq_data"/>',
				data: {'cs_type': cs_type},
				dataType: 'JSON',
				success: function(result) {	// 요청 성공 시
//						console.log("받아오기 성공!");
					
					// 눌린 버튼 비활성화, 아닌 버튼 활성화(다른 페이지 선택시 사용하기 위한 장치)
					$(".btn-group>button").addClass("btn-outline-dark");
					$(".btn-group>button").removeClass("btn-dark");
					$("button[value='" + cs_type +"']").addClass("btn-dark");
					$("button[value='" + cs_type +"']").removeClass("btn-outline-dark");
//						$(".btn-group>button").attr("disabled", false);
//						$("button[value='" + cs_type +"']").attr("disabled", true);
					
					// 총 몇 건인지 안내
					$("#totalCnt").text(result.length);	
					
					// 페이징 처리를 위한 변수 정의
					let start = pageNum * 5 - 4;
					let limit = pageNum * 5;
					
					// 만약 가져온 글 갯수가 지정 페이지의 예상 마지막 글번호보다 작을 경우
					// 가져온 글 갯수를 마지막 글번호로 지정
					// ex. 13개 -> 3페이지 15까지 X, 3페이지 13개까지 반복
					if(result.length <= limit){
						limit = result.length;
					}
					
					// 기존에 div에 있던 내용 비우기
					$("#faqContents").empty();
					
					// 1페이지 시작(1)~끝(5)까지 반복하면서 지정 div에 값 추가
					for(let i = (start - 1); i < limit; i++) {
						// 답변 내용을 db에서 받아올때 줄바꿈 형식을 태그로 바꿔서 줄바꿈 구현
						let content = result[i].cs_content;
						let fomattedContent = content.replace(/\n/g, "<br>");
//							
						$("#faqContents").append(
								"<label class='qPart' id='check" + i + "'>"
								+ "<input type='checkbox' class='checkbox' id='check" + i + "' data-target='target" + i + "' />"
								+ "<strong>[" + result[i].cs_type + "]</strong> <br>" + " Q. " + result[i].cs_subject 
								+ "</label>"
								);
						// 지정한 div안에 내용 추가(A. 답변)
						$("#faqContents").append(
								"<div class='target' id='target" + i + "' > A. " + fomattedContent + "</div>"
								);
					}
					// 답변 영역 사라지게하기
					$(".target").hide();
					
					// 전 페이지(다른 카테고리) 버튼들 삭제
					$("#pageBtn-group").empty();
					// 페이지(버튼) 갯수
					let pageCount = Math.ceil(result.length / 5);
//						console.log(pageCount);
					
					for(let i = 1; i <= pageCount; i++) {
//							console.log(i);
						$("#pageBtn-group").append(
								"<button class='pageBtn btn btn-outline-dark' id='btn" + i + "'>" + i + "</button>"
								);
					}
					// 첫번째 버튼 색있는 버튼으로 만들기(클래스 변경)
					$("button[id='btn1']").removeClass("btn-outline-dark");
					$("button[id='btn1']").addClass("btn-dark");
				},
				error: function() {
					alert('에러');
				}
			});
	});
});

$(document).ready(function() {
    // 토글 버튼이 클릭되면 토글 동작 수행
    $(document).on("change", ".checkbox", function() {
        let targetId = $(this).data('target');

        if ($(this).prop("checked")) {
            $("#" + targetId).show();
        } else {
            $("#" + targetId).hide();
        }
    });
});


</script>
</head>
<body>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	<article>
		<div class="container cs">
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/cs_sidebar.jsp"></jsp:include>
			</nav>
			<div class="contentArea">
				<div>
					<div class="content_title border">
						<div class="title">
							자주묻는질문
						</div>
						<nav class="navbar navbar-light"><%-- 사이드바 사라졌을 때 햄버거 메뉴 --%>
							<a class="navbar-brand" href="#"></a>
							<button class="navbar-toggler collapsed border-0 hidden_nav" type="button" data-toggle="collapse" data-target="#csCollapse" aria-controls="csCollapse" aria-expanded="false" aria-label="Toggle navigation">
								<span class="navbar-toggler-icon"></span>
							</button>
							<jsp:include page="/WEB-INF/views/inc/cs_sidebar_hidden.jsp"></jsp:include>
						</nav>
					</div>
					
					<%-- 검색 영역 --%>
					<div class="searchFaq">
<!-- 						<form class="form-inline my-2 my-md-0"> -->
<!-- 							<input class="form-control form-control mr-2 mr-sm-2" type="search" placeholder="Search"> -->
<!-- 							<button class="btn btn-outline-dark my-2 my-sm-0" type="submit">Search</button> -->
<!-- 						</form> -->
					</div>
					
					<%-- 카테고리 표시 영역 --%>
					<div id="csCategory">
						<div class="btn-group" role="group" aria-label="Basic example">
							<button type="button" id="faqAll" value="전체" class="btn btn-dark text-nowrap" >전체</button>
							<button type="button" id="faqReserv" value="1" class="btn btn-outline-dark text-nowrap">이용정책</button>
							<button type="button" id="faqMemship" value="2" class="btn btn-outline-dark text-nowrap">공통</button>
							<button type="button" id="faqTheater" value="3" class="btn btn-outline-dark text-nowrap">중고판매</button>
							<button type="button" id="faqTheater" value="4" class="btn btn-outline-dark text-nowrap">경매판매</button>
							<button type="button" id="faqPayment" value=5 class="btn btn-outline-dark text-nowrap">경매구매</button>
							<button type="button" id="faqTheater" value="6" class="btn btn-outline-dark text-nowrap">ZPAY</button>
						</div>
					</div>
					
					<hr>
					<%--  --%>
					<div>
	                    <div class="faq-list-box">
	                        <p class="reset mb10">
	                            <strong>
	                                <span id="totalTitle">전체</span>
	                                <span class="font-green" id="totalCnt"></span>건
	                            </strong>
	                        </p>
                        </div>

                    <div id="faqContents">
                    </div>
                    <hr>
                    <div id="pageBtn-group">
                    </div>

						
						<script type="text/javascript">
							// $(function){} 안에 넣으면 페이지가 로딩될 때 구현되므로
							// 버튼 클릭 시 안의 내용이 실행되도록 on()메서드에
							// "click", "지정요소(#, ., 태그이름 등)", 익명함수를 파라미터로 사용
							// 페이지 버튼 클릭 시 ajax 실행
							$(document).on("click", ".pageBtn", function() {
                            // 클릭된 버튼의 value값(카테고리명)을 받아 DB에서 받아오기
                            // 카테고리 버튼이 클릭되면 btn-danger 클래스를 추가함
                            // btn-group안 btn-danger 클래스를 추가된 버튼의 value값을 가져옴
                            let cs_type = $(".btn-group>.btn-dark").val();
                            let pageNum = $(this).text();    // <button>안 글자를 페이지 변수로 사용

                            $("#pageBtn-group>button").removeClass("btn-dark");
                            $("#pageBtn-group>button").addClass("btn-outline-dark");
                            $(this).removeClass("btn-outline-dark");
                            $(this).addClass("btn-dark");

                            $.ajax({
                                type: 'GET',
                                url: '<c:url value="/faq_data"/>',
                                data: {'cs_type': cs_type},
                                dataType: 'JSON',
                                success: function(result) {    // 요청 성공 시
                                    // 페이징 처리를 위한 변수 정의
                                    let start = pageNum * 5 - 4;
                                    let limit = pageNum * 5;

                                    if (result.length <= limit) {
                                        limit = result.length;
                                    }

                                    $("#faqContents").empty();
                                    for (let i = (start - 1); i < limit; i++) {
                                        let content = result[i].cs_content;
                                        let formattedContent = content.replace(/\n/g, "<br>");

                                        $("#faqContents").append(
                                            "<label class='qPart' id='check" + i + "'>"
                                            + "<input type='checkbox' class='checkbox' id='check" + i + "' data-target='target" + i + "' />"
                                            + "<strong>[" + result[i].cs_type + "]</strong> <br>" + " Q. " + result[i].cs_subject
                                            + "</label>"
                                        );

                                        // 지정한 div안에 내용 추가(A. 답변)
                                        $("#faqContents").append(
                                            "<div class='target' id='target" + i + "' > A. " + formattedContent + "</div>"
                                        );
                                        // 초기에는 답변 영역을 숨기도록 설정
                                        $(".target").hide();
                                    }
								,
                                error: function() {
                                    alert('에러');
                                }
                            });
                        });
                    </script>

					</div>
				</div>
			</div>
		</div>
	</article>
	
	<footer>
	
	</footer>
</body>
</html>