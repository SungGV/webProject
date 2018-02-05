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
<title>로 드 맵</title>

<%-- <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/resource/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${pageContext.request.contextPath}/resource/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="${pageContext.request.contextPath}/resource/js/plugins/metisMenu/metisMenu.min.js"></script>

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

<!-- UI CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/jquery-ui.css">

<script
	src="${pageContext.request.contextPath}/resource/js/jquery-2.1.1.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/js/jquery-ui.js"></script>

<script src="${pageContext.request.contextPath}/resource/js/go.js"></script>

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


<!-- ------------------- 로드맵 에  보내줄 데이터 ----------- -->
<script type="text/javascript">
	/* 3차 처리>>  1차 list의 과목명들을 배열방식으로 담기.
	 -> var subjects = new Array();
	 -> 1차 처리의 list 데이터를 반복문으로 
	 -> data 변수에 하나하나 꺼내면서 subjects 배열에 하나하나 data를 담는다.
	 <script> 
	 function() {
	 subjects.push(data);
	 }  */

	$(document).ready(function() {
		
		$("#btnGo").click(function() {
			location.href= "/SukangWeb/views/update.jsp";			
		});

		//getdepartList();
		init();
		 $("#selectValue").change(function() {
			if($("#selectValue").val() != 'media') {
				alert("해당학과에 대한 정보가 없습니다")
			}
			ajax();
		
		}); 
	});



	var errorCallback = function() {
		alert("실행 중 오류가 발생했습니다.");
	};

	var ajax = function() {
		
		$.ajax({
			url : "/SukangWeb/loadList.do" //loadList.do는 컨트롤러 메소드의 RequestMapping과 일치
			,type : "get"
			,data : {
				major : $("#selectValue").val()
				}
			,success : dispSubjectInfo //리스트 받아오는데 성공했을 때 호출되는 함수
			,error : errorCallback //에러 콜백
		});
	}
	var dispSubjectInfo = function(resultData) {
		var roadArray = new Array();
		var fromToArray = new Array();

		$.each(resultData.keyRoad, function(index, item) {

			var object = {}
			object.key = item.key;
			object.category = item.category;
			object.text = item.text;
			roadArray.push(object);

		});

		$.each(resultData.fromRoad, function(index, item) {
			var fromTo = {}
			fromTo.from = item.preInt;
			fromTo.to = item.subInt;
			fromToArray.push(fromTo);

		});

		var json = JSON.stringify(roadArray);
		var jsonFromTo = JSON.stringify(fromToArray);

		$("#mySavedModel").val(
				"{\"nodeDataArray\": " + json + ", " + "\"linkDataArray\":"
						+ jsonFromTo + "}");
		//location.href ="/SukangWeb/load.do?major="+$("#selectValue").val();
	};

	var errorCallback = function() {
		alert("실패하였습니다");
	}
</script>
<!-- ------------------ /로드맵 에 보내줄 데이터 ----------- -->

