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
.

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
												getGraph();
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
<script type="text/javascript">
	$(document).ready(function() {
		
		$("#btnGo").click(function() {
			location.href= "/SukangWeb/views/update.jsp";	
		});
		$("#btnGo1").click(function() {
			location.href= "/SukangWeb/views/additional.jsp";	
		});
		
	});
	
	var getGraph = function(){
		
		$.ajax({
			url : "/SukangWeb/completed.do",
			type : "get",
			data : {userId : $("#userId").val()},
			success : graph,
			error : errorCallback
		});
		
	};
	
	var graph = function(resultData){
		
		if(resultData.needCreditForGraduation == 0){
			
			$("#btnAlert").trigger("click");
			
		}
		//[x 좌표에 표출될 문자, y좌표와 그래프의 높이를 정해주는 값]
		var total = [ resultData.needCreditForGraduation, resultData.needCreditForRequirement
		              ,resultData.needCreditForSelective, resultData.needCreditForBasic ];
		var subjectCompleted = [ resultData.comTotalCredit, resultData.comMajorCredit
		                         ,resultData.comSelecionCredit, resultData.comBasicCredit ];
		var xname = [ '졸업필요학점/전체이수학점', '전필필요학점/이수학점', '전선필요학점/이수학점', '기초필요학점/이수학점' ];

		//그래프 플러그인 호출
		// 'chart1' -> 해당 그래프를 삽입할 태그 Id
		// 2번째 그래프에 들어갈 값들
		var plot1 = $('#chart1').jqplot(
						[ total, subjectCompleted ],
						{
							// 제목	title : '이수 상황',
							animate : !$.jqplot.use_excanvas,
							seriesDefaults : {
								renderer : $.jqplot.BarRenderer,
								rendererOptions : {
									varyBarColor : true,
									smooth : true,
									barMargin : 30
								},
								pointLabels : {
									show : true
								}
							},

							axesDefaults : {
								tickRenderer : $.jqplot.CanvasAxisTickRenderer,
								tickOptions : {
									fontSize : '10pt'
								}
							},
							axes : {
								xaxis : {
									renderer : $.jqplot.CategoryAxisRenderer,
									ticks : xname
								},
								yaxis : {
									min : 0,
									max : 160,
									label : "학점"
								}
							}
						});

		// -- 이수상황 원형 그래프 --
		var data = [ ['기타', (resultData.needCreditForGraduation - (resultData.needCreditForRequirement 
                + resultData.needCreditForSelective + resultData.needCreditForBasic))],
		             ['전필', (resultData.needCreditForRequirement-resultData.comMajorCredit)],
		             ['전선', (resultData.needCreditForSelective-resultData.comSelecionCredit)],
		             ['기초', (resultData.needCreditForBasic-resultData.comBasicCredit)]
		             ];
		
		var plot2 = jQuery.jqplot('chart2', [ data ], {
			seriesDefaults : {
				renderer : jQuery.jqplot.PieRenderer,
				rendererOptions : {
					// Turn off filling of slices.
					fill : false,
					showDataLabels : true,
					// Add a margin to seperate the slices.
					sliceMargin : 4,
					// stroke the slices with a little thicker line.
					lineWidth : 5
				}
			},
			legend : {
				show : true,
				location : 'e'
			}
		});
		//  -- /이수상황 원형 그래프 --
		
		description(resultData);
	};
	
	var description = function(resultData){
		
		var body="";
		body += "<h4><이수해야할 학점></h4><h4 class='text-info'> 총 학점 : " + (resultData.needCreditForGraduation - resultData.comTotalCredit) + "&nbsp;&nbsp;/&nbsp;&nbsp;"
			+ "전공필수 : " +  (resultData.needCreditForRequirement-resultData.comMajorCredit) + "&nbsp;&nbsp;/&nbsp;&nbsp;"
			+ "전공선택 : " +  (resultData.needCreditForRequirement-resultData.comMajorCredit) + "&nbsp;&nbsp;/&nbsp;&nbsp;"
			+ "기초과목 : " + (resultData.needCreditForBasic-resultData.comBasicCredit) + "&nbsp;&nbsp;/&nbsp;&nbsp;"
			+ "기타 : " + (resultData.needCreditForGraduation - (resultData.needCreditForRequirement 
                    				+ resultData.needCreditForSelective + resultData.needCreditForBasic)) +"</h4>"
            + "<p class='text-danger'>※ 기타 = 졸업 필요 최소 학점 - (전필 필요학점 + 전선 필요학점 + 기초 필요학점)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
           	+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 즉, 전선,교양중 선택하여 충족 할 수 있는 점수를 뜻함</p>";
			
			$("#description2").append(body);
	};
	
	var errorCallback = function() {
		alert("실행 중 오류가 발생했습니다.");
	};
</script>

<title>이수 상황</title>
</head>

<div id="fb-root"></div>
<body>
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
					<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" id="btnAlert" style="display:none;">
                                Launch Demo Modal
                            </button>
							 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel"><h4><strong>학과정보가 없습니다</strong></h4>
                                        </div>
                                        <div class="modal-body" style="text-align:center;">
                                            	<p class="text-info">학과 정보가 없습니다!</p><br> 
                                            	<p class="text-info">Sukang Guide를 사용 하고 싶으시다면 </p><br>
                                            	<p class="text-info">추가 정보를 입력해 주세요.</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                                            <button id="btnGo1" type="button" class="btn btn-primary">추가정보 입력</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
				<div class="col-lg-6">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-bar-chart-o fa-fw"></i>이수 상황
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body" style="width: 100%; height: 750px;">
							<div class="flot-chart">
								<div id="chart1" class="example-chart"
									style="width: 100%; height: 700px;"></div>
							</div>
							<!-- /.table-responsive -->
							
						</div>
						<!-- /.panel-body -->
						<div class= "panel-footer" id="description1" style="text-align:center">
							<p>왼쪽 막대기 - 학과에서 요구하는 최소 학점 &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;
							 오른쪽 막대기- 사용자가 이수한 학점</p>
						</div>
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-6 -->


				<div class="col-lg-6">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-bar-chart-o fa-fw"></i>이수해야할 과목 비율
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body" style="width: 100%; height: 750px;">
							<div class="flot-chart">
								<div class="flot-chart-content" id="chart2"
									style="padding: 0px; position: relative; width: 100%; height: 700px;"></div>
							</div>
							
							
							
							
						</div>
						<!-- /.panel-body -->
						<div class= "panel-footer" id="description2">
							
						</div>
					</div>
					<!-- /.panel -->
				</div>
				<!--  /.col-lg-6 -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

</body>
</html>