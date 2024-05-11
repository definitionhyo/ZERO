<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<meta charset="UTF-8">
<title> ZERO | 경매상세 </title>
	
<script type="text/javascript">



$(function(){
	$("#startPrice").html(comma($("#startPrice").html()));
	$("#presentPrice").html(comma($("#presentPrice").html()));
	$("#maxPrice").html(comma($("#maxPrice").html()));
	$("#zpayBalance").html(comma($("#zpayBalance").html()));
	$("#possibleZpay").html(comma($("#possibleZpay").html()));
	for(let i=0; i<${fn:length(logList)}; i++){
 	$("#logBid"+i).html(comma($("#logBid"+i).html()));
	}	
	$("#bid_price").on("propertychange change keyup paste input", function() {
		
		
		let checkPrice = $("#bid_price").val() ;
				
		/* 숫자 comma 찍는 함수 */
		checkPrice = comma(checkPrice);
		
		
		/* console.log(p_price); */
		
		$("#bidCheck").html(checkPrice+" 원");
		if(checkPrice==""){
		$("#bidCheck").html("");}
		$("#bidCheck").css('color','red');

	});
	updateTime();
	});

	function updateTime() {
	  const now = new Date();
	  const endOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1, 0, 0, 0);
	  let timeRemaining = endOfDay - now;
	  let hours = Math.floor(timeRemaining / 1000 / 60 / 60);
	  let minutes = Math.floor((timeRemaining / (1000 * 60)) % 60);
	  let seconds = Math.floor((timeRemaining / 1000) % 60);
	  let currentTime = padZero(hours, 2)+':'+padZero(minutes, 2)+':'+padZero(seconds, 2);
	  
	  $('#clock').html('<h3>'+currentTime+'</h3>');
      if(currentTime=="00:00:00"){
    	  $("#clock").css("display", "none");
    		$("#clockTitle").css("display", "none");
    		$("#bottomRight").css("display", "none");
    		$("#usersArea").css("display", "none");
    		$("#presentPriceTitle").html("<b>최종낙찰가격</b>");
    		
    		var str = "<div  style=' text-align: center;'>";
    		str += "<b> --------경매종료-------- </b>";
    		str += "</div>";
      $("#msgArea").append(str);
  	$('#auction_log').scrollTop($('#auction_log')[0].scrollHeight);
    		
    	  
      }
// 	  setInterval(updateTime, 1000);
	  setTimeout(updateTime, 1000);
	  
	}
function padZero(num, size) {
	  let s = num + '';
	  while (s.length < size) s = '0' + s;
	  return s;
	}
	
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
</script>


<style type="text/css">
.container-fluid{
max-width: 1280px;
}

	.blink {
			
		background-color: gray!important;
		  color: white!important;
		}
		
	#auction_log{
		overflow: auto; 
		width: 100%; 
		height: 200px; 
		padding: 10px; 
		border:1px solid;
		}
	#bid_price{
		width: 130px; 
	}
	

	@media only screen and (min-width: 768px) {
		body{
		margin-top: 120px!important;
		
	}
	
		#auction_log{
		height: 500px; 		
		}
	
	}
	
	
</style>


</head>
<body>
	<!-- header -->
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	

	
	<section>
		<div class="container-fluid">
			<div class="row">
				<!-- 좌측 영역 -->
                <div class="col-md-4">
                	<div class="row d-flex justify-content-center">
                	<div class="col-4 col-md-4"><h3 id="clockTitle">남은시간</h3></div>	<div class="col-3 col-md-3" id="clock"></div>

