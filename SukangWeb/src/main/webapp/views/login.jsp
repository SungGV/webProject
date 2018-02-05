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
.connectedSortable {
	border: 1px solid #eee;
	width: auto;
	max-width: 400px;
	height: 250px;
	max-height: 300px;
	list-style-type: none;
	margin: 0;
	padding: 5px 0 0 0;
	float: left;
	margin-right: 10px;
	overflow-y: scroll;
	overflow-x: hidden;
}

.major_subject {
	margin: 0 5px 5px 5px;
	padding: 5px;
	font-size: 1.0em;
	width: 350px;
	background: #5F9EA0;
}

.selection_subject {
	margin: 0 5px 5px 5px;
	padding: 5px;
	font-size: 1.0em;
	width: 350px;
	background: #ECF1EF;
}

.basic_subject {
	margin: 0 5px 5px 5px;
	padding: 5px;
	font-size: 1.0em;
	width: 350px;
	background: #f0e7c8;
}

.retake_subject {
	margin: 0 5px 5px 5px;
	padding: 5px;
	font-size: 1.0em;
	width: 350px;
	background: #E9967A;
}

.menuFixed {
	position: fixed;
	right: 1%;
	top: 0px;
	width: 510px;
}

#userName {
	border: 0;
}

.timeline-body {
	align: middle;
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
												findRecList();
												findComList();
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





<script type="text/javascript">
	$(document).ready(function() {
		$("#btnGo").click(function() {
			location.href= "/SukangWeb/views/additional.jsp";			
		});
		
		//sortable plugin으로 구현
		$(".connectedSortable").sortable({
			connectWith : ".connectedSortable"
		}).disableSelection();

		var jbOffset = $('.quickmenu1').offset();
		$(window).scroll(function() {
			if ($(document).scrollTop() > jbOffset.top) {
				$('.quickmenu1').addClass('menuFixed');
			} else {
				$('.quickmenu1').removeClass('menuFixed');
			}
		});

		$("#btnDelete").click(function(){
			findRecList2();
		});
		
		
		$("#btnGo2").click(function() {

			var maxCredit = $("#selectCredit").val();

			if (maxCredit == 0) {
				alert("학점을 선택해 주세요");
			} else {
				alert("확인 후 반드시 하단의 저장 버튼을 눌러주세요");
				recAlgorithm();
			}
		});

		$("#btnStore").click(function() {
			
			var ul1 = $("#req1 li");
			var ul2 = $("#req2 li");
			var ul3 = $("#req3 li");
			var ul4 = $("#req4 li");
			var ul5 = $("#req5 li");
			var ul6 = $("#req6 li");
			var ul7 = $("#req7 li");
			var ul8 = $("#req8 li");
			
			if((ul1.length + ul2.length + ul3.length + ul4.length + ul5.length + ul6.length + ul7.length + ul8.length) <= 0){
				alert("저장할 정보가 없습니다.");
				return;
			}
			var totalLis = new Array();
			
			
			
			for(var i=0; i<ul1.length; i++){
				var subject = {};
					
				subject.subjectCode = $(ul1[i]).attr("id");
				subject.semester = "11";
					
				totalLis.push(subject);
			}
			
			for(var i=0; i<ul2.length; i++){
				var subject = {};
					
				subject.subjectCode = $(ul2[i]).attr("id");
				subject.semester = "12";
					
				totalLis.push(subject);
			}
			
			for(var i=0; i<ul3.length; i++){
				var subject = {};
					
				subject.subjectCode = $(ul3[i]).attr("id");
				subject.semester = "21";
					
				totalLis.push(subject);
			}
			
			for(var i=0; i<ul4.length; i++){
				var subject = {};
					
				subject.subjectCode = $(ul4[i]).attr("id");
				subject.semester = "22";
					
				totalLis.push(subject);
			}
			
			
			
			for(var i=0; i<ul5.length; i++){
				var subject = {};
				
				subject.subjectCode = $(ul5[i]).attr("id");
				subject.semester = "31";
				
				totalLis.push(subject);
			}
			
			for(var i=0; i<ul6.length; i++){
				var subject = {};
				subject.subjectCode = $(ul6[i]).attr("id");
				subject.semester = "32";
				totalLis.push(subject);
			}
			
			for(var i=0; i<ul7.length; i++){
				var subject = {};
					
				subject.subjectCode = $(ul7[i]).attr("id");
				subject.semester = "41";
					
				totalLis.push(subject);
			}
			
			for(var i=0; i<ul8.length; i++){
				var subject = {};
					
				subject.subjectCode = $(ul8[i]).attr("id");
				subject.semester = "42";
					
				totalLis.push(subject);
			}
			
			var json = JSON.stringify(totalLis);
			$("#jsonText").val(json);
			
			store();
			

		});
		
		var store = function(){
			$.ajax({
				url : "/SukangWeb/auto/setRecData.do",
				type : "get",
				data : {values : $("#jsonText").val()
					,userId : $("#userId").val()},
				traditional: true,
				success : function() {
					alert("저장되었습니다.");
				},
				error : errorCallback
			});
			
		};
	});
	
	//추천알고리즘
	var recAlgorithm = function() {
		//추천해줘야할 과목들이 UL 안에 li 들로 되어있으므로 모든 li들을 보내줌
		var majorLis = $(".list-group #majorList li");
		var selectionLis = $(".list-group #selectionList li");
		var basicLis = $(".list-group #basiceList li");
		var retakeLis = $(".list-group #retakeList li");
		
		$.ajax({
			url : "/SukangWeb/auto/recAlgorithm.do",
			type : "get",
			data : {
				userId : $("#userId").val()
			},
			success : recMajor,
			error : errorCallback
		});
	};

	//학기별 추천된 과목 총 학점
	var reqCredit1 = 0;
	var reqCredit2 = 0;
	var reqCredit3 = 0;
	var reqCredit4 = 0;
	var reqCredit5 = 0;
	var reqCredit6 = 0;
	var reqCredit7 = 0;
	var reqCredit8 = 0;
	
	
	var recMajor = function(resultData) {
		
		
		$.each(resultData,function(index, item) {
			//전필 먼저 뿌림
			var maxCre = $("#selectCredit").val();
			if(item.classtype == "전필"){
				
				var body = "<li class='major_subject' id='P" + item.subjectCode+"'>"
				+ item.subjectName
				+ "("
				+ item.credit
				+ "/" + item.interest + ")" + "</li>";
				
				var flag = false;
				var semester = Number(item.semester);
				
				
				
				//추천해줄 학기가 있는지 여부를 크기로 비교 하여 넣어준다
				if(semester < 12 && $("#req1").length >0 && flag == false && (reqCredit1 +item.credit) <= maxCre){
					$("#req1").append(body);
					reqCredit1 += item.credit;
					flag = true;
				}
				else if(semester <13 && $("#req2").length>0 && flag == false && (reqCredit2 +item.credit) <= maxCre){
					$("#req2").append(body);
					reqCredit2 += item.credit;
					flag = true;
				}
				else if(semester <22 && $("#req3").length>0 && flag == false && (reqCredit3+item.credit) <= maxCre){
					$("#req3").append(body);
					reqCredit3 += item.credit;
					flag = true;
				}
				else if(semester <23 && $("#req4").length>0 && flag == false && (reqCredit4 +item.credit) <= maxCre){
					$("#req4").append(body);
					reqCredit4 += item.credit;
					flag = true;
				}
				else if(semester <32 && $("#req5").length>0 && flag == false && (reqCredit5 +item.credit) <= maxCre){
					$("#req5").append(body);
					reqCredit5 += item.credit;
					flag = true;
				}
				else if(semester <33 && $("#req6").length>0 && flag == false && (reqCredit6 +item.credit) <= maxCre){
					$("#req6").append(body);
					reqCredit6 += item.credit;
					flag = true;
				}
				else if(semester < 42 && $("#req7").length>0 && flag == false && (reqCredit7 +item.credit) <= maxCre){
					$("#req7").append(body);
					reqCredit7 += item.credit;
					flag = true;
				}
				else if(semester <43 && $("#req8").length>0 && flag == false && (reqCredit8 +item.credit) <= maxCre){
					$("#req8").append(body);
					reqCredit8 += item.credit;
					flag = true;
				}
				
				//추천학기로 이동한 과목에 대하여 삭제.
				if(flag == true){
				$("#" + item.subjectCode).remove();
				}
			}
			
			
			
			//기초과목
			else if(item.classtype == "기초"){
				var maxCre = $("#selectCredit").val();
				var body = "<li class='basic_subject' id='P" + item.subjectCode+"'>"
				+ item.subjectName
				+ "("
				+ item.credit
				+ "/" + item.interest + ")" + "</li>";
				
				var flag = false;
				var semester = Number(item.semester);
				
				//추천해줄 학기가 있는지 여부를 크기로 비교 하여 넣어준다
				if(semester < 12 && $("#req1").length >0 && flag == false && (reqCredit1 +item.credit) <= maxCre){
					$("#req1").append(body);
					reqCredit1 += item.credit;
					flag = true;
				}
				else if(semester <13 && $("#req2").length>0 && flag == false && (reqCredit2 +item.credit) <= maxCre){
					$("#req2").append(body);
					reqCredit2 += item.credit;
					flag = true;
				}
				else if(semester <22 && $("#req3").length>0 && flag == false && (reqCredit3 +item.credit) <= maxCre){
					$("#req3").append(body);
					reqCredit3 += item.credit;
					flag = true;
				}
				else if(semester <23 && $("#req4").length>0 && flag == false && (reqCredit4 +item.credit) <= maxCre){
					$("#req4").append(body);
					reqCredit4 += item.credit;
					flag = true;
				}
				else if(semester <32 && $("#req5").length>0 && flag == false && (reqCredit5 +item.credit) <= maxCre){
					$("#req5").append(body);
					reqCredit5 += item.credit;
					flag = true;
				}
				else if(semester <33 && $("#req6").length>0 && flag == false && (reqCredit6 +item.credit) <= maxCre){
					$("#req6").append(body);
					reqCredit6 += item.credit;
					flag = true;
				}
				else if(semester < 42 && $("#req7").length>0 && flag == false && (reqCredit7 +item.credit) <= maxCre){
					$("#req7").append(body);
					reqCredit7 += item.credit;
					flag = true;
				}
				else if(semester <43 && $("#req8").length>0 && flag == false && (reqCredit8 +item.credit) <= maxCre){
					$("#req8").append(body);
					reqCredit8 += item.credit;
					flag = true;
				}
				
				//추천학기로 이동한 과목에 대하여 삭제.
				if(flag == true){
				$("#" + item.subjectCode).remove();
				}
			}
			
			
		});
		
		recSelection(resultData);
		
	}

	var recSelection = function(resultData){
		var maxCre = $("#selectCredit").val();
		//전선과목
		$.each(resultData,function(index, item) {
		if(item.classtype == "전선"){
			
			var body = "<li class='selection_subject' id='P" + item.subjectCode+"'>"
			+ item.subjectName
			+ "("
			+ item.credit
			+ "/" + item.interest + ")" + "</li>";
			
			var flag = false;
			var semester = Number(item.semester);
			
			
			
			//추천해줄 학기가 있는지 여부를 크기로 비교 하여 넣어준다(넣을때마다 maxCredit을 증가시켜줘야함.)
			//if문 안에 maxCredit을 초과햇는지 여부를 확인함
			if(semester < 12 && $("#req1").length >0 && flag == false && (reqCredit1 +item.credit) <= maxCre){
				$("#req1").append(body);
				reqCredit1 += item.credit;
				flag = true;
			}
			else if(semester <13 && $("#req2").length>0 && flag == false && (reqCredit2 +item.credit)<= maxCre){
				$("#req2").append(body);
				reqCredit2 += item.credit;
				flag = true;
			}
			else if(semester <22 && $("#req3").length>0 && flag == false && (reqCredit3 +item.credit)<= maxCre){
				$("#req3").append(body);
				reqCredit3 += item.credit;
				flag = true;
			}
			else if(semester <23 && $("#req4").length>0 && flag == false && (reqCredit4 +item.credit) <= maxCre){
				$("#req4").append(body);
				reqCredit4 += item.credit;
				flag = true;
			}
			else if(semester <32 && $("#req5").length>0 && flag == false && (reqCredit5 +item.credit)<= maxCre){
				$("#req5").append(body);
				reqCredit5 += item.credit;
				flag = true;
			}
			else if(semester <33 && $("#req6").length>0 && flag == false && (reqCredit6+item.credit) <= maxCre){
				$("#req6").append(body);
				reqCredit6 += item.credit;
				flag = true;
			}
			else if(semester < 42 && $("#req7").length>0 && flag == false && (reqCredit7 +item.credit)<= maxCre){
				$("#req7").append(body);
				reqCredit7 += item.credit;
				flag = true;
			}
			else if(semester <43 && $("#req8").length>0 && flag == false && (reqCredit8 +item.credit)<= maxCre){
				$("#req8").append(body);
				reqCredit8 += item.credit;
				flag = true;
			}
			
			//추천학기로 이동한 과목에 대하여 삭제.
			if(flag == true){
			$("#" + item.subjectCode).remove();
			}
		}
		
		});
		
	};
	
	
	
	
	//수료한 과목 
	var findComList = function() {
		
		$.ajax({
			url : "/SukangWeb/auto/findComList.do",
			type : "get",
			data : {
				userId : $("#userId").val()
			},
			success : findComSemester,
			error : errorCallback
		});
	};

	var findComSemester = function(resultData) {

		var body = "";
		var sem0 = 0;
		var sem1 = 0;
		var sem2 = 0;
		var sem3 = 0;
		var sem4 = 0;
		var sem5 = 0;
		var sem6 = 0;
		var sem7 = 0;
		var sem8 = 0;

		$("#comSemester").empty();
		$.each(resultData, function(index, item) {

			var reqBody = "";
			$("#timeline").empty();

			if (item.completedSemester == 11 && item.retake != 1) {
				sem1 = 1;
			} else if (item.completedSemester == 12 && item.retake != 1) {
				sem2 = 1;
			} else if (item.completedSemester == 21 && item.retake != 1) {
				sem3 = 1;
			} else if (item.completedSemester == 22 && item.retake != 1) {
				sem4 = 1;
			} else if (item.completedSemester == 31 && item.retake != 1) {
				sem5 = 1;
			} else if (item.completedSemester == 32 && item.retake != 1) {
				sem6 = 1;
			} else if (item.completedSemester == 41 && item.retake != 1) {
				sem7 = 1;
			} else if (item.completedSemester == 42 && item.retake != 1) {
				sem8 = 1;

			} else {
				sem0 = 1;

			}
		});
		var tablebody = "";
		$.each(resultData, function(index, item) {

			if (sem1 == 1) {
				tablebody = tbodyTemplate.makeTable("sem1", "1-1 학기");
			}
			if (sem2 == 1) {
				tablebody += tbodyTemplate.makeTable("sem2", "1-2 학기");
			}
			if (sem3 == 1) {
				tablebody += tbodyTemplate.makeTable("sem3", "2-1 학기");
			}
			if (sem4 == 1) {
				tablebody += tbodyTemplate.makeTable("sem4", "2-2 학기");
			}
			if (sem5 == 1) {
				tablebody += tbodyTemplate.makeTable("sem5", "3-1 학기");
			}
			if (sem6 == 1) {
				tablebody += tbodyTemplate.makeTable("sem6", "3-2 학기");
			}
			if (sem7 == 1) {
				tablebody += tbodyTemplate.makeTable("sem7", "4-1 학기");
			}
			if (sem8 == 1) {
				tablebody += tbodyTemplate.makeTable("sem8", "4-2 학기");
			}
		});

		//추천학기 테이블
		//수료한 학기가 없을 경우
		if (sem8 == 0 && sem7 == 0 && sem6 == 0 && sem5 == 0 && sem4 == 0
				&& sem3 == 0 && sem2 == 0 && sem1 == 0) {
			reqBody = tbodyTemplate.makeLiLeft1("1", "1")
					+ tbodyTemplate.makeLiRight2("2")
					+ tbodyTemplate.makeLiLeft1("3", "2")
					+ tbodyTemplate.makeLiRight2("4")
					+ tbodyTemplate.makeLiLeft1("5", "3")
					+ tbodyTemplate.makeLiRight2("6")
					+ tbodyTemplate.makeLiLeft1("7", "4")
					+ tbodyTemplate.makeLiRight2("8");
			$("#timeline").append(reqBody);
		}
		//1-1학기 수료
		else if (sem8 == 0 && sem7 == 0 && sem6 == 0 && sem5 == 0 && sem4 == 0
				&& sem3 == 0 && sem2 == 0) {
			reqBody = tbodyTemplate.makeLiRight1("2", "1")
					+ tbodyTemplate.makeLiLeft1("3", "2")
					+ tbodyTemplate.makeLiRight2("4")
					+ tbodyTemplate.makeLiLeft1("5", "3")
					+ tbodyTemplate.makeLiRight2("6")
					+ tbodyTemplate.makeLiLeft1("7", "4")
					+ tbodyTemplate.makeLiRight2("8");
			$("#timeline").append(reqBody);
		}
		//1-1, 1-2 수료
		else if (sem8 == 0 && sem7 == 0 && sem6 == 0 && sem5 == 0 && sem4 == 0
				&& sem3 == 0) {
			reqBody = tbodyTemplate.makeLiLeft1("3", "2")
					+ tbodyTemplate.makeLiRight2("4")
					+ tbodyTemplate.makeLiLeft1("5", "3")
					+ tbodyTemplate.makeLiRight2("6")
					+ tbodyTemplate.makeLiLeft1("7", "4")
					+ tbodyTemplate.makeLiRight2("8");
			$("#timeline").append(reqBody);
		}
		//1-1, 1-2, 2-1 수료
		else if (sem8 == 0 && sem7 == 0 && sem6 == 0 && sem5 == 0 && sem4 == 0) {
			reqBody = tbodyTemplate.makeLiRight1("4", "2")
					+ tbodyTemplate.makeLiLeft1("5", "3")
					+ tbodyTemplate.makeLiRight2("6")
					+ tbodyTemplate.makeLiLeft1("7", "4")
					+ tbodyTemplate.makeLiRight2("8");
			$("#timeline").append(reqBody);
		}
		//1-1, 1-2, 2-1, 2-2 수료
		else if (sem8 == 0 && sem7 == 0 && sem6 == 0 && sem5 == 0) {
			reqBody = tbodyTemplate.makeLiLeft1("5", "3")
					+ tbodyTemplate.makeLiRight2("6")
					+ tbodyTemplate.makeLiLeft1("7", "4")
					+ tbodyTemplate.makeLiRight2("8");
			$("#timeline").append(reqBody);
		}
		//1-1 ~ 3-1 수료
		else if (sem8 == 0 && sem7 == 0 && sem6 == 0) {
			reqBody = tbodyTemplate.makeLiRight1("6", "3")
					+ tbodyTemplate.makeLiLeft1("7", "4")
					+ tbodyTemplate.makeLiRight2("8");
			$("#timeline").append(reqBody);
		}
		//1-1 ~ 3-2 수료
		else if (sem8 == 0 && sem7 == 0) {
			reqBody = tbodyTemplate.makeLiLeft1("7", "4")
					+ tbodyTemplate.makeLiRight2("8");
			$("#timeline").append(reqBody);
		}
		//1-1 ~ 4-1 수료
		else if (sem8 == 0) {
			reqBody = tbodyTemplate.makeLiRight1("8", "4");
			$("#timeline").append(reqBody);
		}
		//전체 다 수료
		else {
			reqBody = "모든 학기를 이수하셨습니다 ! ";
			$("#timeline").append(reqBody);
		}

		$(".connectedSortable").sortable({
			connectWith : ".connectedSortable"
		}).disableSelection();

		$("#comSemester").append(tablebody);

		findComplementList(resultData);
	};

	var findComplementList = function(resultData) {

		var body = "";

		$("#sem1").empty();
		$("#sortable4").empty();

		$.each(resultData, function(index, item) {
			if (item.completedSemester == 0) {
				var tbody = "이수한 학기가 없습니다.";
				$("#comSemester").append(tbody);

			}
			if (item.completedSemester == 11) {
				var tbody = tbodyTemplate.makeTbody(index, item);
				$("#sem1").append(tbody);

			}
			if (item.completedSemester == 12) {
				var tbody = tbodyTemplate.makeTbody(index, item);
				$("#sem2").append(tbody);

			}
			if (item.completedSemester == 21) {
				var tbody = tbodyTemplate.makeTbody(index, item);
				$("#sem3").append(tbody);

			}
			if (item.completedSemester == 22) {
				var tbody = tbodyTemplate.makeTbody(index, item);
				$("#sem4").append(tbody);

			}
			if (item.completedSemester == 31) {
				var tbody = tbodyTemplate.makeTbody(index, item);
				$("#sem5").append(tbody);

			}
			if (item.completedSemester == 32) {
				var tbody = tbodyTemplate.makeTbody(index, item);
				$("#sem6").append(tbody);

			}
			if (item.completedSemester == 41) {
				var tbody = tbodyTemplate.makeTbody(index, item);
				$("#sem7").append(tbody);

			}
			if (item.completedSemester == 42) {
				var tbody = tbodyTemplate.makeTbody(index, item);
				$("#sem8").append(tbody);

			}

			//재수강
			if (item.retake == "1") {
				var body = "<li class='retake_subject' id='P" + item.subject.subjectCode + "'>"
						+ item.subject.subjectName + "(" + item.subject.credit
						+ "/" + item.year + ")" + "</li>";
				$("#sortable4").append(body);
			}

		});

	};
	//End 수료한 과목

	//과목리스트
	var findRecList2 = function() {
		$.ajax({
			url : "/SukangWeb/auto/reqList.do",
			type : "get",
			data : {
				userId : $("#userId").val()
			},
			success : findRec2,
			error : errorCallback
		});
	};

	var findRec2 = function(resultData) {

		$("#sortable1").empty();
		$("#sortable2").empty();
		$("#sortable3").empty();
		$("#req1").empty();
		$("#req2").empty();
		$("#req3").empty();
		$("#req4").empty();
		$("#req5").empty();
		$("#req6").empty();
		$("#req7").empty();
		$("#req8").empty();
		reqCredit1 = 0;
		reqCredit2 = 0;
		reqCredit3 = 0;
		reqCredit4 = 0;
		reqCredit5 = 0;
		reqCredit6 = 0;
		reqCredit7 = 0;
		reqCredit8 = 0;

		$.each(resultData,function(index, item) {

							if (item.classtype == "전필") {
								var body = "<li class='major_subject' id='" + item.subjectCode+"'>"
										+ item.subjectName
										+ "("
										+ item.credit
										+ "/" + item.interest + ")" + "</li>";
								$("#sortable1").append(body);
							}
							if (item.classtype == "전선") {
								var body = "<li class='selection_subject' id='" + item.subjectCode+"'>"
										+ item.subjectName
										+ "("
										+ item.credit
										+ "/" + item.interest + ")" + "</li>";
								$("#sortable2").append(body);
							}
							if (item.classtype == "기초") {
								var body = "<li class='basic_subject' id='" + item.subjectCode+"'>"
										+ item.subjectName
										+ "("
										+ item.credit
										+ "/" + item.interest + ")" + "</li>";
								$("#sortable3").append(body);
							}
							
						});
	
	};
	

	//과목리스트
	var findRecList = function() {
		$.ajax({
			url : "/SukangWeb/auto/reqList.do",
			type : "get",
			data : {
				userId : $("#userId").val()
			},
			success : findRec,
			error : errorCallback
		});
	};

	var findRec = function(resultData) {

		$("#sortable1").empty();
		$("#sortable2").empty();
		$("#sortable3").empty();

		$.each(resultData,function(index, item) {

							if (item.classtype == "전필") {
								var body = "<li class='major_subject' id='" + item.subjectCode+"'>"
										+ item.subjectName
										+ "("
										+ item.credit
										+ "/" + item.interest + ")" + "</li>";
								$("#sortable1").append(body);
							}
							if (item.classtype == "전선") {
								var body = "<li class='selection_subject' id='" + item.subjectCode+"'>"
										+ item.subjectName
										+ "("
										+ item.credit
										+ "/" + item.interest + ")" + "</li>";
								$("#sortable2").append(body);
							}
							if (item.classtype == "기초") {
								var body = "<li class='basic_subject' id='" + item.subjectCode+"'>"
										+ item.subjectName
										+ "("
										+ item.credit
										+ "/" + item.interest + ")" + "</li>";
								$("#sortable3").append(body);
							}
							
						});
		showSavedSubjects();
		
	};
	//기존 추천된 과목 뿌려주기
	var showSavedSubjects = function(){
		$.ajax({
			url : "/SukangWeb/auto/showSaved.do",
			type : "get",
			data : {},
			success : getSavedSubject,
			error : errorCallback
		});
	};
	
	var getSavedSubject = function(resultData){
		
		
		$.each(resultData,function(index, item) {
			
			//추천학기로 이동한 과목에 대하여 삭제.
			$("#" + item.subjectCode).remove();
			
			if(item.classtype =="전필"){
				
				var body = "<li class='major_subject' id='P" + item.subjectCode+"'>"
				+ item.subjectName
				+ "("
				+ item.credit
				+ "/" + item.interest + ")" + "</li>";
			}
			else if(item.classtype =="전선"){
				var body = "<li class='selection_subject' id='P" + item.subjectCode+"'>"
				+ item.subjectName
				+ "("
				+ item.credit
				+ "/" + item.interest + ")" + "</li>";
			}
			else{
				var body = "<li class='basic_subject' id='P" + item.subjectCode+"'>"
				+ item.subjectName
				+ "("
				+ item.credit
				+ "/" + item.interest + ")" + "</li>";
				
			}

			if(item.semester =="11"){
				$("#req1").append(body);
				reqCredit1 += item.credit;
			}
			else if(item.semester =="12"){
				$("#req2").append(body);
				reqCredit2 += item.credit;
			}
			else if(item.semester =="12"){
				$("#req3").append(body);
				reqCredit3 += item.credit;
			}
			else if(item.semester =="21"){
				$("#req3").append(body);
				reqCredit3 += item.credit;
			}
			else if(item.semester =="22"){
				$("#req4").append(body);
				reqCredit4 += item.credit;
			}
			else if(item.semester =="31"){
				$("#req5").append(body);
				reqCredit5 += item.credit;
			}
			else if(item.semester =="32"){
				$("#req6").append(body);
				reqCredit6 += item.credit;
			}
			else if(item.semester =="41"){
				$("#req7").append(body);
				reqCredit7 += item.credit;
			}
			else if(item.semester =="42"){
				$("#req8").append(body);
				reqCredit8 += item.credit;
			}
			});
	};
	
	
	var errorCallback = function() {
		//alert("실행 중 오류가 발생했습니다.");
		location.href="${pageContext.request.contextPath}/views/error.jsp";
	};

	//Template
	var tbodyTemplate = {
		makeTbody : function(index, report) {
			var body = "<tr>" + "<td>" + (index + 1) + "</td>" + "<td>"
					+ report.subject.subjectName + "</td>" + "<td>"
					+ report.subject.classtype + "</td>" + "<td>"
					+ report.subject.interest + "</td>" + "<td>"
					+ report.subject.credit + "</td>" + "</tr>";
			return body;

		},

		makeTable : function(idNum, completedSem) {
			var body = "<div class='col-lg-6'>"
					+ "<div class='panel panel-default'>"
					+ "<div class='panel-heading'>"
					+ completedSem
					+ " 수료</div>"
					+ "<div class='table-responsive'>"
					+ "<table class='table table-striped table-bordered table-hover' >"
					+ "<thead> <tr> <th>순번</th> <th>과목명</th> <th>학수구분</th> <th>심화구분</th> <th>학점</th>"
					+ "</tr> </thead>" + "<tbody id='" + idNum +  "'>"
					+ "</tbody>" + "</table>" + "</div> </div> </div>";

			return body;
		},

		//1이 학년이 있는 경우
		makeLiLeft1 : function(reqNum, year) {
			var body = "<li>"
					+ "<div class='timeline-badge info'>"
					+ "<i class='fa fa-save'>"
					+ year
					+ "</i>"
					+ "</div>"
					+ "<div class='timeline-panel'>"
					+ "<div class='timeline-heading'> "
					+ "<h4 class='timeline-title'> 1학기 </h4>"
					/* + "<p><small class='text-muted'><i class='fa fa-clock-o'></i>"
					+ 총 18 학점추천(전필/전선/기초/재수강)+ "</small> </p>" */
					+ "</div> <div class='timeline-body'>"
					+ "<ul id='req" + reqNum + "' class='connectedSortable ui-sortable'>"
					+ "</ul> </div> </div> </li>";

			return body;
		},

		makeLiLeft2 : function(reqNum) {
			var body = "<li>"
					+ "<div class='timeline-panel'>"
					+ "<div class='timeline-heading'> "
					+ "<h4 class='timeline-title'> 1학기 </h4>"
					/* + "<p><small class='text-muted'><i class='fa fa-clock-o'></i>"
					+ 총 18 학점추천(전필/전선/기초/재수강)+ "</small> </p>" */
					+ "</div> <div class='timeline-body'>"
					+ "<ul id='req" + reqNum + "' class='connectedSortable ui-sortable'>"
					+ "</ul> </div> </div> </li>";

			return body;
		},

		makeLiRight1 : function(reqNum, year) {
			var body = "<li class='timeline-inverted'>"
					+ "<div class='timeline-badge info'>"
					+ "<i class='fa fa-save'>"
					+ year
					+ "</i>"
					+ "</div>"
					+ "<div class='timeline-panel'>"
					+ "<div class='timeline-heading'> "
					+ "<h4 class='timeline-title'> 2학기 </h4>"
					/* + "<p><small class='text-muted'><i class='fa fa-clock-o'></i>"
					+ 총 18 학점추천(전필/전선/기초/재수강)+ "</small> </p>" */
					+ "</div> <div class='timeline-body'>"
					+ "<ul id='req" + reqNum + "' class='connectedSortable ui-sortable'>"
					+ "</ul> </div> </div> </li>";

			return body;
		},

		makeLiRight2 : function(reqNum) {
			var body = "<li class='timeline-inverted'>"
					+ "<div class='timeline-panel'>"
					+ "<div class='timeline-heading'> "
					+ "<h4 class='timeline-title'> 2학기 </h4>"
					/* + "<p><small class='text-muted'><i class='fa fa-clock-o'></i>"
					+ 총 18 학점추천(전필/전선/기초/재수강)+ "</small> </p>" */
					+ "</div> <div class='timeline-body'>"
					+ "<ul id='req" + reqNum + "' class='connectedSortable ui-sortable'>"
					+ "</ul> </div> </div> </li>";

			return body;
		}

	};
</script>


<title>자동 추천</title>
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
							<input type="hidden" id="jsonText">
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
					<h1 class="page-header">자 동 추 천</h1>
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
					<div class="panel panel-yellow">
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

			<div class="row">

				<!-- 메인 화면 바뀌는 div 부분-->

				<!--  ------------------수료학기 -------------------- -->
				<div class="col-lg-8">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-bar-chart-o fa-fw">수료 학기</i>
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body" id="comSemester"></div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->



					<!--  ------------------ 추천학기 -------------------- -->


					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-clock-o fa-fw">학기추천</i>
							<div class="pull-right">

								<select name="" style="width: 100px;" id="selectCredit">
									<option value="0">학점선택</option>
									<option value="9">9학점</option>
									<option value="11">11학점</option>
									<option value="13">13학점</option>
									<option value="15">15학점</option>
									<option value="17">17학점</option>
									<option value="19">19학점</option>
									<option value="21">21학점</option>
									<option value="23">23학점</option>
								</select>
								<button type="button" class="btn btn-info btn-circle" id="btnGo2">
									go</button>
									<button type="button" class="btn btn-info btn-circle" id="btnDelete">
									delete</button>

							</div>
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">

							<!--  타임라인 시작 -->
							<ul class="timeline" id="timeline">

							</ul>
							<button type="button" class="btn btn-primary btn-lg btn-block"
								id="btnStore">저 장 하 기</button>
						</div>
						<!-- /.panel-body -->

					</div>
					<!--  </.panel panel-default -->
				</div>
				<!-- /.col-lg-8 -->

				<!-- ---------- 과목 리스트 --------- -->
				<div class="col-lg-4">
					<div class="quickmenu1">
						<div class="panel panel-default">

							<div class="panel-heading">
								<i class="fa fa-bell fa-fw">과목리스트</i>
							</div>
							<!-- /.panel-heading -->
							<div class="panel-body" style="overflow: scroll; height: 1000px;">

								<div class="list-group">
									<table class="listTable">
										<tr>
											<th>전 공 필 수</th>
										</tr>
										<tr>
											<td id="majorList">
												<ul id="sortable1" class="connectedSortable">

												</ul>
											</td>
										</tr>

									</table>
									<br>
									<table class="listTable">
										<tr>
											<th>전 공 선 택</th>
										</tr>
										<tr>
											<td id="selectionList">
												<ul id="sortable2" class="connectedSortable">

												</ul>
											</td>
										</tr>

									</table>
									<br>
									<table class="listTable">
										<tr>
											<th>기 초 과 목</th>
										</tr>
										<tr>
											<td id="basicList">
												<ul id="sortable3" class="connectedSortable">

												</ul>
											</td>
										</tr>

									</table>
									<br>
									<table class="listTable">
										<tr>
											<th>재 수 강</th>
										</tr>
										<tr>
											<td id="retakeList">
												<ul id="sortable4" class="connectedSortable">

												</ul>
											</td>
										</tr>

									</table>
								</div>
								<!-- /.list-group -->

							</div>
							<!--  /.quickmenu1 -->
						</div>
						<!-- /.panel-body -->
					</div>


					<!-- /.panel panel-default -->
				</div>
				<!-- /.col-lg-4 -->

			</div>
			<!-- /.row -->
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
</body>
</html>