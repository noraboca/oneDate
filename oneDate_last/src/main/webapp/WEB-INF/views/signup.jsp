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
	
			checkGender();
			setBirthday();
			//setImage();

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
	            var str = year + "-" + month + "-" + day;
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

	        var btnArr = ["맛집 탐방", "전시회 관람", "반려동물과 산책", "동네 산책", "한강에서 치맥",
		                "쇼핑", "만화카페", "브런치", "요가/필라테스", "러닝", "여행", "영화 감상",
		                "골프", "아이돌 덕질", "새로운 것 배우기", "스포츠 관람", "피씨방", "심심할 때 수다",
		                "솔직한 대화", "커피 한 잔", "코노 메이트", "근교 드라이브", "술 한잔", "감성 카페투어"];
		
		    var hobby = $('#hobby').val();
		    var str = hobby.substring(0, hobby.length-3);
		    var arr = str.split(" / ");
		    var cnt = 0;
		
		    for(var i = 0; i < btnArr.length; i++) {
		        for(var j = 0; j < arr.length; j++){
		            if(btnArr[i] == arr[j]){
		                $(".interest_box").append('<input type="button" class="btn outline sel" style="background-color: #e33988; color: #fff;" value="' + btnArr[i] + '">');
		                i++;
		                cnt++;
		                $('#count').html(cnt);
		            } 
		        }
		        $(".interest_box").append('<input type="button" class="btn outline sel" value="' + btnArr[i] + '">');
		    }
		
		    $('.sel').on('click', function(){
		        var color = $(this).css('color');
		        if(cnt < 5){
		            if(color == "rgb(227, 57, 136)"){
		                var hobby = $('#hobby').val() + $(this).val() + " / ";
		                $(this).css({
		                    'background-color' : '#e33988',
		                    'color' : '#fff'
		                });
		                $('#hobby').val(hobby);
		                cnt++;
		                //alert("$(this):"+$(this).css("color"));
		                $('#count').html(cnt);
		            } else {
		                $(this).css({
		                    'background-color' : '#fff',
		                    'color' : '#e33988'
		                });
		                cnt--;
		                //alert("$(this):"+$(this).css("color"));
		                var str1 = $(this).val() + " / ";
		                var str2 = $('#hobby').val();
		                var str3 = str2.replace(str1, "");
		                $('#hobby').val(str3);
		                $('#count').html(cnt);
		            }
		        }
		        else if(cnt == 5 && color == "rgb(255, 255, 255)") {
		            $(this).css({
		                'background-color' : '#fff',
		                'color' : '#e33988'
		            });
		            cnt--;
		            //alert("$(this):"+$(this).css("color"));
		            var str1 = $(this).val() + " / ";
		            var str2 = $('#hobby').val();
		            var str3 = str2.replace(str1, "");
		            $('#hobby').val(str3);
		            $('#count').html(cnt);
		        }
		    });
	        
	        $('#imgInput1').on('change', function(e){
	            var fileReader = new FileReader();
	            fileReader.readAsDataURL(e.target.files[0]);
	            fileReader.onload = function(e) { 
	                //alert(e.target.result);
	                $(".img1").css("background-image", "url("+ e.target.result +")");
	            }
	        });

	        $('#imgInput2').on('change', function(e){
	            var fileReader = new FileReader();
	            fileReader.readAsDataURL(e.target.files[0]);
	            fileReader.onload = function(e) { 
	                //alert(e.target.result);
	                $(".img2").css("background-image", "url("+ e.target.result +")");
	            }
	        });

	        $('#imgInput3').on('change', function(e){
	            var fileReader = new FileReader();
	            fileReader.readAsDataURL(e.target.files[0]);
	            fileReader.onload = function(e) { 
	                //alert(e.target.result);
	                $(".img3").css("background-image", "url("+ e.target.result +")");
	            }
	        });

	        $('#imgInput4').on('change', function(e){
	            var fileReader = new FileReader();
	            fileReader.readAsDataURL(e.target.files[0]);
	            fileReader.onload = function(e) { 
	                //alert(e.target.result);
	                $(".img4").css("background-image", "url("+ e.target.result +")");
	            }
	        });
	
	    });
		///////////////////////////////////////////////////////////////////////////////
	    
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

	    function checkGender(){
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
	    	var str = $('#birth_day').val().substring(0, 10);
        	if(str != ""){
        		var year = str.substring(0, 4);
                var month = str.substring(4, 6);
                var day = str.substring(6, 8);
                $('#birth_y').val(year);
                $('#birth_m').val(month);
                $('#birth_d').val(day);
	       	}
	    }

	    function setImage(){

			var img1 = $("#getImg1").val();
			var img2 = $("#getImg2").val();
			var img3 = $("#getImg3").val();
			var img4 = $("#getImg4").val();
			
			if(img1 != "" && img1 != "(no files)"){
				$(".img1").css("background-image", "url('resources/upload/" + img1 + "')");
			} 
			if(img2 != "" && img2 != "(no files)"){
				$(".img2").css("background-image", "url('resources/upload/" + img2 + "')");
			} 
			if(img3 != "" && img3 != "(no files)"){
				$(".img3").css("background-image", "url('resources/upload/" + img3 + "')");
			} 
			if(img4 != "" && img4 != "(no files)"){
				$(".img4").css("background-image", "url('resources/upload/" + img4 + "')");
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
        <div class="popup p4">
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
                    <h1>OneDate에 오신 것을 환영합니다</h1>
                </div>
                <div class="join4_t1">
                    <span>아래의 이용 규정을 반드시 지켜 주세요.</span>
                </div>
                <div class="userInfo_text">
                    <div class="sub_t">          
                        <span style="font-weight: bold;">자신을 솔직하게 보여주기</span><br>
                        본인의 사진, 나이, 자기소개를 솔직하게 올려 주세요.
                    </div>
                    <div class="sub_t" >
                        <span style="font-weight: bold;">매너 있게 행동하기</span><br>
                        타인을 존중하고, 자신이 대우받고 싶은 대로 타인을 대하세요.
                    </div>
                    <div class="sub_t">
                        <span style="font-weight: bold;">항상 조심하기</span><br>
                        상대방을 잘 모르는 상태에서 개인 정보를 알려주지 마세요.
                    </div>
                    <div class="sub_t">
                        <span style="font-weight: bold;">적극적으로 행동하기</span><br>
                        잘못된 행동을 하는 사람이 있으면 반드시 신고해 주세요.
                    </div>
                </div>
                <button class="btn next n4" style="margin: 30px auto; width: 80px;">확인</button>
        </div>
        <div class="top">
            <h1><i class="fas fa-fire-alt logo-icon" style="font-size: 40px; margin-left: 50px;
                margin-right: 10px;"></i>
            <span style="font-size: 40px; margin-left: 10px;">OneDate</span></h1>
        </div>
        <div class="content">
        <form action="insert" method="post" enctype="multipart/form-data">
            <h1 style="text-align: center;">계정 만들기</h1>
            <span style="color: #e33988;">* 표시된 항목은 필수 항목입니다.</span>
            <div style="margin-top: 30px;">
                <div class="name">
                    <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
                    <span style="font-weight: bold; float: left;">이름</span><br/>
                    <div class="lb">
                        <i class="fas fa-user"></i>
                        <input type="text" id="user_name" name="name" value="${name}" maxlength="50" required>
                    </div>
                </div>
                <div class="gender">
                    <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
                    <span style="font-weight: bold; float: left;">성별</span><br/>
                    <div class="gender_box">
                        <input type="hidden" id="getGender" value="${gender }">
                        <input type="radio" id="male" name="gender" value="m" required>
                        <label for="male"></label>
                        <input type="radio" id="female" name="gender" value="f">
                        <label for="female"></label>
                    </div>
                </div>
            </div>
            <div style="margin-top: 30px;">
                <div class="id">
                    <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
                    <span style="font-weight: bold; float: left;">아이디</span><br/>
                    <div class="lb">
                        <i class="fas fa-portrait"></i>
                        <input type="text" id="user_id" name="id" maxlength="50" required>
                    </div>
                    <div class="message"><span id="msg3"></span></div>
                </div>
                <div class="password">
                    <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
                    <span style="font-weight: bold; float: left;">비밀번호</span><br/>
                    <div class="lb">
                        <i class="fas fa-unlock-alt"></i>
                        <input type="password" id="user_pw" name="password" value="${password}"
                        	maxlength="50" placeholder="영문, 숫자 포함 8자 이상" required>
                    </div>
                    <div class="message">
                        <span id="msg1" style="margin-top: 5px;"><a class="pw_toggle" 
                            style="cursor: pointer;">비밀번호 보기</a></span>
                    </div>
                    <div class="message"><span id="msg2"></span></div>
                </div>
            </div>
            <div>
                <div class="email">
                    <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
                    <span style="font-weight: bold; float: left;">이메일</span><br/>
                    <div class="lb">
                        <i class="fas fa-envelope"></i>
                        <input type="text" id="user_mail" name="email" value="${email}" readonly>
                    </div>
                </div>
                <div class="birthday">
                    <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
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
            <div style="margin-top: 30px;">
                <div class="phone">
                    <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
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
                    <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
                    <span style="font-weight: bold; float: left;">관심있는 성별</span><br/>
                    <div class="gender_box">
                        <input type="hidden" id="getGender2" value="${interested_gender }">
                        <input type="radio" id="male2" name="interested_gender" value="m" required>
                        <label for="male2"></label>
                        <input type="radio" id="female2" name="interested_gender" value="f">
                        <label for="female2"></label>
                    </div>
                </div>
            </div>
            <div style="text-align: left; margin-left: 40px;">
                <div class="address">
                    <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
                    <span style="font-weight: bold; float: left;">주소</span><br/>
                    <div class="lb">
                        <i class="fas fa-map-marker-alt"></i>
                        <input type="text" id="address" name="address" readonly required>
                        <button class="btn outline search" style="border-radius: 5px; margin-left:5px;" 
                        	onClick="goPopup();">주소 검색</button>
                        <!-- <i class="fas fa-search" style="font-size: 20px;"></i> -->
                    </div>
                </div>
            </div>
            <div style="text-align: left; margin-left: 40px;">
                <div class="details">
                    <span style="font-weight: bold; float: left;">자기소개</span><br/>
                    <div class="lb">
                        <textarea id="details" name="details" placeholder="자신을 간단히 소개해 주세요~" maxlength="200"></textarea>
                    </div>
                </div>
            </div>
            <div class="profile_img" style="text-align: left; margin-left: 70px; margin-top: 30px;">
                <span style="color: #e33988; float: left;">*&nbsp;&nbsp;</span>
                <span style="font-weight: bold; float: left;">프로필 사진 (1장 필수)</span><br/>
                <div class="img_box">
                    <div class="imgInput img1">
                        <input type="file" id="imgInput1" name="multipart" accept="image/*" required>
                        <label for="imgInput1"></label>
                    </div>
                    <div class="imgInput img2">
                        <input type="file" id="imgInput2" name="multipart" accept="image/*">
                        <label for="imgInput2"></label>
                    </div>
                    <div class="imgInput img3">
                        <input type="file" id="imgInput3" name="multipart" accept="image/*">
                        <label for="imgInput3"></label>
                    </div>
                    <div class="imgInput img4">
                        <input type="file" id="imgInput4" name="multipart" accept="image/*">
                        <label for="imgInput4"></label>
                    </div>
                </div>
            </div>
            <div class="hobby" style="text-align: left; margin-left: 70px; margin-top: 50px;">
                <span style="font-weight: bold; float: left;">취미</span><br/>
                <div class="lb" style="position: absolute;">
                    <input type="button" class="btn outline hb" style="border-radius: 5px;" value="+ 취미 추가">
                </div>
                <div class="str_box" style="display: none;">
                    <input type="text" id="hobby" name="hobby" 
                    	style="text-overflow: ellipsis;" maxlength="100" readonly>
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
                </div>
                <div style="margin-top: 25px;">
                    <button class="btn next n5">계속 (<span id="count">0</span>/<span id="max-count">5)</span></button>
                </div>
            </div>
            <div style="margin: 70px auto;">
                <input type="submit" class="btn save" style="width:100px;" value="확인">
                <div style="margin-top: 30px;">
                	<a href="${pageContext.request.contextPath}/login">
                	<span style="font-weight: bold;">이미 가입하셨다면? 로그인하세요.</span></a>
                </div>
            </div>
        </form>    
        </div>  
    </div>
    <div class="dim"></div>
</body>
</html>