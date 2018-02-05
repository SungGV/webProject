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
.retakeTable{
	color: #ff0000;
	font-weight: bold; 
	
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

<!-- Morris Charts CSS -->
<link
	href="${pageContext.request.contextPath}/resource/css/plugins/morris.css"
	rel="stylesheet">

<!-- Include 이수상황_막대그래프 css -->
<link class="include" rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jqplot/jquery.jqplot.css" />

<!-- JQuery -->

<script
	src="${pageContext.request.contextPath}/resource/js/jquery-2.1.1.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/js/jquery-ui.js"></script>

<%-- 
	    <!-- Include . 이수상황_막대그래프 plugin -->
	    
		<script type="text/javascript" src="${pageContext.request.contextPath}/jqplot/jquery.jqplot.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jqplot/plugins/jqplot.barRenderer.min.js"></script>
		
	    <!-- Bootstrap Core JavaScript -->
	    <script src="${pageContext.request.contextPath}/resource/js/bootstrap.min.js"></script>
	
	    <!-- Metis Menu Plugin JavaScript -->
	    <script src="${pageContext.request.contextPath}/resource/js/plugins/metisMenu/metisMenu.min.js"></script>
	
	    <!-- Morris Charts JavaScript -->
	    <script src="${pageContext.request.contextPath}/resource/js/plugins/morris/raphael.min.js"></script>
	    <script src="${pageContext.request.contextPath}/resource/js/plugins/morris/morris.min.js"></script>
	    <script src="${pageContext.request.contextPath}/resource/js/plugins/morris/morris-data.js"></script>
	
	    <!-- Custom Theme JavaScript -->
	    <script src="${pageContext.request.contextPath}/resource/js/sb-admin-2.js"></script>
	    --%>


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

		FB.getLoginStatus(function(response) {
			if (response.status === 'connected') {
				FB.api('/me',function(user) {
					if (user) {
						document.getElementById("userImage").src = 'http://graph.facebook.com/'
														+ user.id + '/picture';
												//image설정
												var name = document.getElementById('name');
												name.innerHTML = user.name
												//이름설정
												document.getElementById("userId").value = user.id;
												//아이디설정
											}
										});
						$("#loginState").toggle();
						$("#logoutState").toggle();

					} else if (response.status === 'not_authorized') {
						$("#logoutForm").submit();
					} else {
						$("#logoutForm").submit();
					}
				});

		FB.Event.subscribe('auth.login', function(response) {
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
		
		$("#btnGo").click(function() {
			location.href= "/SukangWeb/views/update.jsp";			
		});
		
	});
	
	
	
</script>


<title>성 적 표 </title>
</head>

<div id="fb-root"></div>
<body>

<form id="logoutForm" action="${pageContext.request.contextPath}/logout.do">

</form>


	<div id="wrapper">

		<!-- 배너 부분 -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
		<div class="navbar-header">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/views/completed.jsp">수강 관리 시스템</a>
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
										<button type="button" id="btnGo"
											class="btn btn-outline btn-primary btn-xs">추가정보수정</button>
										<div class="panel-footer">
											
										</div>

										<div class="panel-body" align="middle">
											<input id="userImage" type="image" src=""
												style="width: 160px; height: 160px">
											<div align="middle">
												<div id="name"></div>
											</div>
											<p>님 환영합니다 <br>
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
						</div>
						<!-- /profile-menu -->
						
						<!-- Calendar -->
						
						
						
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side --> </nav>


		<!-- main center 부분 -->
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">성 적 표</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-3 col-md-6">
					<div class="panel panel-primary">
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
						<a href="${pageContext.request.contextPath}/views/completed.jsp">
							<div class="panel-footer">
								<span class="pull-left">View Details</span> <span
									class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
								<div class="clearfix"></div>
							</div>
						</a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="panel panel-yellow">
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
						<a href="${pageContext.request.contextPath}/report.do">
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
						<a href="${pageContext.request.contextPath}/views/yorlam.jsp">
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
									<div class="huge" style="font-size: 20px;">선수과목<br>로드맵</div>
								</div>
							</div>
						</div>
						<a href="${pageContext.request.contextPath}/views/loadmap.jsp">
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
						<a href="${pageContext.request.contextPath}/views/autoRec.jsp">
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
							<i class="fa fa-bar-chart-o fa-fw">성적표</i>
							<div class="pull-right">
								<select id="select">
									<c:choose>										
										<c:when test="${semester==11}">
											<option value="total">전체성적</option>
											<option value="11">1학년 1학기</option>
										</c:when>
										<c:when test="${semester==12}">
											<option value="total">전체성적</option>
											<option value="11">1학년 1학기</option>
											<option value="12">1학년 2학기</option>
										</c:when>
										<c:when test="${semester==21}">
											<option value="total">전체성적</option>																				
											<option value="11">1학년 1학기</option>
											<option value="12">1학년 2학기</option>
											<option value="21">2학년 1학기</option>
										</c:when>
										<c:when test="${semester==22}">
											<option value="total">전체성적</option>
											<option value="11">1학년 1학기</option>
											<option value="12">1학년 2학기</option>
											<option value="21">2학년 1학기</option>
											<option value="22">2학년 2학기</option>
										</c:when>
										<c:when test="${semester==31}">
											<option value="total">전체성적</option>
											<option value="11">1학년 1학기</option>
											<option value="12">1학년 2학기</option>
											<option value="21">2학년 1학기</option>
											<option value="22">2학년 2학기</option>
											<option value="31">3학년 1학기</option>
										</c:when>
										<c:when test="${semester==32}">
											<option value="total">전체성적</option>
											<option value="11">1학년 1학기</option>
											<option value="12">1학년 2학기</option>
											<option value="21">2학년 1학기</option>
											<option value="22">2학년 2학기</option>
											<option value="31">3학년 1학기</option>
											<option value="32">3학년 2학기</option>
										</c:when>
										<c:when test="${semester==41}">
											<option value="total">전체성적</option>
											<option value="11">1학년 1학기</option>
											<option value="12">1학년 2학기</option>
											<option value="21">2학년 1학기</option>
											<option value="22">2학년 2학기</option>
											<option value="31">3학년 1학기</option>
											<option value="32">3학년 2학기</option>
											<option value="41">4학년 1학기</option>
										</c:when>
										<c:when test="${semester==42}">
											<option value="total">전체성적</option>
											<option value="11">1학년 1학기</option>
											<option value="12">1학년 2학기</option>
											<option value="21">2학년 1학기</option>
											<option value="22">2학년 2학기</option>
											<option value="31">3학년 1학기</option>
											<option value="32">3학년 2학기</option>
											<option value="41">4학년 1학기</option>
											<option value="42">4학년 2학기</option>
										</c:when>
										<c:otherwise>
										null
										</c:otherwise>
									</c:choose>
								</select>

								<button type="submit" id="confirm"
									class="btn btn-info btn-circle">go</button>
								<form id="form" action="/SukangWeb/showReportCard.do"
									METHOD="POST">
									<input type="hidden" name="pickedSemester" id="copy">
									<input type="hidden" value="" id="userId">
								</form>

							</div>
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
						<div align="right">
							<p class="text-danger">※ A+ : 4.5점 만점을 기준으로 한 등급 차이를 0.5점으로 주었음※</p>
							<p class="text-danger">※ F학점과 재수강을 표시한 과목은 빨간색으로 표시함※</p>
							</div>
							<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover"
									id="dataTables-example">
									<thead>
										<tr>
											<th>학년</th>
											<th>학기</th>
											<th>교과목 명</th>
											<th>학수 구분</th>
											<th>학점</th>
											<th>점수</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="report" items="${resultReports}">
										<c:if test="${report.retake eq 1 }">
											<tr class="odd gradeX retakeTable">
												<td class="center">${report.subject.year}</td>
												<td class="center">${report.subject.semester}</td>
												<td>${report.subject.subjectName}</td>
												<td class="center">${report.subject.classtype}</td>
												<td class="center">${report.subject.credit}</td>
												<td class="center">${report.grade2}</td>
											</tr>
										</c:if>
										<c:if test="${report.retake ne 1 }">
											<tr class="odd gradeX">
												<td class="center">${report.subject.year}</td>
												<td class="center">${report.subject.semester}</td>
												<td>${report.subject.subjectName}</td>
												<td class="center">${report.subject.classtype}</td>
												<td class="center">${report.subject.credit}</td>
												<td class="center">${report.grade2}</td>
											</tr>
										</c:if>
										</c:forEach>

										<tr>
											<td colspan="4"></td>
											<td>총 학점:${credit}</td>
											<td>성적:${grade}</td>
										</tr>
									</tbody>
								</table>
							</div>
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