<!-- ------------------- 로드맵 ------------------------ -->
<script id="code">
	// this controls whether the layout is horizontal and the layer bands are vertical, or vice-versa:
	var HORIZONTAL = true; // this constant parameter can only be set here, not dynamically
	function init() {
		
		var $ = go.GraphObject.make; // for conciseness in defining templates

		var yellowgrad = $(go.Brush, go.Brush.Linear, {
			0 : "rgb(254, 201, 0)",
			1 : "rgb(254, 162, 0)"
		});
		var greengrad = $(go.Brush, go.Brush.Linear, {
			0 : "#98FB98",
			1 : "#9ACD32"
		});
		var bluegrad = $(go.Brush, go.Brush.Linear, {
			0 : "#B0E0E6",
			1 : "#87CEEB"
		});
		var redgrad = $(go.Brush, go.Brush.Linear, {
			0 : "#C45245",
			1 : "#7D180C"
		});
		var whitegrad = $(go.Brush, go.Brush.Linear, {
			0 : "#F0F8FF",
			1 : "#E6E6FA"
		});

		var bigfont = "bold 13pt Helvetica, Arial, sans-serif";
		var smallfont = "bold 11pt Helvetica, Arial, sans-serif";

		// Common text styling
		function textStyle() {
			return {
				margin : 6,
				wrap : go.TextBlock.WrapFit,
				textAlign : "center",
				editable : true,
				font : bigfont
			}
		}
		myDiagram = $(go.Diagram, "myDiagram", {
			// have mouse wheel events zoom in and out instead of scroll up and down
			/*"toolManager.mouseWheelBehavior" : go.ToolManager.WheelZoom,
			 allowDrop : false, // support drag-and-drop from the Palette
			 initialAutoScale : go.Diagram.Uniform,
			 "linkingTool.direction" : go.LinkingTool.ForwardsOnly, */
			initialContentAlignment : go.Spot.Center,
			layout : $(go.LayeredDigraphLayout, {
				isInitial : false,
				isOngoing : false,
				layerSpacing : 50
			}),
			"undoManager.isEnabled" : true
		});

		// 문서 가 수정 될 때 , 제목 에 "* "를 추가하고 활성화 "저장"버튼
		myDiagram.addDiagramListener("Modified", function(e) {
			var button = document.getElementById("SaveButton");
			if (button)
				button.disabled = !myDiagram.isModified;
			var idx = document.title.indexOf("*");
			if (myDiagram.isModified) {
				if (idx < 0)
					document.title += "*";
			} else {
				if (idx >= 0)
					document.title = document.title.substr(0, idx);
			}
		});

		var defaultAdornment = $(go.Adornment, "Spot", $(go.Panel, "Auto", $(
				go.Shape, {
					fill : null,
					stroke : "dodgerblue",
					strokeWidth : 4
				}), $(go.Placeholder)),
		// 버튼 은 오른쪽 상단 모서리에 ,"다음" 노드를 작성
		$("Button", {
			alignment : go.Spot.TopRight,
			click : addNodeAndLink
		}, // 이 기능은 아래 정의
		new go.Binding("visible", "", function(a) {
			return !a.diagram.isReadOnly;
		}).ofObject(), $(go.Shape, "PlusLine", {
			desiredSize : new go.Size(6, 6)
		})));

		// 노드 템플릿을 정의
		myDiagram.nodeTemplate = $(go.Node, "Auto", {
			selectionAdornmentTemplate : defaultAdornment
		}, new go.Binding("location", "loc", go.Point.parse)
				.makeTwoWay(go.Point.stringify),
		// TextBlock이 를 둘러싸고 있는 노드의 외형 을 정의
		$(go.Shape, "Rectangle", {
			fill : yellowgrad,
			stroke : "black",
			portId : "",
			fromLinkable : true,
			toLinkable : true,
			cursor : "pointer",
			toEndSegmentLength : 50,
			fromEndSegmentLength : 40
		}), $(go.TextBlock, "Page", {
			margin : 6,
			font : bigfont,
			editable : true
		}, new go.Binding("text", "text").makeTwoWay()));

		myDiagram.nodeTemplateMap.add("BasicSub", $(go.Node, "Auto",
				new go.Binding("location", "loc", go.Point.parse)
						.makeTwoWay(go.Point.stringify), $(go.Shape,
						"RoundedRectangle", {
							fill : bluegrad,
							portId : "",
							fromLinkable : true,
							cursor : "pointer",
							fromEndSegmentLength : 40
						}), $(go.TextBlock, "BasicSub", textStyle(),
						new go.Binding("text", "text").makeTwoWay())));

		myDiagram.nodeTemplateMap.add("DesiredEvent", $(go.Node, "Auto",
				new go.Binding("location", "loc", go.Point.parse)
						.makeTwoWay(go.Point.stringify), $(go.Shape,
						"RoundedRectangle", {
							fill : greengrad,
							portId : "",
							toLinkable : true,
							toEndSegmentLength : 50
						}), $(go.TextBlock, "Success!", textStyle(),
						new go.Binding("text", "text").makeTwoWay())));

		// 원하지 않는 이벤트가 추가 " 이유 "를 추가 할 수있는 특별한 장식품 이
		var UndesiredEventAdornment = $(go.Adornment, "Spot", $(go.Panel,
				"Auto", $(go.Shape, {
					fill : null,
					stroke : "dodgerblue",
					strokeWidth : 4
				}), $(go.Placeholder)),
		// 버튼 은 오른쪽 상단 모서리에 ,"다음" 노드를 작성
		$("Button", {
			alignment : go.Spot.BottomRight,
			click : addReason
		}, // this function is defined below
		new go.Binding("visible", "", function(a) {
			return !a.diagram.isReadOnly;
		}).ofObject(), $(go.Shape, "TriangleDown", {
			desiredSize : new go.Size(10, 10)
		})));

		var reasonTemplate = $(go.Panel, "Horizontal", $(go.TextBlock,
				"Reason", {
					margin : new go.Margin(4, 0, 0, 0),
					maxSize : new go.Size(200, NaN),
					wrap : go.TextBlock.WrapFit,
					stroke : "whitesmoke",
					editable : true,
					font : smallfont
				}, new go.Binding("text", "text").makeTwoWay()));

		/* 		myDiagram.nodeTemplateMap.add("UndesiredEvent", $(go.Node, "Auto",
		 new go.Binding("location", "loc", go.Point.parse)
		 .makeTwoWay(go.Point.stringify), {
		 selectionAdornmentTemplate : UndesiredEventAdornment
		 }, $(go.Shape, "RoundedRectangle", {
		 fill : redgrad,
		 portId : "",
		 toLinkable : true,
		 toEndSegmentLength : 50
		 }), $(go.Panel, "Vertical", {
		 defaultAlignment : go.Spot.TopLeft
		 },

		 $(go.TextBlock, "Drop", textStyle(), {
		 stroke : "whitesmoke",
		 minSize : new go.Size(80, NaN)
		 }, new go.Binding("text", "text").makeTwoWay()),

		 $(go.Panel, "Vertical", {
		 name : "ReasonList",
		 defaultAlignment : go.Spot.TopLeft,
		 itemTemplate : reasonTemplate
		 }, new go.Binding("itemArray", "reasonsList").makeTwoWay())))); */

		myDiagram.nodeTemplateMap.add("Comment", $(go.Node, "Auto",
				new go.Binding("location", "loc", go.Point.parse)
						.makeTwoWay(go.Point.stringify), $(go.Shape,
						"Rectangle", {
							portId : "",
							fill : whitegrad,
							fromLinkable : true
						}), $(go.TextBlock, "A comment", {
					margin : 9,
					maxSize : new go.Size(200, NaN),
					wrap : go.TextBlock.WrapFit,
					editable : true,
					font : smallfont
				}, new go.Binding("text", "text").makeTwoWay())
		// 어떤 포트 , 어떤 링크는코멘트와 함께 연결할 수 없기 때문에
		));

		// UndesiredEvent 노드 에있는 버튼을 클릭하면 패널 에 새 텍스트 개체를 삽입
		function addReason(e, obj) {
			var adorn = obj.part;
			if (adorn === null)
				return;
			e.handled = true;
			//var list = adorn.adornedPart.findObject("ReasonList");
			var arr = adorn.adornedPart.data.reasonsList;

			// and add it to the Array of port data
			myDiagram.startTransaction("add reason");
			myDiagram.model.addArrayItem(arr, {});
			myDiagram.commitTransaction("add reason");
		}

		// 선택된 노드 의우측 에신규 노드 는기본 노드의삽입 버튼 클릭
		// 해당 노드로의 새로운링크를 추가
		function addNodeAndLink(e, obj) {
			var adorn = obj.part;
			if (adorn === null)
				return;
			e.handled = true;
			var diagram = adorn.diagram;
			diagram.startTransaction("Add State");
			// 사용자가 버튼을 클릭 하는노드 데이터 를 얻을
			var fromNode = adorn.adornedPart;
			var fromData = fromNode.data;
			// 새로운 " 상태 " 데이터 객체를 생성 ,장식 노드 의 오른쪽에 떨어져 위치
			var toData = {
				text : "new"
			};
			var p = fromNode.location;
			toData.loc = p.x + 200 + " " + p.y; // " LOC "속성 은 문자열 이 아닌 포인트 객체입니다
			// 모델에새로운 노드 를 추가 데이터
			var model = diagram.model;
			model.addNodeData(toData);
			// create a link data from the old node data to the new node data
			var linkdata = {};
			linkdata[model.linkFromKeyProperty] = model
					.getKeyForNodeData(fromData);
			linkdata[model.linkToKeyProperty] = model.getKeyForNodeData(toData);
			// and add the link data to the model
			model.addLinkData(linkdata);
			// select the new Node
			var newnode = diagram.findNodeForData(toData);
			diagram.select(newnode);
			diagram.commitTransaction("Add State");
		}

		// replace the default Link template in the linkTemplateMap
		myDiagram.linkTemplate = $(go.Link, // the whole link panel
		new go.Binding("points").makeTwoWay(), {
			curve : go.Link.Bezier,
			toShortLength : 15
		}, new go.Binding("curviness", "curviness"), $(go.Shape, // the link shape
		{
			isPanelMain : true,
			stroke : "#2F4F4F",
			strokeWidth : 2.5
		}), $(go.Shape, // the arrowhead
		{
			toArrow : "kite",
			fill : "#2F4F4F",
			stroke : null,
			scale : 2
		}));

		myDiagram.linkTemplateMap.add("Comment", $(go.Link, {
			selectable : false
		}, $(go.Shape, {
			strokeWidth : 2,
			stroke : "darkgreen"
		})));

		/*var palette = $(go.Palette, "palette", // create a new Palette in the HTML DIV element "palette"
		 {
		 // share the template map with the Palette
		 nodeTemplateMap : myDiagram.nodeTemplateMap,
		 autoScale : go.Diagram.Uniform
		 });

		 palette.model.nodeDataArray = [ {
		 category : "BasicSub"
		 }, {}, // default node
		 {
		 category : "DesiredEvent"
		 }, {
		 category : "UndesiredEvent",
		 reasonsList : [ {} ]
		 }, {
		 category : "Comment"
		 } ]; */

		// read in the JSON-format data from the "mySavedModel" element
		
			load();
			layout();
		
				
	}

	function layout() {
		myDiagram.layoutDiagram(true);
	}

	// Show the diagram's model in JSON format
	function save() {
		document.getElementById("mySavedModel").value = myDiagram.model
				.toJson();
		myDiagram.isModified = false;
	}
	 function load() {
		myDiagram.model = go.Model.fromJson(document
				.getElementById("mySavedModel").value);
	} 
