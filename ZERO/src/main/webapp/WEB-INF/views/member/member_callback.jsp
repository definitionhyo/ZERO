<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<div id="g_id_onload"
     data-client_id="763453617602-e7goeun627q5nji64obqjr3ir1nc9rd7.apps.googleusercontent.com"
     data-callback="handleCredentialResponse">
</div>
<script src="https://unpkg.com/jwt-decode/build/jwt-decode.js"></script>
<script>
$(function(){
     console.log(${data});
     var data = '${data}';
     var parsedData = JSON.parse(data);
     var member_id = parsedData.email;
	 var member_name = parsedData.name;
	 var sns_type = 'google';
     console.log(member_id);
     console.log(member_name);
     
     $.ajax({
      type: 'post',
//          url: 'checkUserNaver',
      url: 'ajax/checkUser',
      data: {"member_id":member_id
      		, "member_name":member_name
      		, "sns_type":sns_type
      	},
      dataType: 'text',
      success: function(response) {
        console.log(response);
        if (response === 'new') {
//          	  sessionStorage.setItem('email', member_id);
      	  window.opener.location.href = 'join?member_id=' + member_id + '&member_name=' + member_name;
      	  alert('구글 로그인 성공! 회원가입을 완료해주세요. ');
      	  window.close();

        }  else if (response === 'existing') { 
//          	  sessionStorage.removeItem("email");
//          	  sessionStorage.setItem('member_id', member_id);
      	  window.opener.location.href = './';
      	  alert('구글 로그인 성공!')
      	  window.close();
        }
      },
      error: function(xhr, status, error) {
        console.log(error);
      }
  });
     
	
});

//   function handleCredentialResponse(response) {
//      // decodeJwtResponse() is a custom function defined by you
//      // to decode the credential response.
     
// 	 const responsePayload = parseJwt(response.credential);
	
// 	 console.log("ID: " + responsePayload.sub);
// 	 console.log('Full Name: ' + responsePayload.name);
// 	 console.log('Given Name: ' + responsePayload.given_name);
// 	 console.log('Family Name: ' + responsePayload.family_name);
// 	 console.log("Image URL: " + responsePayload.picture);
// 	 console.log("Email: " + responsePayload.email); 
//      var member_id = responsePayload.email;
//      var member_name = responsePayload.name;
//      var sns_type = 'google';
     
//      $.ajax({
//          type: 'post',
// //          url: 'checkUserNaver',
//          url: 'ajax/checkUser',
//          data: {"member_id":member_id
//          		, "member_name":member_name
//          		, "sns_type":sns_type
//          	},
//          dataType: 'text',
//          success: function(response) {
//            console.log(response);
//            if (response === 'new') {
// //          	  sessionStorage.setItem('email', member_id);
//          	  window.opener.location.href = 'join?member_id=' + member_id + '&member_name=' + member_name;
//          	  alert('구글 로그인 성공! 회원가입을 완료해주세요. ');
//          	  window.close();

//            }  else if (response === 'existing') { 
// //          	  sessionStorage.removeItem("email");
// //          	  sessionStorage.setItem('member_id', member_id);
//          	  window.opener.location.href = './';
//          	  alert('구글 로그인 성공!')
//          	  window.close();
//            }
//          },
//          error: function(xhr, status, error) {
//            console.log(error);
//          }
//      });
     
//   }
</script>
<script type="text/javascript">
// //   alert(naver_id_login.oauthParams.access_token);
//   // 네이버 사용자 프로필 조회
//   naver_id_login.get_naver_userprofile("naverSignInCallback()");
//   // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
//   function naverSignInCallback() {
// 	console.log(naver_id_login);
// //     alert(naver_id_login.getProfileData('email'));
// //     alert(naver_id_login.getProfileData('name'));
//     var member_id = naver_id_login.getProfileData('email');
//     var member_name = naver_id_login.getProfileData('name');
    
//     $.ajax({
//         type: 'post',
// //         url: 'checkUserNaver',
//         url: 'ajax/checkUserNaver',
//         data: {"member_id":member_id
//         		, "member_name":member_name
//         	},
//         dataType: 'text',
//         success: function(response) {
//           console.log(response);
//           if (response === 'new') {
// //         	  sessionStorage.setItem('email', member_id);
//         	  window.opener.location.href = 'join?member_id=' + member_id + '&member_name=' + member_name;
//         	  alert(' 네이버 로그인 성공! 회원가입을 완료해주세요. ');
//         	  window.close();

//           }  else if (response === 'existing') { 
// //         	  sessionStorage.removeItem("email");
// //         	  sessionStorage.setItem('member_id', member_id);
//         	  window.opener.location.href = './';
//         	  alert(' 네이버 로그인 성공!')
//         	  window.close();
//           }
//         },
//         error: function(xhr, status, error) {
//           console.log(error);
//         }
//     });
//   }
</script>

	<h1>구글 콜백 페이지</h1>
</body>
</html>