<!--                 		<h2>03 : 23 : 01</h2> -->
                	</div>
                		<div id="auction_log">
                		<div id="logArea" class="col">
                		<c:forEach var="log" items="${logList}" varStatus="i">
                		<c:if test="${log.member_id eq sessionScope.member_id}"><div class='alert alert-warning' style=' text-align: center;'></c:if>
                		<c:if test="${log.member_id ne sessionScope.member_id}"><div class='alert alert-secondary' style=' text-align: center;'></c:if>
                		<b>${log.member_id }님이 <span id="logBid${i.index}">${log.auction_log_bid }</span>원 입찰!</b>
                		</div>
                		</c:forEach>
                		</div>
                		<div id="msgArea" class="col">
                		</div>
                		</div>                	
                	<div class="col-12 col-md-12" id="usersArea"><div class="row d-flex justify-content-center">현재 접속중 회원&nbsp;<span id=currentUsersSum></span>명</div></div>
		<div class="col-12 col-md-12" id="users"></div>	
                </div>
                
				<!--우측 영역 -->
                <div class="row col-md-8">
						<!-- 이미지  -->
                	 <div class="col-md-4 d-none d-md-block">
                	 	<img alt="상품이미지" class="img-fluid" src="${pageContext.request.contextPath }/resources/upload/${product.auction_image1 }">
                	 </div>
						<!--상품명 -->								
                	 <div class="row col-md-8" style=" text-align: center;">  
                	               	 	
                	 	<div class="col-12 col-md-12"><h3>${product.auction_title }</h3></div>
                	 	
                	 	<div class="col-6 col-md-3 d-none d-md-block"> 
                	 		<h4><b>경매날짜</b></h4>
                	 	</div>   
                	 	
                	 	<div class="col-6 col-md-9 d-none d-md-block">    
                	 		${product.auction_start_datetime }~${product.auction_end_datetime }
                	 	</div>
                	 	<div class="col-6 col-md-3"> 
                	 		<h4 id="presentPriceTitle"><b>현재가격</b></h4>
                	 	</div>   
                	 	
                	 	<div class="col-6 col-md-9">    
                	 		<b><span id="presentPrice">
                	 		<c:if test="${empty logList  }">
								${product.auction_start_price }
							</c:if>
                	 		<c:forEach var="log" items="${logList}"  varStatus="index">
                	 			   <c:if test="${index.last}">${log.auction_log_bid}</c:if>
                	 		</c:forEach>
                	 		</span> 원</b>
                	 	</div>
                	 	<div class="col-6 col-md-3 d-none d-md-block"> 
                	 		<h4><b>시작가격</b></h4>
                	 	</div>   
                	 	
                	 	<div class="col-6 col-md-9 d-none d-md-block">    
                	 		<span id="startPrice">${product.auction_start_price }</span> 원
                	 	</div>
                	 </div>
                	 
	                <div class="row col-md-12 " id="bottomRight">
	                
	                	<div class="col-4 col-md-4"  style=" text-align: right;">    
                	 		<h4><b>입찰가격 </b></h4>
                	 		<br>
                	 	</div>
                	 	<div class="col-4 col-md-3">
                	 		<input type="number" id="bid_price" class="bid" >원<br><span id=bidCheck ></span>
                	 		
                	 	</div>
                	 	<div class="col-4 col-md-5"> 
                	 		<button type="button" id="button-send"class="btn btn-secondary btn-block">입찰하기</button>
                	 	</div> 
                	 	  
	                	<div class="col-4 col-md-4"  style=" text-align: right;">    
                	 		<h4><b>즉시구매가격</b></h4>
                	 		<br>
                	 	</div>
                	 	<div class="col-4 col-md-3">
                	 		<span id="maxPrice">${product.auction_max_price }</span> 원
                	 	</div>
                	 	<div class="col-4 col-md-5"> 
                	 		<button type="submit" id="button-send2" class="btn btn-dark  btn-block">즉시구매</button>
                	 	</div>   
	                	
	                	<div class="col-4 col-md-4"  style=" text-align: right;">    
                	 		<h4><b>Z-PAY 잔액</b></h4>
                	 	</div>
                	 	<div class="col-4 col-md-3">
                	 		<span id="zpayBalance">${balance} 원</span>
                	 	</div>
                	 	<div class="col-4 col-md-5"> 
                	 	 	<a href="zpay_charge_form" class="btn btn-primary  btn-block">충전하기</a>
                	 	</div>   
	                	<div class="col-4 col-md-4"  style=" text-align: right;">    
                	 		<h4><b>입찰가능금액</b></h4>
                	 	</div>
                	 	<div class="col-4 col-md-3">
                	 		<b><span id=possibleZpay >${possibleZpay} 원</span></b>
                	 	</div>
                	 	<div class="col-4 col-md-5"> 
                	 	 	*zpay 잔액에서 금일 다른 상품 경매 입찰에 사용한 금액을 뺀 금액입니다.
                	 	</div>   
	                </div>
                </div>
            </div>
		</div>
		
	</section>
	
	<!-- footer -->
	<footer>
		
	</footer>
