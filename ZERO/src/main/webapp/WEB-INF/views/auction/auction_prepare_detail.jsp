<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title> ZERO | 경매예정상세 </title>
<script type="text/javascript">
$(function() {				
		$("#start_price").html(comma($("#start_price").html()));
		$("#max_price").html(comma($("#max_price").html()));
		
 		let datetime="${product.auction_start_datetime}";
 		let date=datetime.split('T')[0];
		
		let dDay = new Date(date);
		
		// D-Day까지 남은 시간 계산
		var timeDiff = new Date().getDate()-dDay.getDate();
		
		if(timeDiff==0){
			timeDiff=" day";
		}else if(timeDiff>0){
			timeDiff='+'+timeDiff
		}

		// D-Day까지 남은 일 수 표시
		$('#dDay').html('D' + timeDiff);
})


/* 실제 입력값을 변경해주는 함수 */
function comma(str) {
    str = String(str);
    
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}



</script>
<style type="text/css">
	.container-fluid{
	max-width: 1280px;
	}

	#center{
		
		position: relative;
		max-height: 300px;
		max-width: 500px;
		margin:auto;
	}
	
	#center #carouselExampleIndicators{
		max-height: inherit;
	}
	
	img {
      display: block;
   	  
   	  margin: auto;
      max-height: 300px;
      max-width: 500px;
      
    } 
	
	.column {
  float: left;
  width: 50%;
  padding: 10px;

}
	
	.carousel-control-next-icon, .carousel-control-prev-icon {
		background-color: #333;
	}
	

	@media only screen and (min-width: 768px) {
		body{
		margin-top: 86px!important;
		
	}
	#center{
		
		
		max-height: 380px;
		max-width: 1000px;
		
	}
	
	#center #carouselExampleIndicators{
		max-height: inherit;
	}
	
	img {
    
      max-height: 380px;
      max-width: 1000px;
      
    } 

	
		
	
	}
	
	.carousel-control-next-icon, .carousel-control-prev-icon {
		background-color: black;
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
		
			<div class="d-flex justify-content-center"><h2>${product.auction_title}</h2></div>
			
			
				<!-- 물품 이미지  -->
				<div id="center">
				<div id="carouselExampleIndicators" class="carousel slide-fluid" data-ride="carousel"  data-interval="false">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="${pageContext.request.contextPath }/resources/upload/${product.auction_image1}" alt="상품사진">
						</div> 
						<div class="carousel-item">
							<img src="${pageContext.request.contextPath }/resources/upload/${product.auction_image2}" alt="상품사진">
						</div>
						<div class="carousel-item">
							<img src="${pageContext.request.contextPath }/resources/upload/${product.auction_image3}" alt="상품사진">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				
				<div class=row>
					<div class="col-6 col-md-6">
						<br>
						<h2 style="display:inline;">경매 시작 가격</h2><span id="start_price">${product.auction_start_price}</span>원
						<br><br>
						<h2 style="display:inline;">즉시 구매 가격</h2><span id="max_price">${product.auction_max_price}</span>원
					</div>
					<div class="row col-6 col-md-6">
						<div class="column">
							<c:choose>
												<c:when test="${not empty member.member_image }">
													<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${member.member_image }" alt="사용자 이미지" class="thumb_img">
												</c:when>
												<c:otherwise>
													<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" alt="사용자 이미지" class="thumb_img">
												</c:otherwise>
											</c:choose>
						 </div>
						 <div class="column">
							<b><a href=""> ${member.member_nickname }</a></b>
						 	<br> ${member.member_intro }
						 </div>
					</div>
				</div>
				<div>
					<br><br>
					<h3>상세정보</h3>
					<hr>
					${product.auction_content  }
					
				</div>
				
				<br>
				<div class="d-flex justify-content-center">
				<h3 id=dDay></h3>
				</div>
				<div class="d-flex justify-content-center">
				
				<button type="button" class="btn btn-dark" onclick="history.back();">돌아가기</button>
				</div>
				<br><br><br><br><br><br>
			</div>
			
		
		</div>
	</section>
	
	<!-- footer -->
	<footer>
		
	</footer>
</body>
</html>