<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <!-- <script src="resources/js/losePw.js"></script> -->
    <title>OneDate | 매치, 채팅, 디스커버리.</title>
    <script type="text/javascript">
	    $(document).ready(function(){
	    	
	        btnDisabled();
	        
	        $(".input_id").on('input', check);
	        $(".input_email").on('input', check);
	        var toggleId = false;
	        var toggleMail = false;
	
	        function check() {
	            var id = $(".input_id").val();
	            var email = $(".input_email").val();
	            if(id.length > 0) {
	                toggleId = true;
	            } else {
	                toggleId = false;
	            }
	            if(email.length > 0) {
	                toggleMail = true;
	            } else {
	                toggleMail = false;
	            }
	            
	            optBtn();
	        }
	
	        function optBtn() {
	            if (toggleId == true && toggleMail == true) {
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
	
	        $(".input_code").on('input', checkP3);
	        var toggleCode = false;
	
	        function checkP3() {
	            var code = $(".input_code").val();
	            if(code.length > 0) {
	                toggleCode = true;
	            } else {
	                toggleCode = false;
	            }
	            
	            optBtnP3();
	        }
	
	        function optBtnP3() {
	            if (toggleCode == true) {
	                btnEnabled();
	            } else {
	                btnDisabled();
	            }
	        }
	
	        $('.next').on('click', function(){
	            codeCheck();
	        });
	          
	        $('.open').on('click', function(){
	            $('.click_pop').show();
	            return false;
	        });
	        
	        $(document).click(function(e){
	            if(e.target.className == "click_pop"){return false;}
	            $(".click_pop").hide();
	        });

	        var key = $('#key').val();
	        var testkey = "1111";
	        function codeCheck() {
	            var code = $(".input_code").val();
	            //alert(key);
	            if(key != code) {
	                btnDisabled();
	                $(".input_code").val('').focus();
	                alert('입력하신 코드가 정확하지 않습니다. 다시 시도해 주세요.');
	            }
	            //else {alert('인증 성공');}
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
        <h1>코드를 보내 드렸습니다</h1>
        <div class="email_val">
            <span id="email_val" style="font-weight: bold;">${email}</span> 인증을 위해 아래에 입력하세요.
        </div>
        <form action="userInfo" method="post">
        	<input type="hidden" id="key" value="${key }">
        	<input type="hidden" id="id" value="${id }">
        	<input type="hidden" id="email" value="${email }">
            <div class="code_box">
                <span id="text1">확인 코드</span><br/>
                <input type="text" class="input_code" name="code" autofocus><br/>
            </div>
            <div class="login_btn">
            	<input type="submit" class="btn next" value="다음"> 
            </div>
        </form>
        <form action="pwSendCode" method="post"> 
            <div id="bottom" style="margin-bottom: 50px;">
                <a class="open" style="cursor: pointer;">이메일을 받지 못하셨나요?</a>
	        	<input type="hidden" name="id" value="${id }">
	        	<input type="hidden" name="email" value="${email }">
                <table class="click_pop">
                    <tr>
                        <td class="td1">이메일을 받지 못하셨나요?</td>
                    </tr>
                    <tr>
                        <td class="td2"><input type="submit" value="이메일 다시 보내기" 
                            style="border:none; background-color: #fff; color:#e33988; 
                            font-size: 15px; text-decoration: underline;">
                        </td>
                    </tr>
                </table>
            </div>
        </form> 
    </div>
</body>
</html>