</script>
<!-- ------------------- / 로드맵 ------------------------ -->

<!-- ------------------- / 진로 방향 ------------------------ -->
<script>
	$(function() {
		$("#accordion").accordion();
	});
</script>
<!-- ------------------- / 진로 방향 ------------------------ -->

</head>

<div id="fb-root"></div>
<body >

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
					<h1 class="page-header">선수과목 로드맵</h1>
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
					<div class="panel panel-yellow">
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

			<div class="row">
				<div class="col-md-8">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-bar-chart-o fa-fw"></i>선수과목 로드맵 
							<select	id="selectValue" name="depart">
									
									<option value="media" <c:if test="${ media eq 'media'}">selected</c:if>>미디어</option>
									<option value="prog" <c:if test="${ prog eq 'prog'}">selected</c:if>>프로그래밍</option>
									
							</select>


							<!-- <input type="text" id="hidden"> -->
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body" style="width: 100%; height: 750px;">
							<div id="myDiagram"
								style="background-color: Snow; border: solid 1px gray; height: 700px; width: 100%; white-space: nowrap;">
							</div>

							<!-- controller 로부터 data 를 배열 안에 값의 형태로 전달 받음 -->
						
						
							<textarea id="mySavedModel"
								style="width: 700px; height: 750px; display:none;">
	
	
	{"nodeDataArray": [{"key":13,"category":"DesiredEvent","text":"디지털미디어"},{"key":14,"category":"DesiredEvent","text":"디자인기초"},{"key":15,"category":"DesiredEvent","text":"컴퓨터프로그래밍"},{"key":17,"category":"DesiredEvent","text":"자료구조"},{"key":18,"category":"DesiredEvent","text":"게임프로그래밍"},{"key":19,"category":"DesiredEvent","text":"컴퓨터애니메이션"},{"key":21,"category":"DesiredEvent","text":"게임디자인"},{"key":22,"category":"DesiredEvent","text":"객체지향프로그래밍"},{"key":23,"category":"DesiredEvent","text":"앱프로그래밍"},{"key":27,"category":"","text":"크로키"},{"key":31,"category":"","text":"그래픽디자인"},{"key":32,"category":"","text":"디지털타이포그래피"},{"key":33,"category":"","text":"플래시디자인"},{"key":35,"category":"","text":"운영체제"},{"key":36,"category":"","text":"컴퓨터그래픽스"},{"key":37,"category":"","text":"영상연출"},{"key":38,"category":"","text":"시각정보그래픽스"},{"key":39,"category":"","text":"애니메이션제작"},{"key":40,"category":"","text":"모바일프로그래밍1"},{"key":41,"category":"","text":"게임기획개론"},{"key":42,"category":"","text":"인터랙션디자인"},{"key":43,"category":"","text":"창의적콘텐츠"},{"key":43,"category":"","text":"창의적콘텐츠"},{"key":44,"category":"","text":"웹앱프로그래밍"},{"key":45,"category":"","text":"알고리즘"},{"key":46,"category":"","text":"캐릭터애니메이션"},{"key":47,"category":"","text":"영상편집론"},{"key":48,"category":"","text":"정보디자인"},{"key":49,"category":"","text":"모바일프로그래밍2"},{"key":50,"category":"","text":"게임스토리텔링"},{"key":51,"category":"","text":"창의적콘텐츠디자인2"},{"key":51,"category":"","text":"창의적콘텐츠디자인2"},{"key":52,"category":"","text":"인터페이스디자인"},{"key":53,"category":"","text":"디지털아이스트리"},{"key":55,"category":"","text":"게임프로그래밍2"},{"key":56,"category":"","text":"애니메이션이론"},{"key":57,"category":"","text":"뉴미디어와모션그래픽스"},{"key":58,"category":"","text":"텍스트마이닝과감성분석"},{"key":59,"category":"","text":"게임상호작용디자인"},{"key":60,"category":"","text":"스마트콘첸트사운드제작"},{"key":61,"category":"","text":"UX디자인"},{"key":62,"category":"","text":"데이터베이스"},{"key":63,"category":"","text":"어머징미디어특론"},{"key":65,"category":"","text":"영상합성"},{"key":67,"category":"","text":"영상사운드제작"},{"key":85,"category":"","text":"디지털사운드기초"}], "linkDataArray":[{"from":15,"to":17},{"from":15,"to":18},{"from":13,"to":21},{"from":15,"to":22},{"from":22,"to":23},{"from":15,"to":27},{"from":14,"to":31},{"from":14,"to":32},{"from":14,"to":33},{"from":15,"to":35},{"from":17,"to":36},{"from":13,"to":37},{"from":14,"to":38},{"from":19,"to":39},{"from":22,"to":40},{"from":13,"to":41},{"from":14,"to":42},{"from":14,"to":43},{"from":18,"to":43},{"from":22,"to":44},{"from":17,"to":45},{"from":13,"to":46},{"from":13,"to":47},{"from":14,"to":48},{"from":22,"to":49},{"from":13,"to":50},{"from":14,"to":51},{"from":18,"to":51},{"from":13,"to":52},{"from":19,"to":53},{"from":36,"to":55},{"from":36,"to":56},{"from":32,"to":57},{"from":31,"to":58},{"from":18,"to":59},{"from":85,"to":60},{"from":14,"to":61},{"from":17,"to":62},{"from":44,"to":63},{"from":14,"to":65},{"from":85,"to":67}]}

