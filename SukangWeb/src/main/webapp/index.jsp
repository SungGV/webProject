<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!--  Ul 부분   -->


<style>


.col-lg-12{
	text-align: center;
}

.panel-info {
	margin: 0px auto 0px auto;
}

#userName {
	border: 0;
}
</style>


<!-- Bootstrap Core CSS -->
<link
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link
	href="${pageContext.request.contextPath}/resource/css/plugins/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Timeline CSS -->
<link
	href="${pageContext.request.contextPath}/resource/css/plugins/timeline.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link
	href="${pageContext.request.contextPath}/resource/css/sb-admin-2.css"
	rel="stylesheet">

<!-- Include 이수상황_막대그래프 css -->
<link class="include" rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jqplot/jquery.jqplot.css" />

<!-- JQuery -->

<script
	src="${pageContext.request.contextPath}/resource/js/jquery-2.1.1.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/js/jquery-ui.js"></script>

<!-- -------------------  FaceBook ------------------- -->

<script>
	window.fbAsyncInit = function() {
		FB.init({
			appId : '326851680840653', // 앱 ID
			status : true, // 로그인 상태를 확인
			cookie : true, // 쿠키허용

			xfbml : true
		// parse XFBML
		});


		FB.Event.subscribe('auth.login', function(response) {
		FB.getLoginStatus(function(response) {
			var uid;
			if (response.status === 'connected') {
				FB.api('/me',function(user) {
					if (user) {
						document.getElementById("userImage").src = 'http://graph.facebook.com/'
														+ user.id + '/picture';
												//image설정
												var name = document.getElementById('name');
												name.innerHTML = user.name
												document.getElementById('userName').value = user.name;
												//이름설정
												document.getElementById("userId").value = user.id;
												document.getElementById("userId2").value = user.id;
												uid=user.id;
												//아이디설정
												
											}
						
						$("#loginForm").submit();
										});
						
						$("#loginState").toggle();
						$("#logoutState").toggle();
						
					} else if (response.status === 'not_authorized') {

					} else {

					}
				});
						
			//document.location.reload();
		});

		FB.Event.subscribe('auth.logout', function(response) {
			
			document.location.reload();
		});

	};

	// This function is called when someone finishes with the Login
	// Button.  See the onlogin handler attached to it in the sample
	// code below.
	function checkLoginState() {
		FB.getLoginStatus(function(response) {
			statusChangeCallback(response);
			alert("checkLoginState()");
		});
	}

	// Load the SDK Asynchronously
	(function(d) {
		var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
		if (d.getElementById(id)) {
			return;
		}
		js = d.createElement('script');
		js.id = id;
		js.async = true;
		js.src = "//connect.facebook.net/ko_KR/all.js";
		ref.parentNode.insertBefore(js, ref);
	}(document));
</script>
<!-- -------------------  /FaceBook ------------------- -->

<script type="text/javascript">
	$(document).ready(function() {

		var match = function() {
			$("#copy").val($("#select").val());
		};

		$("#confirm").bind('click', function() {
			match();
			$("#form").submit();

		});
		
		$("a").click(function() {
			alert("로그인이 필요한 메뉴입니다.")
		});

	});
</script>

<!-- Include . 이수상황_막대그래프 plugin -->
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jqplot/jquery.jqplot.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jqplot/plugins/jqplot.pointLabels.min.js"></script>

<!-- 이수상황_원형 그래프  -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jqplot/plugins/jqplot.donutRenderer.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script
	src="${pageContext.request.contextPath}/resource/js/bootstrap.min.js"></script>

<!-- ------------------- 이수상황 막대 그래프 --------------------- -->

<title>이수 상황</title>
</head>

<div id="fb-root"></div>
<body>

<form id="loginForm" action="${pageContext.request.contextPath}/login.do">
	<input type="text" value="" id="userId2" name="userId">
	<input type="text" value="" id="userName" name="userName">
