<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html data-enhance="false" lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
	
<script type="text/javascript" src="resources/js/hammer.js"></script>

<!-- alert -->
<script type="text/javascript" src="resources/js/sweetalert2.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>


<!-- mobile -->
<link  rel="stylesheet" href="resources/jquery.mobile-1.4.5/jquery.mobile-1.4.5.min.css">
<script src="resources/jquery.mobile-1.4.5/demos/js/jquery.js"></script>
<script>
	$(document).on('mobileinit', function() {
		$.mobile.ignoreContentEnabled = true;
	});
</script>
<script src="resources/jquery.mobile-1.4.5/jquery.mobile-1.4.5.js"></script>
  

<link rel="stylesheet"
	href="resources/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/css/mainView.css">
<link rel="stylesheet" href="resources/css/matchController.css">

<style type="text/css">
.inbox_people {
	position: absolute;
	z-index: 6;
}

.mesgs {
	width: 120%;
	position: absolute;
}

@media ( max-width : 940px) {
	.inbox_people {
		display: none;
	}
	.mesgs {
		width: 100vw;
		height: 90vh;
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
	.tinder--card {
		max-width: 500px;
		height: 75vh;
		z-index: 6;
	}
}
</style>

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
	

	// for slide
</script>
</head>
<body style="animation: fadein 0.5s;" oncontextmenu="return false" ondragstart="return false"
	onselectstart="return false">

	<div data-enhance="false" class="container">

		<div class="messaging">
			<div data-enhance="false" class="inbox_msg">
				<div class="mobile">
					<nav class="Mnavbar">
						<!-- location.href = 'toProfile' -->
						<span onclick="location.href ='toProfile' "><i
							class="fa fa-3x fa-user"></i></span> <span style="color: #e33988"><i
							class="fa fa-3x fa-random"></i></span> <span
							onclick="location.href = 'matches?userId=${sender}'"><i
							class="fa fa-3x fa-comments"></i></span>

					</nav>
				</div>

				<div data-enhance="false" class="inbox_people">
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




				<div class="tinder mesgs">
					<div class="tinder--status">
						<i class="fa fa-remove"></i> <i class="fa fa-heart"></i>
					</div>

					<div class="tinder--cards">
						<c:forEach var="item" items="${candidate_list}">
							<div id="${item.idx}" class="tinder--card">

								<img class="user_img"
									src="resources/client_img/${item.main_photo_src}">



								<h3>${item.name}${age_Location_map.get(item.id).getAge()}</h3>

								<i class="fa fa-map-marker">
									${age_Location_map.get(item.id).getDistance()}km</i>
								<p>${item.details}</p>

								<c:if test="${item.sub1_photo_src != null}">
									<img class="user_img"
										src="resources/client_img/${item.sub1_photo_src}">
								</c:if>
								<c:if test="${item.sub2_photo_src != null}">
									<img class="user_img"
										src="resources/client_img/${item.sub2_photo_src}">
								</c:if>
								<c:if test="${item.sub3_photo_src != null}">
									<img class="user_img"
										src="resources/client_img/${item.sub3_photo_src}">
								</c:if>
								<c:if test="${item.sub4_photo_src != null}">
									<img class="user_img"
										src="resources/client_img/${item.sub4_photo_src}">
								</c:if>

							</div>

						</c:forEach>

					</div>

					<div  class="tinder--buttons">
						<button id="nope">
							<i class="fa fa-remove"></i>
						</button>
						<button id="love">
							<i class="fa fa-heart"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<script src="resources/js/mainView.js"></script>

</html>













