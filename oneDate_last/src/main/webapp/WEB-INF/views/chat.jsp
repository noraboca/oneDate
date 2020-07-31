<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<link rel="stylesheet" href="resources/css/matchController.css">
<link rel="stylesheet"
	href="resources/font-awesome-4.7.0/css/font-awesome.min.css">


<!-- mobile -->
<link  rel="stylesheet" href="resources/jquery.mobile-1.4.5/jquery.mobile-1.4.5.min.css">

    <title>OneDate | 매치, 채팅, 디스커버리.</title>
<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/fire.png">

<script src="resources/jquery.mobile-1.4.5/demos/js/jquery.js"></script>
<script>
	
	$(document).on('mobileinit', function() {
		$.mobile.ignoreContentEnabled = true;
	});
	$(document).on('keypress',function(event){
	     if ( event.which == 13 ) {

	         $('#btnSend').click();
	     }
	});
</script>
<script src="resources/jquery.mobile-1.4.5/jquery.mobile-1.4.5.js"></script>
  

<script type="text/javascript">
	function select(params) {
		//	location.replace('toChat?receiver=' + id + '&name='+name);

		var form = document.createElement('form');

		form.setAttribute('method', 'post');

		form.setAttribute('action', 'toChat');

		document.charset = "utf-8";

		for ( var key in params) {

			var hiddenField = document.createElement('input');

			hiddenField.setAttribute('type', 'hidden');

			hiddenField.setAttribute('name', key);

			hiddenField.setAttribute('value', params[key]);

			form.appendChild(hiddenField);

		}

		document.body.appendChild(form);

		form.submit();

		document.getElementById(params['receiver']).className = "chat_list active_chat";
	}

	function exitChat() {
		location.replace('toMain?userId=${sender}');
	}

	function showProfile() {
		$(".mesgs").hide();
		$(".profile").show();
		$(".profile").css('width', '100%');
		$(".fa-chevron-circle-down").show();
		$(".fa-chevron-circle-down").css('position', 'relative');
		$(".fa-chevron-circle-down").css('top', '-30px');
		$(".fa-chevron-circle-down").css('left', '5px');
	}

	function closeProfile() {
		$(".mesgs").show();
		$(".profile").hide();
	}



	// chat_list chat_list active_chat,
</script>
<style type="text/css">
@media ( max-width :1501px) {
	.profile {
		display: none;
	}
	.mesgs {
		width: calc(100% - 300px);
	}
	@media ( max-width : 900px) {
		.inbox_people {
			display: none;
		}
		.mesgs {
			width: 100%;
		}
	}
}
</style>
</head>
<body data-enhance="false" style="animation: fadein 0.5s;" oncontextmenu="return false" ondragstart="return false"
	onselectstart="return false">

	<div class="container">

		<div class="messaging">
			<div class="inbox_msg">
				<div class="inbox_people">
					<div onclick="location.href = 'toProfile'" class="headind_srch">
						<img style="float: left; height: 40px; border-radius: 50px;"
							src="resources/client_img/${myInfo.main_photo_src}" alt="sunil">
						<h5 style="float: left; margin: 0 0 0 20px;">${myInfo.name}</h5>


					</div>
					<div class="chk_community">
						<p>다른사람들은 어떻게 대화를 나눌까요?
						<p />
						<h6 style="float: right;">
							<i class="fa fa-chevron-circle-right"></i>게시판 가기
						</h6>
					</div>

					<!--   -->
					<div class="inbox_chat">

						<c:forEach var="item" items="${matched_member_List}">

							<div class="chat_list" id="${item.id}"
								onClick="select({
										'sender' : '${sender}',
										'receiver':'${item.id}' 
										 });">
								<div class="chat_people">
									<div class="chat_img">
										<img style="height: 40px; border-radius: 50px;"
											src="resources/client_img/${item.main_photo_src}" alt="sunil">
									</div>
									<div class="chat_ib">
										<h5>
											${item.name} <span class="chat_date">${last_messagge_list.get(item.id).getTs()}</span>
										</h5>
										<p>
											${last_messagge_list.get(item.id).getText()}
											<c:if
												test="${last_messagge_list.get(item.id).getText() eq null}">
													먼저 대화를 시작해 보세요!
											</c:if>
											<c:if
												test="${last_messagge_list.get(item.id).getUser_receive() eq sender }">
												<i style="float: right; color: red;"
													class="fa fa-paper-plane"></i>
											</c:if>
										</p>
									</div>
								</div>
							</div>

						</c:forEach>

						<!-- 
						<div class="chat_list active_chat">
							<div class="chat_people">
								<div class="chat_img">
									<img src="https://ptetutorials.com/images/user-profile.png"
										alt="sunil">
								</div>
								<div class="chat_ib">
									<h5>
										Sunil Rajput <span class="chat_date">Dec 25</span>
									</h5>
									<p>Test, which is a new approach to have all solutions
										astrology under one roof.</p>
								</div>
							</div>
						</div>
						<div class="chat_list">
							<div class="chat_people">
								<div class="chat_img">
									<img src="https://ptetutorials.com/images/user-profile.png"
										alt="sunil">
								</div>
								<div class="chat_ib">
									<h5>
										Sunil Rajput <span class="chat_date">Dec 25</span>
									</h5>
									<p>Test, which is a new approach to have all solutions
										astrology under one roof.</p>
								</div>
							</div>
						</div>
						 -->

					</div>
				</div>

				<div class="mesgs">
					<div class="msg_header">
						<div onclick="showProfile()" class="incoming_msg_img">
							<img style="height: 40px; border-radius: 60px;"
								src="resources/client_img/${receiver_vo.main_photo_src}" alt="sunil">
						</div>
						<span style="margin: 2px; font-size: 23px;">${receiver_vo.name}</span>
						<div class="menu" onclick="exitChat();">
							<i class="fa fa-remove hover"></i>
						</div>
					</div>
					<div id="msg_history" class="msg_history">

						<div id="msgArea">
							<c:forEach var="item" items="${m_list}">

								<c:if test="${ item.user_send == sender}">
									<div class="outgoing_msg">
										<div class="sent_msg">
											<p>${item.text}</p>
											<span class="time_date"> ${item.ts}</span>
										</div>
									</div>
								</c:if>

								<c:if test="${ item.user_send == receiver}">
									<div class="incoming_msg">

										<div class="received_msg">
											<div class="received_withd_msg">
												<p>${item.text}</p>
												<span class="time_date"> ${item.ts}</span>
											</div>
										</div>

									</div>
								</c:if>
							</c:forEach>

						</div>

					</div>
					<div class="type_msg">
						<div class="input_msg_write">
							<input type="text" id="chatMsg" class="write_msg"
								placeholder="Type a message" name="text" /><br>

							<button class="msg_send_btn" id="btnSend" type="button">
								<i class="fa fa-paper-plane-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</div>
				<div class="profile">
					<div class="profile_img">
						<img class="user_img" src="resources/client_img/${receiver_vo.main_photo_src}">
						<i style="display: none; cursor: pointer;"
							onclick="closeProfile()" class="fa fa-chevron-circle-down fa-4x"></i>
					</div>
					<div class="profile_info">
						<div class="profile_name">
							<h3>${receiver_vo.name}
								<span class="profile_age">${receiver_age}</span>
							</h3>
						</div>

						<div class="profile_distance">
							<i class="fa fa-map-marker"></i> ${distance}
						</div>
					</div>
					<div class="profile_details">
						<p>${receiver_vo.details}</p>
					</div>
					<div class="profile_sub">
						<c:if test="${receiver_vo.sub1_photo_src != null}">
							<img class="user_img"
								src="resources/client_img/${receiver_vo.sub1_photo_src}">
						</c:if>
						<c:if test="${receiver_vo.sub2_photo_src != null}">
							<img class="user_img"
								src="resources/client_img/${receiver_vo.sub2_photo_src}">
						</c:if>
						<c:if test="${receiver_vo.sub3_photo_src != null}">
							<img class="user_img"
								src="resources/client_img/${receiver_vo.sub3_photo_src}">
						</c:if>
						<c:if test="${receiver_vo.sub4_photo_src != null}">
							<img class="user_img"
								src="resources/client_img/${receiver_vo.sub4_photo_src}">
						</c:if>

					</div>
				</div>

			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
