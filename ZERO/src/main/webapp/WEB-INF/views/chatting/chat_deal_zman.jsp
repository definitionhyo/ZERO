<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/zpay.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<title>ZERO</title>
<style type="text/css">
@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
*{
	 font-family: 'NanumSquareNeo-Variable';
}
/*  */
.chargeContentArea .chargeInputArea .withdrawalAccountArea {
    margin-top: 10px;
}
.title {
	height: 25px;
	font-size: 16px !important;
	padding-right: 10px !important;
	line-height: 24px !important;
}
.title button {
	font-size: 15px;
	padding: 0.2rem 0.5rem;
	margin-left: 0.5rem;
}
/* 주소 받는 입력창 조절 */
.input_txt1 {
	width: 80px;
	margin-bottom: 5px;
}
.input_txt2 {
	width: 100%;
}
.redText {
	color: red;
}

.titleNotice {
	padding: 10px 0 0 5px !important;
	font-size: 13px !important;
}

.priceDetail {
	font-size: 12px;
	color: #777;
}
/* 밑에 버튼 영역 */
.chargeButtonArea {
	margin: auto;
	padding-top: 10px;
}

</style>
<%-- 우편번호찾기 Daum api --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	
	// 수정 시 값이 있는 것만 받아서 ajax로 전달하기 위한 변수
	let addInfo = "";	
	let inputStart = "${zmanOrderInfo.zman_delivery_startspot}";
	let inputEnd = "${zmanOrderInfo.zman_delivery_endspot}";
	console.log("inputStart : " + inputStart);
	console.log("inputEnd : " + inputEnd);
	
	$(function() {
		if(inputStart != "") {
// 			$("#member_zipcode1").attr('value', inputEnd.split(",")[0]);
			$("#zman_delivery_startspot").attr('value', inputStart);
// 			console.log("inputStart : " + inputStart.split(",")[0] + ":" + inputStart.split(",")[1]);
		}
		if(inputEnd != "") {
// 			$("#member_zipcode2").attr('value', inputEnd.split(",")[0]);
			$("#zman_delivery_endspot").attr('value', inputEnd);
// 			console.log("inputEnd : " + inputEnd.split(",")[0] + ":" + inputEnd.split(",")[1]);
		}
		
	});
	
	function DaumPostcode(event, num) {
		event.preventDefault();
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
//                     document.getElementById("member_extraAddress").value = extraAddr;
                    addr = addr + " " + extraAddr;
                
                } else {
//                     document.getElementById("member_extraAddress").value = '';
					addr = addr;
                }
                
                if(num == 1) {
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
// 	                document.getElementById('member_zipcode1').value = data.zonecode;
	                document.getElementById("zman_delivery_startspot").value = addr;
                } else {
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
// 	                document.getElementById('member_zipcode2').value = data.zonecode;
	                document.getElementById("zman_delivery_endspot").value = addr;
                }
            }
        }).open();
    }
	// ------ 우편번호 찾기 끝
	let start;
	let end;
	// 수정하기, 호출하기 버튼 클릭 시 실행되는 함수
	function submitBtn(type) {
		if($("#zman_delivery_startspot").val() != "") {
			start = $("#zman_delivery_startspot").val();
			console.log("start : " + start);
			addInfo += "&zman_delivery_startspot=" + start;
		}
		if($("#zman_delivery_endspot").val() != "") {
			end = $("#zman_delivery_endspot").val();
			console.log("end : " + end);
			addInfo += "&zman_delivery_endspot=" + end;
		}
		console.log("수정할 사항들임!");
		console.log("addInfo : " + addInfo);
		
		switch(type) {
			case 1:
				if(addInfo == null || addInfo == "") {	// 입력된 값이 없으면 처리 안함
					alert("수정할 정보가 없습니다!");
				} else {
					let url = "chatToZ?"
						+ "secondhand_idx=" + "${param.secondhand_idx }"
						+ "&seller_id=" + "${param.seller_id}"
						+ "&buyer_id=" + "${param.buyer_id}"
						+ "&type=" + '수정'
						+ addInfo
						;
					console.log(url);
					
					$.ajax({
						url: url,
						type: "GET",
						success: function(data) {
							console.log("DB 저장 성공");
							console.log(url);
							window.close();
						},
						error: function(request,status,error) {
							console.log(url);
							console.log("DB 저장 실패");
						}
					});
				}
				break;
			case 2:
				if(start == null || end == null || start == "" || end == "") {
					alert("출발지 또는 도착지 정보가 입력되지 않았습니다! \n호출이 불가능합니다");
				} else if ("${param.order_secondhand_status}" != '결제완료') {
					alert("Z페이 송금 후 호출이 가능합니다! \n호출이 불가능합니다");
				} else {
					console.log("DB에 값 넣기");
					// 정보 모두 입력된 경우만 가능
					$.ajax({
						data: {
							"order_secondhand_idx": ${orderInfo.order_secondhand_idx }
// 							, "seller_id": "${param.seller_id}"
// 							, "buyer_id": "${param.buyer_id}"
// 							, "zman_delivery_startspot": start
// 							, "zman_delivery_endspot": end
							, "zman_delivery_idx": ${zmanOrderInfo.zman_delivery_idx}
						},
						url: "callZ",
						type: "POST",
						success: function(data) {
							console.log("DB 저장 성공");
							let call = '출발지와 도착지 입력완료!<br>Z맨 호출중입니다!';
							// 부모창인 채팅창에 메시지 함수 호출 subNotice(type, typeMsg)
							window.opener.subNotice('call', call);
							window.close();
						},
						error: function(request,status,error) {
							console.log("DB 저장 실패");
						}
					});
					
				}
				break;
		}	// switch문 끝
	}
	// submitBtn() 끝
	
