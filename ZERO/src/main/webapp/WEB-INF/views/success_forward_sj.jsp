<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	// 요청 작업 성공 시 전달받은 메시지 출력 후 지정된 페이지로 포워딩
	alert("${msg}");
	
	if("${isClose}" == "true"){
		// 부모창의 페이지를 지정한 페이지(targetURL)로 포워딩 시키고, 자식창 닫기
		window.opener.location.href = "${targetURL}";	// window.opener : 자식창을 연 부모창
		window.close();
	}else {
		location.href = "${targetURL}";	
	}
	
</script>
</head>
<body>
</body>
</html>