var objDiv = document.getElementById("msg_history"); 
$(document).ready(function(){
	objDiv.scrollTop = objDiv.scrollHeight;
});
	let ws = new SockJS('http://localhost:8181/project/chat');
	var userid = '${param.id}';
	var bind;
	var getFrom;
	function connect() {

		ws.onopen = function() {
			console.log('연결 생성');
			register();
		};
		ws.onmessage = function(e) {
			var data = e.data;
			addMsg(data);
		};
		ws.onclose = function() {
			console.log('연결 끊김');
		};
	}

	function addMsg(msg) {// msg == "message"
		var str = msg.split(":");
		if (str[0] == "${receiver}") {
			var chat = $('#msgArea').val();
			var d = new Date();
			var now = d.getFullYear() + "-" + (d.getMonth() + 1) + "-"
					+ d.getDate() + " " + d.getHours() + ":" + d.getMinutes()
					+ ":" + d.getSeconds()

			chat = chat
					+ "<div class='incoming_msg'><div class='received_msg'><div class='received_withd_msg'><p>"
					+ str[1] + "</p><span class='time_date'> " + now
					+ "</span></div></div></div>"
			$('#msgArea').append(chat);
			
			objDiv.scrollTop = objDiv.scrollHeight;
		}
	}

	function register() {
		var msg = {
			type : "register",
			userid : "${sender}"
		};
		ws.send(JSON.stringify(msg));
	}

	function sendMsg() {

		var msg = {
			userid : "${sender}",
			type : "chat",
			target : "${receiver}",
			message : $("#chatMsg").val()
		};
		bind = msg.target;
		ws.send(JSON.stringify(msg));
	}

	$(function() {
		connect();
		$('#btnSend')
				.on("click",
						function() {
							var d = new Date();
							var now = d.getFullYear() + "-"
									+ (d.getMonth() + 1) + "-" + d.getDate()
									+ " " + d.getHours() + ":" + d.getMinutes()
									+ ":" + d.getSeconds()

							var chat = $("msgArea").val();

							chat = "<div class='outgoing_msg'><div class='sent_msg'><p>"
									+ $("#chatMsg").val()
									+ "</p><span class='time_date'> "
									+ now
									+ "</span></div></div>";

							$("#msgArea").append(chat);
							sendMsg();
							$("#chatMsg").val("");

							objDiv.scrollTop = objDiv.scrollHeight;
						})

	});
</script>


</html>