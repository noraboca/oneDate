<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html data-enhance="false">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OneDate | 매치, 채팅, 디스커버리.</title>
<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/fire.png">
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
<link rel="stylesheet"
	href="resources/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/css/matchController.css">

<!-- mobile -->
<link  rel="stylesheet" href="resources/jquery.mobile-1.4.5/jquery.mobile-1.4.5.min.css">
<script src="resources/jquery.mobile-1.4.5/demos/js/jquery.js"></script>
<script>
	$(document).on('mobileinit', function() {
		$.mobile.ignoreContentEnabled = true;
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

</script>
<style type="text/css">
.mesgs {
	width: calc(100% - 300px);
}

.profile--cards {
	-webkit-box-flex: 1;
	flex-grow: 1;
	padding-top: 40px;
	display: -webkit-box;
	display: flex;
	-webkit-box-pack: center;
	justify-content: center;
	-webkit-box-align: end;
	align-items: flex-end;
	z-index: 1;
	height: 100vh;
}

.profile--card {
	position: absolute;
	top: calc(50% - 300px);
	left: calc(50% - 50px);
	box-shadow: 5px 5px 5px 5px grey;
	display: inline-block;
	width: 90vw;
	max-width: 400px;
	height: 70vh;
	background: #FFFFFF;
	padding-bottom: 40px;
	border-radius: 8px;
	overflow-y: auto;
	overflow-x: hidden;
	position: absolute;
	will-change: transform;
	-webkit-transition: all 0.3s ease-in-out;
	transition: all 0.3s ease-in-out;
	
	box-shadow: 5px 5px 5px 5px grey;
}

@media ( max-width : 940px) {
	
	.inbox_people {
		display: none;
	}
	.mesgs {
		width: 100vw;
		height: 95vh;
	}
	.mobile {
		display: block;
		width: 100%;
		border-bottom: 1px solid #eeeeee;
	}
	.Mnavbar {
		margin: 10px;
		display: flex;
	}
	span {
		flex: 1;
		text-align: center;
		cursor: pointer;
	}
	.profile--card {
		left: calc(50% - 250px);
		top: calc(50% - 350px);
		max-width: 500px;
		height: 80vh;
	}
}

</style>
</head>
<body style="animation: fadein 0.5s;" data-enhance="false" oncontextmenu="return false" ondragstart="return false"
	onselectstart="return false">
	<div class="container">
		<div class="messaging">
			<div class="inbox_msg">
				<div class="mobile">
					<nav class="Mnavbar">
						<span onclick="location.href = 'userInfo'"  > <i class="fa fa-cog fa-3x"></i>
						</span> <span  style="color: #e33988"> <i class="fa fa-3x fa-user"></i>
						</span> <span onclick="location.href ='toMain?userId=${sender}'">
							<i class="fa fa-3x fa-random"></i>
						</span>

					</nav>

				</div>
				<div class="inbox_people">
					<div onclick="location.href = 'userInfo'" class="headind_srch">
						<i class="fa fa-cog fa-3x"></i>
						<h4 style="float: left; margin: 0 0 0 20px;">내정보 수정</h4>
					</div>
					<div style="" onclick="location.href = 'toMain?userId=${sender}'" class="headind_srch">
					<i class="fa fa-arrow-right fa-3x"></i>
						<h4 style="float: left; margin: 0 0 0 20px;">돌아가기</h4>
						
					</div>
					<div class="chk_community">
						<p>다른사람들은 어떻게 대화를 나눌까요?
						<p />
						<h6 style="float: right;">
							<i class="fa fa-chevron-circle-right"></i>게시판 가기
						</h6>
					</div>

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


					</div>
				</div>
				<div class="profile mesgs">

					<div class="profile--cards">
						<div class="profile--card">

							<img class="user_img"
								src="resources/client_img/${myInfo.main_photo_src}">



							<h3>${myInfo.name}${age}</h3>

							<i class="fa fa-map-marker"> ${myInfo.address}</i>
							<p>${myInfo.details}</p>

							<c:if test="${myInfo.sub1_photo_src != null}">
								<img class="user_img"
									src="resources/client_img/${myInfo.sub1_photo_src}">
							</c:if>
							<c:if test="${myInfo.sub2_photo_src != null}">
								<img class="user_img"
									src="resources/client_img/${myInfo.sub2_photo_src}">
							</c:if>
							<c:if test="${myInfo.sub3_photo_src != null}">
								<img class="user_img"
									src="resources/client_img/${myInfo.sub3_photo_src}">
							</c:if>
							<c:if test="${myInfo.sub4_photo_src != null}">
								<img class="user_img"
									src="resources/client_img/${myInfo.sub4_photo_src}">
							</c:if>

						</div>


					</div>


				</div>
			</div>
		</div>
	</div>
</body>
</html>