<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <!-- <script src="resources/js/login.js"></script> -->
    <title>OneDate | 매치, 채팅, 디스커버리.</title>
    <script type="text/javascript">
	    $(document).ready(function(){
	    	
	        btnDisabled();
	        
	        $(".input_id").on('input', check);
	        $(".input_pw").on('input', check);
	        var toggleId = false;
	        var togglePw = false;
	
	        function check() {
	            var id = $(".input_id").val();
	            var pw = $(".input_pw").val();
	            if(id.length > 0) {
	                toggleId = true;
	            } else {
	                toggleId = false;
	            }
	            if(pw.length > 0) {
	                togglePw = true;
	            } else {
	                togglePw = false;
	            }
	            
	            optBtn();
	        }
	
	        function optBtn() {
	            if (toggleId == true && togglePw == true) {
	                btnEnabled();
	            } else {
	                btnDisabled();
	            }
	        }
	
	        function btnDisabled() {
	            $(".btn").css('background-color', '#fce8f1');
	            $(".btn").attr('disabled', true);
	        }
	
	        function btnEnabled() {
	            $(".btn").css('background-color', '#e33988');
	            $(".btn").attr('disabled', false);
	        }
	        
	    });
	
	    function openWindow(url){
	        var popWidth = 500;  
	        var popHeight = 550;  
	        var left = Math.ceil((window.screen.width - popWidth)/2);
	        var top = Math.ceil((window.screen.height - popHeight)/2);
	        window.open(url, 'popup_test', 'top=' + top + ', left=' + left + 
	                ', height=' + popHeight + ', width=' + popWidth);
	    }
    		
    </script>
    
</head>

<body>
    <div class="container">
        <div class="head">
            <i class="fas fa-fire-alt logo-icon" style="font-size: 40px;"></i>
        </div>
        <h1>OneDate 로그인</h1>
        <form action="loginCheck" method="post">
            <div class="id_box">
                <span id="text1">이메일 또는 사용자 아이디</span><br/>
                <input type="text" class="input_id" name="emailOrId" autofocus><br/>
            </div>
            
            <div class="pw_box">
                <span id="text2">비밀번호</span><br/>
                <input type="password" class="input_pw" name="password"><br/>
            </div>
           	<div class="login_btn">
            	<input type="submit" class="btn" value="로그인">
            </div>
            <div id="bottom" style="margin-bottom: 15px;">
                <a href="${pageContext.request.contextPath}/losePw">비밀번호를 잊으셨나요?</a>
            </div>
            <div class="kakao" style="margin-bottom: 15px;">
	             <a href="#" onclick="location.href='${kakaoUrl }'">
	                 <img src="resources/images/login_kakao.jpg" width= 270px; height= 40px;></a>
	         </div>
	         <div class="naver">
	             <a href="#" onclick="location.href='${naverUrl }'">
	                 <img src="resources/images/login_naver.jpg" width= 270px; height= 40px;></a>
	         </div>
        </form>
    </div>
</body>
</html>
