<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
@charset "UTF-8";

	#report_popup{
		width: 300px;
		height: 390px;
		
		position:absolute;
		
		z-index:890;
		
		
		padding: 10px;
		/* border: 2px solid black; */
		
		left: 400px; 
		top: 200px;
		
		 background-color : white;
		
		
		/* box-shadow: 2px 2px 3px black; */
		
		/* 나중에 수정해야함 none으로 */
		display: none;
		
	}
	
	#x_button{
		background: white;
		color: black;
		margin-bottom: 5px;
		font-size: 25px;
		
		vertical-align : top;
		
		border: none;
		
	}
	
	#popup_title {
		margin-bottom: 5px;
		font-size: 30px;
		font-family: 맑은굴림;
	}

	.report_box{
		
	
		display: inline-block;
		
		outline: 1px solid rgb(240,240,240);
		
		margin-bottom: 10px;
		
		width: 95%;
		height: 50px;
		
		vertical-align: middle;
		
		text-align: left;
		
	}
	
	/* 쉐도우 효과*/
	.shadow {
		position: fixed;
		left: 0;
		top: 0;
		background: rgba(0, 0, 0, 0.52);
		width: 100%;
		height: 100vh;
		display: none;
		z-index: 889;
	}
	
	input[name="report"]{
		margin-top: 20px;
		margin-left: 10px;
		margin-right: 5px;

	}
	
	.report_reason{
		font-family: 맑은굴림;
		font-size: 13px;
	}
</style>


</head>
<body>
	<div id="report_popup" align="center">
		
		<div style="text-align: right;">
			<input type="button" value="x" id="x_button"
				onclick="hide_report_popup();">
		</div>
		<span id="popup_title">신고사유</span>
		<div align="center" style="margin-bottom:10px; ">
			<div class="report_box">
				<input type="checkbox" value="re_add_cnt" name="report" onclick="doOpenCheck(this);">
				<span class="report_reason">1.광고</span>
			</div>
			<div class="report_box">
				<input type="checkbox" value="re_fake_cnt" name="report" onclick="doOpenCheck(this);">
				<span class="report_reason">2.가품 / 상품 부정확</span>
			</div>
			<div class="report_box">
				<input type="checkbox" value="re_inhibit_cnt" name="report" onclick="doOpenCheck(this);">
				<span class="report_reason">3.거래금지품목(담배/주류/음란물 등..)</span>
			</div>
				<div class="report_box">
					<input type="checkbox" value="re_scam_cnt" name="report" onclick="doOpenCheck(this);">
					<span class="report_reason">4.사기</span>
				</div>
		</div>
		
		<div align="center">
			<input class="btn" type="button" value="신고하기" onclick="send_report();">
			<input class="btn" type="button" value="취소" onclick="hide_report_popup();">
		</div>
	</div>
</body>
</html>