</script>
<style type="text/css">
/* 	.container { */
/* 		padding-bottom: 0; */
/* 	} */
</style>
</head>
<body>
	<article>
		<div class="container">
			<div class="contentArea">
			<%-- 메인영역 --%>
					<div class="chargeContentArea">
						<div class="chargeInputArea">
							<h3 class="input_title">ZMAN 접수</h3>
							<div class="title">
								주소지를 입력해주세요
							</div>
							<div class="withdrawalAccountArea">
								<div class="title">
									출발지(판매자) 
<%-- 									2. ${param.seller_id } --%>
									<%-- 판매자만 수정 가능 --%>
									<c:if test="${sessionScope.member_id eq param.seller_id }">
										<button class="btn btn-outline-dark" onclick="DaumPostcode(event, 1)">우편번호 찾기</button>
									</c:if>
								</div>
								<div class="withdrawalAccount_info">
<!-- 									<input type="text" class="input_txt1"  placeholder="우편번호" autocomplete="off" data-v-4e1fd2e6="" -->
<!-- 										id="member_zipcode1" name="member_zipcode1" required="required" readonly> -->
<!-- 									<button class="btn btn-outline-dark" onclick="DaumPostcode(event)">우편번호 찾기</button> -->
									<input type="text" class="input_txt2" placeholder="도로명주소" autocomplete="off" data-v-4e1fd2e6=""
										   id="zman_delivery_startspot" name="zman_delivery_startspot" required="required" readonly>
								</div>
								<div class="title">
									도착지(구매자) 
<%-- 									1. ${sessionScope.member_id } --%>
<%-- 									2. ${param.buyer_id } --%>
									<%-- 구매자만 수정 가능 --%>
									<c:if test="${sessionScope.member_id eq param.buyer_id }">
										<button class="btn btn-outline-dark" onclick="DaumPostcode(event, 2)">우편번호 찾기</button>
									</c:if>
								</div>
								<div class="withdrawalAccount_info">
<!-- 									<input type="text" class="input_txt1"  placeholder="우편번호" autocomplete="off" data-v-4e1fd2e6="" -->
<!-- 										id="member_zipcode2" name="member_zipcode2" required="required" readonly> -->
<!-- 									<button class="btn btn-outline-dark" onclick="DaumPostcode(event)">우편번호 찾기</button> -->
									<input type="text" class="input_txt2" placeholder="도로명주소" autocomplete="off" data-v-4e1fd2e6=""
										   id="zman_delivery_endspot" name="zman_delivery_endspot" required="required" readonly>
								</div>
							</div><%-- withdrawalAccountArea 영역 끝 --%>
							
							<div class="withdrawalAccountArea">
								<div class="title">
									총금액
								</div>
								<div class="withdrawalAccount_info">
									
									<div class="withdrawalBankName">
										<fmt:formatNumber value="${param.order_secondhand_price + 3000 }" pattern="###,###"/>원
									</div>
									<div class="withdrawalAccountNum priceDetail">
										= <fmt:formatNumber value="${param.order_secondhand_price }" pattern="###,###"/>(상품가격) + 3,000(배달비)
									</div>
								</div>
<!-- 								<div class="title"> -->
<!-- 									희망배달시간 -->
<!-- 								</div> -->
<!-- 								<div class="withdrawalAccount_info"> -->
<!-- 									<div class="withdrawalBankName">2023년 00월 00일 00시(미정)</div> -->
<!-- 								</div> -->
								<div class="title titleNotice">
									ZMAN 호출 후에는 <b class="redText">수정이 불가능</b>하오니 다시 한 번 확인 후<br>
									호출하기 버튼을 눌러주세요<br>
									(출발지, 도착지가 모두 입력되고 Z페이 결제가 완료되면 ZMAN 호출이 시작됩니다)
								</div>
							</div><%-- withdrawalAccountArea 영역 끝 --%>
							
						</div><%-- chargeInputArea 영역 끝 --%>
						<div class="chargeButtonArea">
							<c:if test="">
							</c:if>
							<button type="button" onclick="submitBtn(1)" class="btn btn-dark">주소저장하기</button>
							<c:if test="${sessionScope.member_id eq param.seller_id }">
								<button type="button" onclick="submitBtn(2)" class="btn btn-dark">호출하기</button>
							</c:if>
							<button type="button" class="btn btn-dark" onclick="window.close()">취소</button>
						</div><%-- chargeButtenArea 영역 끝 --%>
					</div><%-- chargeContetnArea 영역 끝 --%>
			</div><%-- contentArea 영역 끝 --%>
		</div><%-- container 영역 끝 --%>
	</article>
	<footer>
	</footer>

</body>
</html>