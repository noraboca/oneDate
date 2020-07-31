<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/app.css">
    <link rel="stylesheet" href="resources/css/join.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <!-- <script src="resources/js/index.js"></script> -->
    <title>OneDate | 매치, 채팅, 디스커버리.</title>
    <script type="text/javascript">
    
    	$(document).ready(function(){

        ////////////////////////////////// start - INDEX /////////////////////////////////
            var imgArr = ['resources/images/2.jpg', 'resources/images/3.jpg', 
                'resources/images/4.jpeg', 'resources/images/1.jpg'];
            var i = 0;
            setInterval(function() {
                $(".container").css("background-image", "url(" + imgArr[i] + ")");
                i++;
                if(i >= imgArr.length){i = 0;}
            }, 3000);

            $('input').keydown(function(){
                if(event.keyCode === 13){
                    event.preventDefault();
                }
            });
            
            $('.signup').on('click', function(){
                $('.p1').show();
                $('.dim').show();
                btnDisabled();
                return false;
            });
            
            $('body').click(function(e){
                if(!$('.pContainer').has(e.target).length){ 
                    $('.popup').hide();
                    $('.dim').hide();
                }
            });
            
            // $('.close_btn').on('click', function(){
            //     $('.popup').hide();
            //     $('.dim').hide();
            //     return false;
            // });
            
            function btnDisabled() {
                $(".btn").css('background-color', '#fce8f1');
                $(".btn").attr('disabled', true);
            }
        
            function btnEnabled() {
                $(".btn").css('background-color', '#e33988');
                $(".btn").attr('disabled', false);
            }
            
        ////////////////////////////////// end - INDEX /////////////////////////////////
            
            
        ///////////////////////////////// start - popup1 ///////////////////////////////
            
            $('.n1').on('click', function(){
            	if(formSubmit() == false){
					return false;
                }
                $('.p1').hide();
                $('.p2').show();
                btnDisabled();
                //return false;
            });

            $("#user_name").on('input', checkP1);
            $("#user_mail").on('input', checkP1);
            var toggleName = false;
            var toggleMail = false;

            function checkP1() {
                var name = $("#user_name").val();
                var email = $("#user_mail").val();
                if(name.length > 0) {
                    toggleName = true;
                } else {
                    toggleName = false;
                }
                if(chkEmail(email)) {
                    toggleMail = true;
                } else {
                    toggleMail = false;
                }
                
                optBtnP1();
            }

            $("#user_name").on('keyup', function(){
                var name = $('#user_name').val();
                $('#count').html(name.length);
                if(name.length > 50) {
                    $(this).val(name.substring(0, 50));
                    $('#count').html("50");
                }
                else if($.trim(name).length == 0) {
                    $('#text1').css('color', '#e02460');
                    $('#msg1').css('color', '#e02460');
                    $('#msg1').html("이름을 입력해 주세요.");
                }
                else if($.trim(name).length > 0) {
                    $('#text1').css({ color: '#657685' });
                    $('#msg1').html("");
                } 
            });

            $("#user_mail").on('keyup', function(){
                var email = $('#user_mail').val();
                if(chkEmail(email)) {	
                    $('#msg2').html("");
                    $('#text2').css('color', '#657685');		
                    $.ajax({
                        type: 'POST',
                        url: 'checkEmail',
                        data: {
                            'email' : email
                        },
                        success: function(data){
                            if($.trim(data) != 0){
                                $('#text2').css('color', '#e02460');
                                $('#msg2').css('color', '#e02460');
                                $('#msg2').html("이미 등록된 이메일입니다.");
                                btnDisabled();
                            }
                        }
                    });

                } else if($.trim(email).length == 0) {
                    $('#user_mail').focus();
                    $('#text2').css({ color: '#657685' });
                    $('#msg2').html("");
                    btnDisabled();
                } else {
                    $('#text2').css('color', '#e02460');
                    $('#msg2').css('color', '#e02460');
                    $('#msg2').html("올바른 이메일을 입력해 주세요.");
                    btnDisabled();
                }
            });

            function chkEmail(email) {
                var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;      
                if (regExp.test(email)) { return true; }
                else { return false; }
            }
            
            function optBtnP1() {
                if (toggleName == true && toggleMail == true) {
                    btnEnabled();
                } else {
                    btnDisabled();
                }
            }

        //////////////////////////////// end - popup1 ///////////////////////////////
            
            
        //////////////////////////////// start - popup2 ///////////////////////////////
            
            $('.join').on('click', function(){
                $('.p2').hide();
                $('.p3').show();
                btnDisabled();
                sendCode();
                var email = $('#user_mail').val();
                $("#email_val").html(email);
                //return false;
            });

            $('input:checkbox[name="chk"]').on('click',function(){
                var checkCoutn = $('input:checkbox[name="chk"]:checked').length;
                if(checkCoutn == 4){
                    btnEnabled();
                } else{
                    btnDisabled();
                }
            });

        //////////////////////////////// end - popup2 ///////////////////////////////
            
            
        //////////////////////////////// start - popup3 ///////////////////////////////
            
            var email = $('#user_mail').val();
            $("#email_val").html(email);
            
            $("#email_code").on('input', checkP3);
            var toggleCode = false;
        
            function checkP3() {
                var code = $("#email_code").val();
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

            $('.err').hide();
            $('.n3').on('click', function(){
                codeCheck();
            });
             
            var testkey = "1111";
            function codeCheck() {
               var code = $("#email_code").val();
               var key = $('#key').val();		
               if(key != code) {
                   btnDisabled();
                   $("#email_code").val('').focus();
                   $('.err').show();
                   setTimeout(function() {
                       $('.err').hide();
                   }, 3000);
               }
               //else {alert('인증 성공');}
            } 
             
            $('.open').on('click', function(){
                $('.click_pop').show();
                return false;
            });
            
            $(document).click(function(e){
                if(e.target.className == "click_pop"){return false;}
                $(".click_pop").hide();
            });

            
        //////////////////////////////// end - popup3 ///////////////////////////////

        }); // end - $(document).ready

        function openWindow(url){
            var popWidth = 500;  
            var popHeight = 550;  
            var left = Math.ceil((window.screen.width - popWidth)/2);
            var top = Math.ceil((window.screen.height - popHeight)/2);
            window.open(url, 'popup_test', 'top=' + top + ', left=' + left + 
                    ', height=' + popHeight + ', width=' + popWidth);
        }
        
        function sendCode(){
            var email = $('#user_mail').val();
            $.ajax({
                type: 'POST',
                url: 'sendCode',
                data: {
                    'email' : email
                },
                success: function(data){
                    //alert(data);
                    $('#key').val(data);
                }
            });
        }
        
        function emailModify(){
            $('.p3').hide();
            $('.p1').show();
        }

        function formSubmit() {
            if (grecaptcha.getResponse() == ""){
                alert("자동등록 방지에 체크해 주세요.");
                return false;
            } else {
                return true;
            }
        }
        
    </script>
</head>

<body>
    <div class="container">
        <div class="top-box">
            <h1>
                <i class="fas fa-fire-alt icon" style="font-size: 40px; margin-left: 50px;
                    margin-top: 7px; color: #fff;"></i>
                <span style="font-size: 40px; color: #fff;">OneDate</span>	
            </h1>
            <!-- <form> -->
                <button class="mbtn outline" onclick="location.href='login'"
                    style="position: absolute; top: 23px; right: 80px; width: 100px;">로그인</button>
        	<!--</form>-->
        </div>
        <div class="middle-box">
            <div class="card">
                <h1>매치. 채팅. 디스커버리</h1><br>
                <div class="dd" style="max-width: 580px; color: #fff; text-align: center; margin: 0 auto 10px;">
                    ‘<span class="tt">회원 가입</span>’(을)를 클릭함으로써 OneDate 
                    <a class="aa" href="#" target="_blank" 
                    rel="noopener noreferrer" aria-describedby="open-in-new-window">
                  	이용약관</a>에 동의합니다. 당사에서 개인정보를 처리하는 방식은 <a class="aa" 
                    href="#" target="_blank" rel="noopener noreferrer" 
                    aria-describedby="open-in-new-window">개인정보 취급방침</a>과 
                    <a class="cc" href="#" target="_blank" 
                    rel="noopener noreferrer" aria-describedby="open-in-new-window">
                   	 쿠키 정책</a>에서 확인하시기 바랍니다.
                </div>
                <!-- <form> -->
                    <button class="mbtn primary block signup" style="width: 300px; 
                        margin: 20px auto 0; line-height: 24px;">회원가입
                    </button>
                <!-- </form> -->
            </div>
        </div>
    </div>
    <div class="pContainer">
    <form action="signup" method="post">
        <div class="popup p1" style="display: none;">
            <div class="head">
                <div class="hd1">
                    <button class="back_btn" onclick="history.go(-1);" style="display: none;">
                        <div class="arrow left"></div>
                    </button>
                </div>
                <div class="hd2"><i class="fas fa-fire-alt logo-icon"></i></div>
                <div class="hd3"><input type="button" class="btn next n1" value="다음"></div>
                <!-- <button class="close_btn" ><i class="far fa-times-circle"></i></button> -->
            </div>
            <div class="title">
                <h1>계정을 생성하세요</h1>
            </div>
            <div class="input_box">
                <span id="text1">이름</span><br/>
                <input type="text" id="user_name" name="name" maxlength="50" autofocus><br/>
                <div class="message"><span id="msg1"></span><span id="count">0</span>/<span id="max-count">50</span></div>
            </div>
            <div class="input_box">
                <span id="text2">이메일</span><br/>
                <input type="text" id="user_mail" name="email"><br/>
                <div class="message"><span id="msg2"></span></div>
            </div>
        
	         <div class="g-recaptcha" style="display: inline-block; margin-bottom: 20px;" 
	         	data-sitekey="${googleSiteKey }">
	         </div>
	         <div class="kakao" style="margin-bottom: 15px;">
	             <a href="#" onclick="location.href='${kakaoUrl }'">
	                 <img src="resources/images/login_kakao.jpg" width= 270px; height= 40px;></a>
	         </div>
	         <div class="naver">
	             <a href="#" onclick="location.href='${naverUrl }'">
	                 <img src="resources/images/login_naver.jpg" width= 270px; height= 40px;></a>
	         </div>
        </div>
        <div class="popup p2" style="display: none;">
            <div class="head">
                <div class="hd1">
                    <button class="back_btn" onclick="history.go(-1);" style="display: none;">
                        <div class="arrow left"></div>
                    </button>
                </div>
                <div class="hd2"><i class="fas fa-fire-alt logo-icon"></i></div>
                <div class="hd3"><input type="button" class="btn next n2" value="다음" style="display: none;"></div>
                <!-- <i class="far fa-times-circle close_btn" onclick="window.close();"></i> -->
            </div>
            <div class="title">
                <h1>이용약관</h1>
            </div>
            <div class="join2_t1">
                OneDate를 이용하시기 전에 이용약관을 검토하시기 바랍니다. <br>스와이프를 계속하기 위해서는 이용약관을 반드시 준수해야 합니다.
            </div>
            <div class="join2_box">
                <div class="chk_box">
                    <input type="checkbox" id="chk1" name="chk" value="agree1"> 
                    <label for="chk1"></label>
                </div>
                <div class="join2_text">(필수)개인정보(위치정보 포함)의 수집 및 이용에 동의합니다.</div>
            </div>
            <div class="join2_box">
                <div class="chk_box">
                    <input type="checkbox" id="chk2" name="chk" value="agree2">
                    <label for="chk2"></label>
                </div>
                <div class="join2_text">(필수)위치기반서비스 이용약관에 동의 합니다.</div>
            </div>
            <div class="join2_box">
                <div class="chk_box">
                    <input type="checkbox" id="chk3" name="chk" value="agree3">
                    <label for="chk3"></label>
                </div>
                <div class="join2_text">(필수)이용약관에 동의합니다.</div>
            </div>
            <div class="join2_box">
                <div class="chk_box">
                    <input type="checkbox" id="chk4" name="chk" value="agree4">
                    <label for="chk4"></label>
                </div>
                <div class="join2_text">(필수)개인정보의 제3자 제공에 동의합니다.</div>
            </div>
            <div class="join2_t1">
                '가입'을 누르시면 입력하신 이메일로 인증 코드를 보내 드립니다.
            </div>
            <input type="button" class="btn join" value="가입">
        </div>
        <div class="popup p3" style="display: none;">
            <div class="head">
                <div class="hd1">
                    <button class="back_btn" onclick="history.go(-1);" style="display: none;">
                        <div class="arrow left"></div>
                    </button>
                </div>
                <div class="hd2"><i class="fas fa-fire-alt logo-icon"></i></div>
                <div class="hd3"><input type="submit" class="btn next n3" value="다음"></div>
            </div>
            <div class="title">
                <h1>코드를 보내 드렸습니다</h1>
            </div>
            <div class="join4_t1">
                <span id="email_val" style="font-weight: bold;">// 이메일주소 값 //</span> 인증을 위해 아래에 입력하세요.
            </div>
            <input type="hidden" id="key" value="${key }">
            <div class="input_box code">
                <span id="text1">확인 코드</span><br/>
                <input type="text" id="email_code" name="emial_code" autofocus><br/>
                <div class="message">
                    <span id="msg1"><a class="open" style="cursor: pointer;">이메일을 받지 못하셨나요?</a></span>
                </div>
            </div>
            <div>
                <table class="click_pop">
                    <tr>
                        <td class="td1">이메일을 받지 못하셨나요?</td>
                    </tr>
                    <tr>
                        <td class="td2"><a href="#" onclick="sendCode();">이메일 다시 보내기</a></td>
                    </tr>
                    <tr>
                        <td class="td2"><a href="#" onclick="emailModify();">이메일 주소 수정하기</a></td>
                    </tr>
                </table>
            </div>
            
            <div class="err"><span>입력하신 코드가 정확하지 않습니다. 다시 시도해 주세요.</span></div>
        </div>
	</form> 
    </div>
    <div class="dim" style="display:none;"></div>

</body>
</html>