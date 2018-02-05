<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>추가 정보</title>
  
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

<!-- Bootstrap Core JavaScript -->
<script
	src="${pageContext.request.contextPath}/resource/js/bootstrap.min.js"></script>

<style>
.btn-warning{
	background-color: #eea236;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	
	
	showOrign();
	
	
	$("#ipMajorStatus").val($("input[name='majorStatus']:checked").val());
	
	// 커밋확인 버튼
	$("#idSubmit").click(function() {
		if(validate() == true) {
			$("#ipStudentId").val($("#idStudentId").val());
			$("#idForm").submit();
		}			
	});
	
	var validate = function() {
		if($("#selectSchool").val() == "n") {
			alert("학교를 선택해주세요");
			return false;
		}
	 	if($("#idStudentId").val() == "") {
			alert("학번을 입력해주세요");
			return false;
		} 
		if($("#selectDepart").val() == "majorNull") {
			alert("학부를 입력해주세요");
			return false;
		}
		if($("#selectAdmission").val() == "adminNull") {
			alert("입학년도를 입력해주세요");
			return false;
		}
		if($("#compSemester").val() == "n") {
			alert("이수학기를 입력해주세요");
			return false;
		}
		if($("#interest").val() == "n") {
			alert("관심사를 입력해주세요");
			return false;
		}
		return true;
	}
	
	 $("#selectSchool").change(function() {
		 $("#ipSchool").val($(this).val());
		sortingDepartment();
	});
	 
	 $("#selectDepart").change(function() {
		 $("#ipMajor").val($(this).val());
		 sortingInterest();
	});
	 $("#selectAdmission").change(function() {
		 $("#ipAdmin").val($(this).val());
		 if($("#interest").val() == 'n') {
			 $("#interest").empty();
			 sortingInterest();
	 }
		
	});
	 
	 $("#compSemester").change(function() {
			$("#ipCompSemester").val($(this).val());
	});
	 
	 
	  $("#idDoubleMajor").change(function() {
		  if($("#selectSchool").val() =='n' ||  $("#selectDepart").val()=='majorNull'||  $("#selectAdmission").val() =='adminNull') {
			  alert("학교, 학부, 또는 입학년도를 먼저 선택해주세요");
			  $('#idInterest').prop('checked', true);	  
		  }
		  else {
			  doubleMajorClicked();
			  $("#ipMajorStatus").val($(this).val());
		  }
		  
	});
	 $("#idMinor").change(function() {
		 if($("#selectSchool").val() =='n' ||  $("#selectDepart").val()=='majorNull'||  $("#selectAdmission").val() =='adminNull') {
			  alert("학교, 학부, 또는 입학년도를 먼저 선택해주세요");
			  $('#idInterest').prop('checked', true);	  
		  }
		 else {
			 doubleMajorClicked();
			 $("#ipMajorStatus").val($(this).val());
		 }
	});
	 $("#idTransfer").change(function() {
		 if($("#selectSchool").val() =='n' ||  $("#selectDepart").val()=='majorNull'||  $("#selectAdmission").val() =='adminNull') {
			  alert("학교, 학부, 또는 입학년도를 먼저 선택해주세요");
			  $('#idInterest').prop('checked', true);	  
		  }
		 else {
			
			 sortingInterest();
			 $("#ipMajorStatus").val($(this).val());
		 }
	});
	 $("#idInterest").change(function() {
		
		 sortingInterest();
		 $("#ipMajorStatus").val($(this).val());	
	}); 
	 
	//var checked = $("input[name='majorStatus']:checked");
	 
	 $("#doubleMajorDepart").change(function() {
		 $("#ipAdditionalMajor").val($(this).val());
	});
	 $("#interest").change(function() {
		 $("#ipInterest").val($(this).val());
	});
	
	 
	 
	
});

	var showOrign = function() {
		$.ajax({
			url:"/SukangWeb/showOriginalInfo2.do"
			,type:"get"
			,data: {}
			,success: showOrignCallback
			,error: errorCallback
		});
	}

	var showOrignCallback = function(resultData){
		
		$("#selectSchool").val(resultData.college);
		$("#ipSchool").val(resultData.college);
		$("#idStudentId").val(resultData.admission);
		$("#ipStudentId").val(resultData.admission);
		
		sortingDepartment();
		
	};
	
	
	var doubleMajorClicked = function() {
		$.ajax({
			url:"/SukangWeb/addInfo.do"
			,type:"get"
			,data: {
				college: $("#selectSchool").val()
				,userMajor: $("#selectDepart").val()
				,userAdminYear: $("#selectAdmission").val()
				,majorStatus: $("input[name='majorStatus']:checked").val()
			}
			,success: sendDoubleMajorSelect
			,error: errorCallback
		});
	}
	
	var sendDoubleMajorSelect = function(resultData) {
	 	$("#doubleMajorDepart").empty();
		var cc = "";
		$.each(resultData.showMajor, function(index, item) {		
			 cc += "<option>" + item + "</option>";		
		});
		
		var insertStatement = "<option>추가전공 학과를 선택하세요</option>";
		$("#doubleMajorDepart").append(insertStatement);
		$("#doubleMajorDepart").append(cc); 
		
	}
	

  var sortingInterest = function() {
	$.ajax({
		url:"/SukangWeb/addInfo.do"
		,type:"get"
		,data: {
			userMajor: $("#selectDepart").val()
			,userAdminYear: $("#selectAdmission").val()
			,majorStatus: $("input[name='majorStatus']:checked").val()
		}
		,success:sortingInterestSuccessCallback
		,error: error
	});
}  

  var error = function() {
	  alert("학교 또는 학부를 먼저 입력해 주세요");
  }
  
  var sortingInterestSuccessCallback = function(resultData) {
	 console.log("추가학과는 " + resultData.majorStatus)
	   	if(resultData.majorStatus =="편입" || resultData.majorStatus =="전공심화") {
	   		console.log("여기는 편입 전공심화")
	   		$("#doubleMajorDepart").empty();
			var insertStatement = "<option>해당하는 학과가 없습니다</option>";
			$("#doubleMajorDepart").append(insertStatement); 
	   	}
	   	
		 console.log("학과는 " + resultData.userMajor);
		 console.log("입학년도" + resultData.userAdminYear);
		 console.log("추가전공여부" + resultData.majorStatus);
		
		if(resultData.userMajor != "" && resultData.userAdminYear != "" && resultData.userAdminYear != "adminNull" && resultData.majorStatus != "") {
			console.log("통과됏니?");
			$("#interest").empty();
			var tt = "";
			$.each(resultData.interest, function(index, item) {		
				 tt +=  "<option>" + item + "</option>";		
			});
			var insertStatement = "<option id='interest' value='n'>관심사를 선택하세요</option>";
			
			$("#interest").append(insertStatement);
			$("#interest").append(tt);
		}
		
  }
  

