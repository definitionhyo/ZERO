<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZERO</title>
<script type="text/javascript">
	// 요청 작업 실패 시 전달받은 오류 메시지 출력 후 
	// isClose 속성갑이 true일 경우 현재창 닫기, 아니면 이전페이지로 돌아가기
	// 주의! 자바스크립트에서 속성값 비교 시 true, false 대신 "true", "false" 사용
	alert("${msg}");
	if(${isClose} == "true"){
		window.close();
	}else {
		history.back();		
	}
</script>
</head>
<body>
</body>
</html>