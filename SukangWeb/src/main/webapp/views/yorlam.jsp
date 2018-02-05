<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<style>
.sorting_asc:after{
	font-family: fontawesome;
}

.com{
	font-weight: bold;
	color : #1874CD;
}

</style>
<title>요람</title>


<%-- <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/resource/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${pageContext.request.contextPath}/resource/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="${pageContext.request.contextPath}/resource/js/plugins/metisMenu/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="${pageContext.request.contextPath}/resource/js/plugins/morris/raphael.min.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/plugins/morris/morris.min.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/plugins/morris/morris-data.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="${pageContext.request.contextPath}/resource/js/sb-admin-2.js"></script> --%>

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

<script
	src="${pageContext.request.contextPath}/resource/js/jquery-2.1.1.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/js/jquery-ui.js"></script>
<!-- DataTables JavaScript -->
<script
	src="${pageContext.request.contextPath}/resource/js/plugins/dataTables/jquery.dataTables.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/js/plugins/dataTables/dataTables.bootstrap.js"></script>


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
		
		$("#btnGo").click(function() {
			location.href= "/SukangWeb/views/update.jsp";			
		});

		$("#confirm").click(function() {
			$("#hidden").val($("#selectValue").val())
			$("#userId").val("#userIdText").val()
			$("#form").submit();
		})

		$('#dataTables-example').dataTable();
		
		getdepartList();
	});
	
	var getdepartList = function(){
		
		$.ajax({
			url:"/SukangWeb/showDepart.do",
			type:"get",
			data:{},
			success: showDepart,
			error: errorCallback
		});
	};
	
	var showDepart = function(resultData) {
		$("#selectValue").empty();
		
		body ="";
		$.each(resultData,function(index, item){
			body += "<option value='"+ item.departCode + "'>" + item.major + "</option>";
		});
		
		$("#selectValue").append(body);
	};
	
	var errorCallback = function() {
		location.href="${pageContext.request.contextPath}/views/error.jsp";
	};
	
	
</script>
</head>
<div id="fb-root"></div>
<body>
	<form id="logoutForm"
		action="${pageContext.request.contextPath}/logout.do"></form>
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
										<div class="panel-footer"></div>

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
					<h1 class="page-header">요 람</h1>
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
					<div class="panel panel-yellow">
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
									<div class="huge" style="font-size: 20px ; ">선수과목<br>로드맵</div>
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

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							요람 
							<select id="selectValue">
								
							</select>

							<button type="submit" id="confirm">확인</button>

							<form action="/SukangWeb/yolam.do" id="form">
								<input type="hidden" name="departCode" id="hidden"> <input
									type="hidden" value="" id="userId">

							</form>

						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<div class="table-responsive">
								<div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline" role="grid">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="dataTables-example_length">
												
											</div>
										</div>
									</div>
									<table
										class="table table-striped table-bordered table-hover dataTable no-footer"
										id="dataTables-example" aria-describedby="dataTables-example_info">
										<thead>
											<tr role="row">
												<th class="sorting_asc" tabindex="0" aria-controls="dataTables-example"
													 aria-label="Rendering engine: activate to sort column ascending"
													aria-sort="ascending">학년</th>
												<th class ="sorting" tabindex="0" aria-controls=" dataTables-example"
													rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending"
													>학기
												</th>
												<th class="sorting" tabindex="0" aria-controls="dataTables-example"
													 aria-label="Platform(s): activate to sort column ascending"
													>학수구분</th>
												<th class ="sorting" tabindex="0" aria-controls="dataTables-example"
													 aria-label="Engine version: activate to sort column ascending"
													>과목명
												</th>
												<th class ="sorting" tabindex="0" aria-controls="dataTables-example"
													 aria-label="CSS grade: activate to sort column ascending"
													>학점
												</th>
												<th>선수과목</th>
												<th>심화구분</th>
											</tr>
										</thead>

										<tbody>
											<c:forEach var="sList" items="${subjectList}" varStatus="sts">
													<c:if test ="${sList.recommended eq true }">
														<c:if test = "${ sts.count %2 == 0}">
														<tr class="even gradeA com">
															<td>${sList.year}</td>
															<td>${sList.semester}</td>
															<td>${sList.classtype}</td>
															<td>${sList.subjectName}</td>
															<td>${sList.credit}</td>
															<td>${sList.preSubject}</td>
															<td>${sList.interest}</td>
														</tr>
														</c:if>
														
														<c:if test = "${ sts.count %2 == 1}">
														<tr class="odd gradeA com">
															<td>${sList.year}</td>
															<td>${sList.semester}</td>
															<td>${sList.classtype}</td>
															<td>${sList.subjectName}</td>
															<td>${sList.credit}</td>
															<td>${sList.preSubject}</td>
															<td>${sList.interest}</td>
														</tr>
														</c:if>
													</c:if>
													<c:if test ="${sList.recommended eq false }">
														<c:if test = "${ sts.count %2 == 0}">
														<tr class="even gradeA">
															<td>${sList.year}</td>
															<td>${sList.semester}</td>
															<td>${sList.classtype}</td>
															<td>${sList.subjectName}</td>
															<td>${sList.credit}</td>
															<td>${sList.preSubject}</td>
															<td>${sList.interest}</td>
														</tr>
														</c:if>
														
														<c:if test = "${ sts.count %2 == 1}">
														<tr class="odd gradeA">
															<td>${sList.year}</td>
															<td>${sList.semester}</td>
															<td>${sList.classtype}</td>
															<td>${sList.subjectName}</td>
															<td>${sList.credit}</td>
															<td>${sList.preSubject}</td>
															<td>${sList.interest}</td>
														</tr>
														</c:if>
													</c:if>
											</c:forEach>
										</tbody>

									</table>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
</body>

</html>