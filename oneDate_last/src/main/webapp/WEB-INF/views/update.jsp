<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/join.css">
    <link rel="stylesheet" href="resources/css/signup.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <!-- <script src="resources/js/signup.js"></script> -->
    <title>OneDate | 매치, 채팅, 디스커버리.</title>
    <script type="text/javascript">
	    $(document).ready(function(){
	
	//    	widnow.resizeTo(screen.availWidth, screen.availHeight);
	
			genderCheck();
			setBirthday();
	    	
	        $('.n4').on('click', function(){
	            $('.p4').hide();
	            $('.dim').hide();
	            return false;
	        });
	        
	        $('body').click(function(e){
	            if(!$('.popup').has(e.target).length){ 
	                $('.popup').hide();
	                $('.dim').hide();
	            }
	        });
	
	        $("#user_id").on('keyup', function(){
	            var id = $('#user_id').val();
	            if(chkId(id)) {	
	                $('#msg3').html("");
	                $.ajax({
	                    type: 'POST',
	                    url: 'checkId',
	                    data: {
	                        'id' : id
	                    },
	                    success: function(data){
	                        if($.trim(data) != 0){
	                            $('#msg3').css('color', '#e02460');
	                            $('#msg3').html("이미 등록된 아이디입니다.");
	                        }
	                        //$('#msg3').html("사용 가능한 아이디입니다.");
	                    }
	                });
	            } else {
	                $('#msg3').css('color', '#e02460');
	                $('#msg3').html("아이디는 영문으로 6자 이상이어야 합니다.");
	            }
	        });
	
	        $("#user_pw").on('keyup', function(){
	            var password = $('#user_pw').val();
	            if (chkPw(password)) {
	                $('#msg2').html("");
	            }
	            else {
	                $('#msg2').css('color', '#e02460');
	                $('#msg2').html("보안 수준이 더 강력한 비밀번호를 입력해주세요.");
	            }
	        });
	
	        $('.pw_toggle').on('click', function(){
	            $('input').toggleClass('active');
	            if ($('input').hasClass('active')) {
	                $('#user_pw').attr('type', 'text');
	                $(this).html("비밀번호 숨기기");
	            } else {
	                $('#user_pw').attr('type', 'password');
	                $(this).html("비밀번호 보기");
	            }
	        });

	        $('.birth').on('input', function(){
	            var year = $('#birth_y').val();
	            var month = $('#birth_m').val();
	            var day = $('#birth_d').val();
	            var month = (month.length == 1) ? "0" + month : month;
	            var day = (day.length == 1) ? "0" + day : day;
	            var str = year + month + day;
	            $('#birth_day').val(str);
	        });
	        
	        $("#chkSms").change(function(){
	            if($("#chkSms").is(":checked")){
	                $("#chkSms").val('1');
	            }else{
	                $("#chkSms").val('0');
	            }
	        });
	        
	        $('.hb').on('click', function(){
	            $('.p5').show();
	            $('.dim').show();
	            $('.str_box').show();
	            return false;
	        });
	
	        $('.n5').on('click', function(){
	            $('.p5').hide();
	            $('.dim').hide();
	            return false;
	        });
	
	        var i = 0;
	        $('.sel').on('click', function(){
	            var color = $(this).css('color');
	            if(i < 5){
	                if(color == "rgb(227, 57, 136)"){
	                    var interest = $('.interest').val() + $(this).val() + " / ";
	                    $(this).css({
	                        'background-color' : '#e33988',
	                        'color' : '#fff'
	                    });
	                    $('.interest').val(interest);
	                    i++;
	                    //alert("$(this):"+$(this).css("color"));
	                    $('#count').html(i);
	                } else {
	                    $(this).css({
	                        'background-color' : '#fff',
	                        'color' : '#e33988'
	                    });
	                    i--;
	                    //alert("$(this):"+$(this).css("color"));
	                    var str1 = $(this).val() + " / ";
	                    var str2 = $('.interest').val();
	                    var str3 = str2.replace(str1, "");
	                    $('.interest').val(str3);
	                    $('#count').html(i);
	                }
	            }
	            else if(i == 5 && color == "rgb(255, 255, 255)") {
	                $(this).css({
	                    'background-color' : '#fff',
	                    'color' : '#e33988'
	                });
	                i--;
	                //alert("$(this):"+$(this).css("color"));
	                var str1 = $(this).val() + " / ";
	                var str2 = $('.interest').val();
	                var str3 = str2.replace(str1, "");
	                $('.interest').val(str3);
	                $('#count').html(i);
	            }
	        });
	        
	        function readURL(input) {
	            if (input.files && input.files[0]) {
	                var reader = new FileReader();
	
	                reader.onload = function (e) {
	                    $('#img1').attr('src', e.target.result); 
	                }
	
	                reader.readAsDataURL(input.files[0]);
	            }
	        }
	        
	        $("#imgInput1").change(function(){
	            readURL(this);
	            $('.sec1').show();
	        });
	        $("#imgInput2").change(function(){
	            readURL(this);
	            $('.sec2').show();
	        });
	        $("#imgInput3").change(function(){
	            readURL(this);
	            $('.sec3').show();
	        });
	        $("#imgInput4").change(function(){
	            readURL(this);
	            $('.sec4').show();
	        });
	
	
	    function optBtn() {
	        if (toggleName == true && toggleId == true && 
	                togglePw == true && togglePhone == true) {
	            btnEnabled();
	        } else {
	            btnDisabled();
	        }
	    }
	
	    function btnDisabled() {
	        $(".save").css('background-color', '#fce8f1');
	        $(".save").attr('disabled', true);
	    }
	
	    function btnEnabled() {
	        $(".save").css('background-color', '#e33988');
	        $(".save").attr('disabled', false);
	    }
	
	    function chkId(id) {
	        var idReg = /^[A-za-z0-9]{6,15}/g;;
	        if (idReg.test(id)) return true;
	        else return false;
	    }
	
	    function chkPw(password) {
	        var pwReg = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$/;
	        if (pwReg.test(password)) return true;
	        else return false;
	    }

	    function genderCheck(){
			var gender = $('#getGender').val();
			var gender2 = $('#getGender2').val();

			if(gender == "male" || gender == "M"){
				$('#male').attr('checked', true);
			} else if(gender == "female" || gender == "F"){
				$('#female').attr('checked', true);
			}
			if(gender2 == "m"){
				$('#male2').attr('checked', true);
			} else if(gender2 == "f"){
				$('#female2').attr('checked', true);
			}
		}

	    function setBirthday(){
        	var str = $('#birth_day').val();
        	if(str != ""){
        		var year = str.substring(0, 4);
                var month = str.substring(4, 6);
                var day = str.substring(6, 8);
                $('#birth_y').val(year);
                $('#birth_m').val(month);
                $('#birth_d').val(day);
	       	}
	    }
	
	    function goPopup(){
	        // 주소검색을 수행할 팝업 페이지를 호출합니다.
	        // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	        var pop = window.open("resources/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	        
	        // 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	        //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	    }
	    function jusoCallBack(roadFullAddr){
	            // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.	
	            $('#address').val(roadFullAddr);		
	    }
	    
    </script>
    
</head>

<body>
    <div class="pContainer">
    
        <div class="top">
            <h1><i class="fas fa-fire-alt logo-icon" style="font-size: 40px; margin-left: 50px;
                margin-right: 10px;"></i>
            <span style="font-size: 40px; margin-left: 10px;">OneDate</span></h1>
        </div>
        <div class="content">
        <form action="insert" method="post" enctype="multipart/form-data">
            <h1 style="text-align: center;">계정 만들기</h1>
            <div>
                <div class="name">
                    <span style="font-weight: bold; float: left;">이름</span><br/>
                    <div class="lb">
                        <i class="fas fa-user"></i>
                        <input type="text" id="user_name" name="name" value="${vo.name}" maxlength="50" required>
                    </div>
                </div>
                <div class="gender">
                    <span style="font-weight: bold; float: left;">성별</span><br/>
                    <div class="gender_box">
                        <input type="hidden" id="getGender" value="${vo.gender}">
                        <input type="radio" id="male" name="gender" value="m">
                        <label for="male"></label>
                        <input type="radio" id="female" name="gender" value="f">
                        <label for="female"></label>
                    </div>
                </div>
            </div>
          
            <div>
                
                <div class="birthday">
                    <span style="font-weight: bold; float: left;">생일</span><br/>
                    <div class="lb">
                        <i class="fas fa-birthday-cake" style="margin-right: 5px;"></i>
                        <input type="number" class="birth" id="birth_y" placeholder="YYYY" maxlength="4" 
                            min="1970" max="2020" required>
                        <input type="number" class="birth" id="birth_m" placeholder="MM" maxlength="2" 
                            min="1" max="12" required>
                        <input type="number" class="birth" id="birth_d" placeholder="DD" maxlength="2" 
                            min="1" max="31" required>
                        <input type="hidden" id="birth_day" name="birth_day">
                    </div>
                </div>
            </div>
            <div>
                <div class="phone">
                    <span style="font-weight: bold; float: left;">휴대폰</span><br/>
                    <div class="lb">
                        <i class="fas fa-mobile-alt"></i>
                        <input type="text" id="phone" name="phone" maxlength="11"
                            placeholder="' - '를 제외한 숫자만 입력" required>
                            <div class="sms">
                                <div class="chk_box" style="margin-left: 5px;">
                                    <input type="checkbox" id="chkSms" name="sms" value="0"> 
                                    <label for="chkSms"></label>
                                </div>
                                <span style="font-size: 12px;">(선택) 새로운 매칭 연결시 알림 SMS 수신에 동의합니다.</span>
                            </div>
                    </div>
                </div>
                <div class="gender">
                    <span style="font-weight: bold; float: left;">관심있는 성별</span><br/>
                    <div class="gender_box">
                        <input type="hidden" id="getGender2" value="${interested_gender }">
                        <input type="radio" id="male2" name="interested_gender" value="m">
                        <label for="male2"></label>
                        <input type="radio" id="female2" name="interested_gender" value="f">
                        <label for="female2"></label>
                    </div>
                </div>
            </div>
            <div>
                <div class="address">
                    <span style="font-weight: bold; float: left;">주소</span><br/>
                    <div class="lb">
                        <i class="fas fa-map-marker-alt"></i>
                        <input type="text" id="address" name="address" required readonly>
                        <button class="btn outline search" style="border-radius: 5px; margin-left:5px;" 
                        	onClick="goPopup();">주소 검색</button>
                        <!-- <i class="fas fa-search" style="font-size: 20px;"></i> -->
                    </div>
                </div>
            </div>
            <div>
                <div class="details">
                    <span style="font-weight: bold; float: left;">자기소개</span><br/>
                    <div class="lb">
                        <textarea id="details" name="details" placeholder="자신을 간단히 소개해 주세요~" maxlength="200"></textarea>
                    </div>
                </div>
            </div>
            <div class="profile_image">
                <span style="font-weight: bold; float: left;">프로필 사진 (최대 4장)</span><br/>
                <div class="lb">
                    <div class="imgInput ip1">
                        <input type="file" id="imgInput1" name="multipart" accept="image/*" required>
                        <label for="imgInput1"></label>
                    </div>
                    <div class="imgInput ip2"><input type="file" id="imgInput2" name="multipart" accept="image/*"></div>
                    <div class="imgInput ip3"><input type="file" id="imgInput3" name="multipart" accept="image/*"></div>
                    <div class="imgInput ip4"><input type="file" id="imgInput4" name="multipart" accept="image/*"></div>
                </div>
                <!-- <div class="img_flex">
                    <div class="img_section sec1">
                        <img id="img1" src="#"/>
                    </div>
                    <div class="img_section sec2">
                        <img id="img2" src="#"/>
                    </div>
                    <div class="img_section sec3">
                        <img id="img3" src="#"/>
                    </div>
                    <div class="img_section sec4">
                        <img id="img4" src="#"/>
                    </div>
                </div> -->
            </div>
            <div class="hobby">
                <span style="font-weight: bold; float: left;">취미</span><br/>
                <div class="lb">
                    <input type="button" class="btn outline hb" style="border-radius: 5px;" value="+ 취미 추가">
                </div>
                <div class="str_box" style="display: none;">
                    <input type="text" class="interest" name="hobby" maxlength="100" readonly>
                </div>
            </div>
            <div class="popup p5" style="display: none;">
                <div class="head">
                    <div class="hd1">
                        <button class="back_btn" onclick="history.go(-1);" style="display: none;">
                            <div class="arrow left"></div>
                        </button>
                    </div>
                    <div class="hd2"><i class="fas fa-fire-alt logo-icon"></i></div>
                    <div class="hd3"><input type="button" class="btn next" value="다음" style="display: none;"></div>
                </div>
                <div class="title">
                    <h1>무엇에 관심을 갖고 계신가요?</h1>
                </div>
                <div class="join4_t1" style="width: 440px; letter-spacing: 0.3px;">
                    <span>OneDate에서 발견한 친구와 공유하고 싶은 취미가 있나요? 선택하여 프로필에 공유해 주세요!</span>
                </div>
                    <div class="interest_box" style="margin-left: 28px; margin-top: 20px; width: 450px;">
                        <input type="button" class="btn outline sel" value="맛집 탐방">
                        <input type="button" class="btn outline sel" value="전시회 관람">
                        <input type="button" class="btn outline sel" value="반려동물과 산책">
                        <input type="button" class="btn outline sel" value="동네 산책">
                        <input type="button" class="btn outline sel" value="한강에서 치맥">
                        <input type="button" class="btn outline sel" value="쇼핑">
                        <input type="button" class="btn outline sel" value="만화카페">
                        <input type="button" class="btn outline sel" value="브런치">
                        <input type="button" class="btn outline sel" value="요가/필라테스">
                        <input type="button" class="btn outline sel" value="러닝">
                        <input type="button" class="btn outline sel" value="여행">
                        <input type="button" class="btn outline sel" value="영화 감상">
                        <input type="button" class="btn outline sel" value="골프">
                        <input type="button" class="btn outline sel" value="아이돌 덕질">
                        <input type="button" class="btn outline sel" value="새로운 것 배우기">
                        <input type="button" class="btn outline sel" value="스포츠 경기 관람">
                        <input type="button" class="btn outline sel" value="피씨방">
                        <input type="button" class="btn outline sel" value="심심할 때 수다">
                        <input type="button" class="btn outline sel" value="솔직한 대화">
                        <input type="button" class="btn outline sel" value="커피 한 잔">
                        <input type="button" class="btn outline sel" value="코노 메이트">
                        <input type="button" class="btn outline sel" value="근교 드라이브">
                        <input type="button" class="btn outline sel" value="술 한잔">
                        <input type="button" class="btn outline sel" value="감성 카페투어">
                </div>
                <div style="margin-top: 25px;">
                    <button class="btn next n5">계속 (<span id="count">0</span>/<span id="max-count">5)</span></button>
                </div>
            </div>
            <div style="margin-top: 40px; margin-bottom: 50px;">
                <input type="submit" class="btn save" style="width:100px;" value="확인">
                <a class="btn save">취소</a>
                <div style="margin-top: 30px;">
                	<a href="${pageContext.request.contextPath}/login">
                	<span style="font-weight: bold;">이미 가입하셨다면? 로그인하세요.</span></a>
                </div>
            </div>
        </form>    
        </div>  
    </div>
    
</body>
</html>