</body>
<script type="text/javascript">

//전송 버튼 누르는 이벤트
$("#button-send").on("click", function(e) {
	
	if($("#bidCheck").html().length == 0){
		alert("금액을 입력하세요");
	}else if($("#bid_price").val()>="${product.auction_max_price }"){
		$("#button-send2").click();
	}else{
	  let result = confirm($("#bidCheck").html()+"을 입찰하시겠습니까?");

      if(!result){return false;}

      sendMessage();
	}
});
//엔터키 누르는 이벤트
$("#bid_price").on("keyup",function(key){
    if(key.keyCode==13) {
    	if($("#bidCheck").html().length == 0){
    		alert("금액을 입력하세요");
    	}else if($("#bid_price").val()>="${product.auction_max_price }"){
    		$("#button-send2").click();
    	}else{
    	let result = confirm($("#bidCheck").html()+"을 입찰하시겠습니까?");

        if(!result){return false;}


  	sendMessage();
    }
    }
});

//즉시구매
$("#button-send2").on("click", function(e) {
	
	
	  let result = confirm("즉시구매가격은 "+$("#maxPrice").html()+"원 입니다 즉시구매 하시겠습니까?");

      if(!result){return false;}
      $.ajax({
  		data: {
  			'id':"${param.id}"
  		},
  		url: "direct_pay_pro",
  		type: "POST",
  		success: function(result) {
  			if(result == "false"){
  				alert("입찰가능금액이 부족합니다");
  				return;
  			}else if (result =="false2") {
  				alert("경매종료");
  				location.reload();
  				return;
			}
  			 $.ajax({
  		  		data: {
  		  			'order_auction_idx':result
  		  		},
  		  		url: "zpay_auction_send_pro",
  		  		type: "POST",
  		  		success: function() {
		  		  		$.ajax({
		  		  		data: {
		  		  			'auction_idx':"${param.id}",
		  		  			'auction_log_bid': "${product.auction_max_price}",
		  		  		},
		  		  		url: "logHistory",
		  		  		type: "POST",
		  		  		success: function(result) {
		  		  			if(result == "true") {
		  		  			sock.send("${product.auction_max_price}")
		  		  		   location.href = "member_mypage_auctionList";
		  		  			}
		  		  		},
		  		  		fail: function() {
		  		  			alert("실패!");
		  		  		}	
		  		  		
		  		  	});
  		  			
  		  		},
  		  		fail: function() {
  		  			alert("실패!");
  		  		}	
  		  		
  		  	});
  			
  		},
  		fail: function() {
  			alert("실패!");
  		}	
  		
  	});
      
     
	
});

var sock = new SockJS('${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chatting?id=${param.id}');
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;