</form>



	<div id="wrapper">

		<!-- 배너 부분 -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
		<div class="navbar-header">
			<a class="navbar-brand" href="main.jsp">수강 관리 시스템</a>
		</div>

		<!-- side bar 부분 -->
		<div class="navbar-default sidebar" role="navigation">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">

					<!-- search 부분 -->
					<li class="sidebar-search">
						<div class="input-group custom-search-form">
							<input type="text" class="form-control" placeholder="Search...">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button">
									<i class="fa fa-search">검색</i>
								</button>
							</span>
						</div>
					</li>

					<!-- side bar_profile 부분-->
					<div id="profile-menu">


						<!--   로그인 상태의 화면  -->

						<div id="loginState" style="display: none;">
							<div class="col-lg-4" style="min-width: 250px;">
								<div class="panel panel-default">
									<div class="panel-heading">
										반갑습니다! &nbsp;&nbsp;
										<button type="button"
											class="btn btn-outline btn-primary btn-xs">추가정보수정</button>
										<div class="panel-footer">
											<input type="hidden" value="" id="userId">
										</div>

										<div class="panel-body" align="middle">
											<input id="userImage" type="image" src=""
												style="width: 160px; height: 160px">
											<div align="middle">
												<div id="name"></div>
											</div>
											<p>
												님 환영합니다. <br>
											<div class="fb-login-button" data-max-rows="1"
												data-size="small" data-show-faces="false"
												data-auto-logout-link="true"></div>
										</div>

									</div>
								</div>
								<!-- /.col-lg-4 -->
							</div>

						</div>
						<!-- /loginState -->

						<!--  로그아웃인 상태의  화면 -->

						<div id="logoutState">

							<div class="col-lg-4" style="min-width: 250px;">
								<div class="panel panel-default">
									<div class="panel-heading">로그인 해주세요!</div>
									<div class="panel-body" align="middle">
										<P>FaceBook으로 로그인하기</P>
										<div class="fb-login-button" data-max-rows="1"
											data-size="xlarge" data-show-faces="false"
											data-auto-logout-link="true"></div>
									</div>

								</div>
							</div>
							<!-- /.col-lg-4 -->

						</div>
						<!-- /logoutState -->
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side --> </nav>


		<!-- main center 부분 -->
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">이 수 상 황</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-3 col-md-6">
					<div class="panel panel-yellow">
						<div class="panel-heading">
							<div class="row">
								<div class="col-xs-3">
									<i class="fa fa-comments fa-5x"></i>
								</div>
								<div class="col-xs-9 text-right">
									<div class="huge">이수상황</div>
								</div>
							</div>
						</div>
						<a href="">
							<div class="panel-footer">
								<span class="pull-left">View Details</span> <span
									class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
								<div class="clearfix"></div>
							</div>
						</a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<div class="row">
								<div class="col-xs-3">
									<i class="fa fa-tasks fa-5x"></i>
								</div>
								<div class="col-xs-9 text-right">
									<div class="huge">성적표</div>
								</div>
							</div>
						</div>
						<a href="">
							<div class="panel-footer">
								<span class="pull-left">View Details</span> <span
									class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
								<div class="clearfix"></div>
							</div>
						</a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<div class="row">
								<div class="col-xs-3">
									<i class="fa fa-shopping-cart fa-5x"></i>
								</div>
								<div class="col-xs-9 text-right">
									<div class="huge">요람</div>
								</div>
							</div>
						</div>
						<a href="">
							<div class="panel-footer">
								<span class="pull-left">View Details</span> <span
									class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
								<div class="clearfix"></div>
							</div>
						</a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<div class="row">
								<div class="col-xs-3">
									<i class="fa fa-support fa-5x"></i>
								</div>
								<div class="col-xs-9 text-right">
									<div class="huge">로드맵</div>
								</div>
							</div>
						</div>
						<a href="">
							<div class="panel-footer">
								<span class="pull-left">View Details</span> <span
									class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
								<div class="clearfix"></div>
							</div>
						</a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<div class="row">
								<div class="col-xs-3">
									<i class="fa fa-shopping-cart fa-5x"></i>
								</div>
								<div class="col-xs-9 text-right">
									<div class="huge">자동추천</div>
								</div>
							</div>
						</div>
						<a href="">
							<div class="panel-footer">
								<span class="pull-left">View Details</span> <span
									class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
								<div class="clearfix"></div>
							</div>
						</a>
					</div>
				</div>

			</div>
			<!-- /.row -->


			<!-- 메인 화면 바뀌는 div 부분-->

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-bar-chart-o fa-fw"></i>
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body" style="width: 100%; height: 750px;">
							<div class="" style=" margin: 200px auto; width: 50%;">
                    			<div class="panel panel-info">
                        			<div class="panel-heading">
                            			Info Panel
                        			</div>
                        		<div class="panel-body">
                            <p>로그인이 필요합니다!</p><br><p>FaceBook계정으로 로그인 해주세요!</p>
                        </div>
                        <div class="panel-footer">
                            	왼쪽 상단에 로그인하기를 이용해주세요
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-4 -->
							<!-- /.table-responsive -->
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->


			</div>
			<!-- /.row -->
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

</body>
</html>