var sortingDepartment = function() {
	
	$.ajax({
		url:"/SukangWeb/addInfo3.do"
		,type:"get"
		,data: {
			college: $("#selectSchool").val()
		}
		,success: sortingSuccessCallback
		,error: errorCallback
	});
	
};
var sortingSuccessCallback = function(resultData) {
	$("#selectDepart").empty();
	var aa = "";
	
	$.each(resultData.showMajor, function(index, item) {
		 aa +=  "<option>" + item + "</option>";
	});
	var insertStatement = "<option value='majorNull'>학과를 선택하세요</option>";

	
	$("#selectDepart").append(insertStatement);
	$("#selectDepart").append(aa);
	$("#selectDepart").val(resultData.userMajor);
	$("#ipMajor").val(resultData.userMajor);

	$("#selectAdmission").empty();
	var bb = "";
	$.each(resultData.showYear, function(index, item) {
		 bb += "<option>" + item + "</option>";		
	});
	
	var insertStatement = "<option value='adminNull'>입학년도를 선택하세요</option>";
	
	$("#selectAdmission").append(insertStatement);
	$("#selectAdmission").append(bb);
	$("#selectAdmission").val(resultData.userAdminYear);
	$("#ipAdmin").val(resultData.userAdminYear);

	$("#doubleMajorDepart").empty();
	var insertStatement = "<option>해당하는 학과가 없습니다</option>";
	$("#doubleMajorDepart").append(insertStatement); 
	$("#compSemester").val(resultData.comSemester);
	$("#ipCompSemester").val(resultData.comSemester);
	
	interestBody ="";
	$("#interest").empty();
	$.each(resultData.interest, function(index, item) {
		interestBody += "<option>" + item + "</option>";		
	});
	
	$("#interest").append(interestBody);
	$("#interest").val(resultData.userInterest);
	$("#ipInterest").val(resultData.userInterest);
	
}
var errorCallback = function() {
	alert("처리중 오류가 발생했습니다");
};


