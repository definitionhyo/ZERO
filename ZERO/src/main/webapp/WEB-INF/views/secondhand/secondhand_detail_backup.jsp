<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javascript">

let slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("demo");
  let captionText = document.getElementById("caption");
  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
  captionText.innerHTML = dots[slideIndex-1].alt;
}

</script>
<style>
#mainArticle {
	margin-top: 30px;
}
a {
	color:black;

}
/* Position the image container (needed to position the left and right arrows) */
.container {
  position: relative;
}

/* Hide the images by default */
.mySlides {
  display: none;
  padding-left:5px;
}
/* Add a pointer when hovering over the thumbnail images */
.cursor {
  cursor: pointer;
}

/* Next & previous buttons */
.prev,
.next {
  cursor: pointer;
  position: absolute;
  top: 40%;
  width: auto;
  padding: 15px;
  margin-top: -50px;
  color: white;
  font-weight: bold;
  font-size: 15px;
  border-radius: 0 3px 3px 0;
  user-select: none;
  -webkit-user-select: none;
}
/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Six columns side by side */
.column {
  float: left;


}

/* Add a transparency effect for thumnbail images */
.demo {
  opacity: 0.6;
}
.active,
.demo:hover {
  opacity: 1;



</style>
</head>
<body>


	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	

	<article id="mainArticle">
		<div class="container">
			<br><br><br><br><br>
			<hr>
		 <div class="mySlides">
		    <div class="numbertext">1 / 4</div>
		    <img src="${pageContext.request.contextPath }/resources/img/슬라이드1.jpg" style="width:300px; height:300px;">
		  </div>
		
		  <div class="mySlides">
		    <div class="numbertext">2 / 4</div>
		    <img src="${pageContext.request.contextPath }/resources/img/슬라이드2.jpg" style="width:300px; height:300px;">
		  </div>
		
		  <div class="mySlides">
		    <div class="numbertext">3 / 4</div>
		    <img src="${pageContext.request.contextPath }/resources/img/슬라이드3.jpg" style="width:300px; height:300px;">
		  </div>
		    
		  <div class="mySlides">
		    <div class="numbertext">4 / 4</div>
   			 <img src="${pageContext.request.contextPath }/resources/img/중고상품1.jpg" style="width:300px; height:300px;">
		  </div>
		
		<%-- 이미지전환<>버튼 --%>
		  <a class="prev" onclick="plusSlides(-1)">❮</a>
		  <a class="next" onclick="plusSlides(1)">❯</a>
		
		
		<%--썸네일이미지 --%>
		  <div class="row">
		    <div class="column">
		      <img class="demo cursor" src="${pageContext.request.contextPath }/resources/img/슬라이드1.jpg" style="width:100px; height:150px;" onclick="currentSlide(1)" alt="The Woods">
		    </div>
		    <div class="column">
		      <img class="demo cursor" src="${pageContext.request.contextPath }/resources/img/슬라이드2.jpg" style="width:100px; height:150px;" onclick="currentSlide(2)" alt="Cinque Terre">
		    </div>
		    <div class="column">
		      <img class="demo cursor" src="${pageContext.request.contextPath }/resources/img/슬라이드3.jpg" style="width:100px; height:150px;" onclick="currentSlide(3)" alt="Mountains and fjords">
		    </div>
		    <div class="column">
		      <img class="demo cursor" src="${pageContext.request.contextPath }/resources/img/중고상품1.jpg"  style="width:100px; height:150px;" onclick="currentSlide(4)" alt="Northern Lights">
		    </div>
		  </div>
			

		</div><%--container 끝 --%>
	</article>
	<footer></footer>
</body>

</html>