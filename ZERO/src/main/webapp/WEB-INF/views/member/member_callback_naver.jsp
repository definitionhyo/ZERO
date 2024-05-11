<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<script type="text/javascript">
//   var naver_id_login = new naver_id_login("lmCZvEMfrqOMLdWO1M_n", "http://localhost:8080/zero/callback_login_naver");
  var naver_id_login = new naver_id_login("lmCZvEMfrqOMLdWO1M_n", "http://c5d2302t1.itwillbs.com/ZERO/callback_login_naver");
  // 접근 토큰 값 출력
//   alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	console.log(naver_id_login);
//     alert(naver_id_login.getProfileData('email'));
//     alert(naver_id_login.getProfileData('name'));
    var member_id = naver_id_login.getProfileData('email');
    var member_name = naver_id_login.getProfileData('name');
    
    $.ajax({
        type: 'post',
//         url: 'checkUserNaver',
        url: 'ajax/checkUserNaver',
        data: {"member_id":member_id
        		, "member_name":member_name
        	},
        dataType: 'text',
        success: function(response) {
          console.log(response);
          if (response === 'new') {
//         	  sessionStorage.setItem('email', member_id);
        	  window.opener.location.href = 'join?member_id=' + member_id + '&member_name=' + member_name;
        	  alert(' 네이버 로그인 성공! 회원가입을 완료해주세요. ');
        	  window.close();

          }  else if (response === 'existing') { 
//         	  sessionStorage.removeItem("email");
//         	  sessionStorage.setItem('member_id', member_id);
        	  window.opener.location.href = './';
        	  alert(' 네이버 로그인 성공!')
        	  window.close();
          }
        },
        error: function(xhr, status, error) {
          console.log(error);
        }
    });
  }
</script>

</body>
</html>