</script>	
</head>

<body>

	<div class="container">
		<div class="row">
			<div class="col-md-5 col-md-offset-4">
				<div class="login-panel panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">추가 정보 입력</h3> 
						
						
					</div>
					<div class="panel-body">
						<form role="form">
							<fieldset>
								<div class="form-group">
									<label>학&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;교&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;</label> 
									<select id="selectSchool">
										<option value="n">학교를 선택해주세요</option>
										<option value="bs">백석대학교</option>
										<option value="AJ">아주대학교</option>
										<option value="su">서울대학교</option>
										<option value="ks">카이스트</option>
										<option value="GV">Grand Valley</option>
									</select>
								</div>
								<div class="form-group">
									<label>학&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;번&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp; </label> 
									<input id="idStudentId" type="text">
								</div>
								<div class="form-group">
									<label>학&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;부&nbsp;&nbsp;&nbsp;&nbsp; :  &nbsp;&nbsp;&nbsp; </label> 
									<select id="selectDepart">
										<option value="n">학과를 선택해주세요</option>
									</select>
								</div>
								<div class="form-group">
									<label>입&nbsp; 학&nbsp; 년&nbsp; 도&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;</label> 
									<select id="selectAdmission">
										<option value="na">입학년도를 선택해주세요</option>
									</select>
								</div>
								<div class="form-group">
									<label>이&nbsp; 수&nbsp; 학&nbsp; 기 &nbsp;&nbsp;: &nbsp;&nbsp;&nbsp;</label> 
									<select id="compSemester">
										<option value="n">학기를 선택해주세요</option>
										<option value="11">1학년 1학기</option>
										<option value="12">1학년 2학기</option>
										<option value="21">2학년 1학기</option>
										<option value="22">2학년 2학기</option>
										<option value="31">3학년 1학기</option>
										<option value="32">3학년 2학기</option>
										<option value="41">4학년 1학기</option>
										<option value="42">4학년 2학기</option>
									</select>
								</div>
								<div class="form-group">
									<label>추 가&nbsp; 전 공&nbsp; 여 부 :</label> <br> <label
										class="checkbox-inline"> <input type="radio" id="idDoubleMajor"
										value="1" name="majorStatus"> 복수 전공
									</label> <label class="checkbox-inline"> <input type="radio"
										id="idMinor" value="2" name="majorStatus"> 부 전공
									</label> <label class="checkbox-inline"> <input type="radio"
										id="idTransfer" value="3" name="majorStatus"> 편입
									</label> <label class="checkbox-inline"> <input type="radio"
										id="idInterest" value="4" name="majorStatus" checked> 전공 심화
									</label>
								</div>
								<div class="form-group">
									<label>추가 전 공학과 &nbsp;: &nbsp;</label> 
									<select id="doubleMajorDepart">
										<option value="n">추가전공 여부 선택해주세요</option>
									</select>
								</div>
								<div class="form-group">
									<label>관 &nbsp;&nbsp;&nbsp;&nbsp;심 &nbsp;&nbsp;&nbsp;&nbsp;사&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp; </label> 
									<select id="interest">
										<option value="n">관심사를 선택해주세요
									</select>
								</div>
								<div align="center">
								 	<button type="button" class="btn btn-warning" onclick="history.back();">취소</button>
									<div class="btn btn-outline btn-primary" >
										<span id="idSubmit">다음</span>
									</div>
								</div>
							</fieldset>
						</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	   			<!-------------------------------- 데이터 submit ----------------------------->
						<form id="idForm" action="/SukangWeb/addUserInfo2.do" method="POST">	
								<input name="school" type="hidden" id="ipSchool">
								<input name="studentId" type="hidden" id="ipStudentId">
								<input name="major" type="hidden" id="ipMajor">
								<input name="admission" type="hidden" id="ipAdmin">
								<input name="comSemester" type="hidden" id="ipCompSemester">
								<input name="status" type="hidden" id="ipMajorStatus">
								<input name="additionalMajor" type="hidden" id="ipAdditionalMajor">
								<input name="interest" type="hidden" id="ipInterest">
								<input name="userId" type="hidden" value="${sessionScope.userId}">
						</form>
						
						<input type="hidden" value="${sessionScope.userId}">
</body>
</html>