function sendMessage() {
	let bid_price=$("#bid_price").val();
	
// 	if(bid_price<=presentPrice){
// 		alert("현재 가격 보다 높은 금액으로 입찰 가능합니다.")
// 	}
	
	$.ajax({
		data: {
			'auction_idx':"${param.id}",
			'auction_log_bid': bid_price,
		},
		url: "logHistory",
		type: "POST",
		success: function(result) {
			if(result == "true") {
				sock.send(bid_price)
				
			}else if (result == "false") {
				alert("입찰가능금액이 부족합니다");
				
			}else if(result == "false3") {
				alert("현재가격 부터 입찰 가능합니다");
				
			}else if(result == "false4") {
				alert("현재가격 보다 높게 입찰 가능합니다");
				
			}else if(result == "false5") {
				alert("경매 종료");
				 location.reload();
				
			} else {
				alert("실패!");
			}
		},
		fail: function() {
			alert("실패!");
		}	
		
	});
	
}
//서버에서 메시지를 받았을 때
function onMessage(msg) {
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	var currentUsers=null;
	var arr = data.split(":");
	
	
	
	var cur_session = '${sessionScope.member_id}'; //현재 세션에 로그인 한 사람
	console.log("cur_session : " + cur_session);
	
	sessionId = arr[0];
	message = comma(arr[1]);
	currentUsers=arr[2];
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
    if(!message==""){
    	
	if(sessionId == cur_session){
		
		var str = "<div>";
		str += "<div class='alert alert-warning' style=' text-align: center;'>";
		str += "<b>" + sessionId + "님이 " + message + "원 입찰!</b>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	else{
		
		var str = "<div>";
		str += "<div class='alert alert-secondary' style=' text-align: center;'>";
		str += "<b>" + sessionId + "님이 " + message + "원 입찰!</b>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	$("#presentPrice").html(message);
	$('#auction_log').scrollTop($('#auction_log')[0].scrollHeight);
	$("#presentPrice").addClass('blink');
	   setTimeout(function() {
	      $("#presentPrice").removeClass('blink');
	   }.bind("#presentPrice"), 500);
	  
	  
	   if(message.replace(/,/g, '')=="${product.auction_max_price}"){
		   $("#clock").css("display", "none");
			$("#clockTitle").css("display", "none");
			$("#bottomRight").css("display", "none");
			$("#usersArea").css("display", "none");
			$("#presentPriceTitle").html("<b>최종낙찰가격</b>");
			
			var str = "<div  style=' text-align: center;'>";
			str += "<b> --------경매종료-------- </b>";
			str += "</div>";
			$("#msgArea").append(str);
			$('#auction_log').scrollTop($('#auction_log')[0].scrollHeight);
	   }
    }else{
    	if("${product.auction_manage_status}"=="경매종료"){return;}
    	$("#users").html(currentUsers.replace(/[\[\]']+/g, ''));
    	$("#currentUsersSum").html("<b>"+currentUsers.split(",").length+"</b>");
    	
    }
}
//채팅창에서 나갔을 때
function onClose(evt) {
	
	var user = '${sessionScope.member_id}';
// 	sock.send( "님이 퇴장하셨습니다.");
	
	
}
//채팅창에 들어왔을 때
function onOpen(evt) {}// 	sock.send( "님이 입장하셨습니다.");
	
	$(function(){
	if("${product.auction_manage_status}"=="경매종료"){
	$("#clock").css("display", "none");
	$("#clockTitle").css("display", "none");
	$("#bottomRight").css("display", "none");
	$("#usersArea").css("display", "none");
	$("#presentPriceTitle").html("<b>최종낙찰가격</b>");
	
	var str = "<div  style=' text-align: center;'>";
	str += "<b> --------경매종료-------- </b>";
	str += "</div>";
	}
	else{
	var user = '${sessionScope.member_id}';
	
	var str = "<div  style=' text-align: center;'>";
	
	str += "<b>" + user + "님 환영 합니다~ </b>";
	str += "</div>";
	}
	$("#msgArea").append(str);
	$('#auction_log').scrollTop($('#auction_log')[0].scrollHeight);
	});


</script>
</html>