</textarea>

						</div>
					</div>
				</div>

				<!-- 전공에 따른 진로 방향 -->
				<div class="col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-bar-chart-o fa-fw"></i>학과 소개
						</div>
						<div class="panel-body" style="width: 100%; height: 750px;">
							<div id="accordion" style="width: 100%; height: 750px;">


								<h3>미디어콘텐츠 학과</h3>
								<div>
									<p>아주대학교 미디어학과는 1998년 한국에서 최초로 설립된 미디어학부를 모체로, 빠르게 변화하는 미디어
										환경에 걸맞은 전문능력을 지닌 글로벌 인재 교육을 위해 2013년 미디어콘텐츠와 소셜미디어로 전공을 나누어
										미디어학과로 출범하게 되었습니다. 최고 수준의 실습 환경과 더불어 미디어학과가 가지는 최고의 경쟁력은 교육을
										수행하는 열네 분의 교수진입니다. 게임, 소프트웨어, 디자인, 영상, 사운드, 사회학 분야의 이론 및 실무
										경력에서 국내/외의 어떤 미디어 관련 학과의 교수진과 비교하여도 손색이 없습니다. 교육환경과 졸업생 취업률
										그리고 교수진의 연구역량 등을 종합적으로 고려할 때 아주대학교 미디어학과는 여러분의 미래를 시대가 요구하는
										융합형 인재상을 준비할 최고의 선택입니다</p>
								</div>

								<h3>졸업 후 진로</h3>
								<div>
									<p>PC, 스마트기기 등의 IT기기와 인간의 상호 작용을 통해 인간의 삶의 질을 높이는데 디지털 콘텐츠가
										사용됩니다. 멀티미디어 소프트웨어, 게임, 3D 애니메이션, 디지털 방송, 디지털 사운드, 스마트 콘텐츠 등을
										포함하며 예술과 기술이 융합하여 창조적 콘텐츠로 만들어지는 것은 이 시대의 문화 코드이면서 미래의 새로운
										부가가치를 이끌어 낼 수 있는 융합 분야입니다.</p>
									<ul>
										<li>세계적 기업 <br> Dreamworks, Disney/Pixar,
											Activision/Blizzard, Nexon, Nintendo, Microsoft, Apple,
											Samsung Electronics
										</li>
										<li>직군 <br>게임기획, 프로그래밍, 아트 디자인 UX, UI 소프트웨어 모바일,
											그래픽스 영상 애니메이션, 영화 사운드 기획, 디자인
										</li>
										<li>취업 <br> 삼성전자, 삼성SDS, LG전자, SK, KT, NHN, Daum,
											NCSoft, Nexon 등 스마트 미디어, 콘텐츠 앱스 개발
										</li>
									</ul>
								</div>

								<h3>MEST란?</h3>
								<div>
									<p>MEST란 미디어(Media), 사용자경험(user Experiences), 스마트 콘텐츠(Smart
										contents), 기술(Technology) 의 약자로서 각 분야에 대한 기술적, 인문학적, 예술적 이해를
										통해서 스마트 시대에 필요한 융합형 창의 인재 양성을 목표로 합니다. MEST는 스마트 미디어 환경에서
										인간중심의 혁신적인 콘텐츠를 기획, 제작에 필요한 역량을 키울 수 있는 교육 프로그램을 제공합니다.</p>
								</div>

								<h3>MEST 교육과정</h3>
								<div>
									<p>Media, Experience, Smart, Technology 과정의 융합을 통해 스마트 미디어를
										주도할 수 있는 융합 커리큘럼을 제공합니다.</p>
									<p>
									<ul>
										<li>디지털미디어, 디자인기초, 애니메이션미학, 게임디자인</li>
										<br>
										<li>UX디자인, 영상연출, 뉴미디어기획, 게임스토리텔링</li>
										<br>
										<li>스마트폰프로그래밍, 미디어앱스프로젝트</li>
										<br>
										<li>객체지향프로그래밍, 컴퓨터그래픽스, 애니메이션이론</li>
									</ul>
								</div>

							</div>
						</div>
					</div>
				</div>
				<!-- /.전공에 따른 진로방향 -->

			</div>
		</div>
	</div>
	
</body>

</html>