<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>추가정보2</title>
  
    <!-- Bootstrap Core CSS -->
    <link href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="${pageContext.request.contextPath}/resource/css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resource/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script
	src="${pageContext.request.contextPath}/resource/js/jquery-2.1.1.js"></script>
	
	<style>
	.col-md-offset-4{
		margin-left: 0;
	}
	

	.btn-warning{
		background-color: #eea236;
	}
	
	.thCenter{
		text-align: center;
	}

	</style>
</head>

<script type="text/javascript">
$(document).ready(function() {
	
	//var subArray = new Array();
	var reportList = new Array();
	 
	$("#idSave").click(function() {
		for (var i = 0; i < $("#idLen").val(); i++) {
				var tr = $(".gradeX")[i];
				var iYear = $("select[name='nmYear']", tr);
				var iSemester = $("select[name='nmSemester']", tr);
				var iSubCode = $("input[name='nmSubCode']", tr);
				var iGrade = $("select[name='nmGrade']", tr);
				var iRetake = $("input[name='nmRetake']:checked", tr);
				
				 /* var validate = function() {
					if(($(iYear).val() != "n" || $(iSemester).val() == "n" ||  $(iGrade).val() == "n")
							|| (($(iYear).val() == "n" || $(iSemester).val() != "n" ||  $(iGrade).val() == "n"))
							|| (($(iYear).val() == "n" || $(iSemester).val() == "n" ||  $(iGrade).val() != "n"))) {	
						alert("학년 " + $(iYear).val());
						alert("학기" + $(iSemester).val());
						alert("과목명" + $(iSubCode).val());
						alert("점수" +  $(iGrade).val());
						 
						
						//alert("정보를 입력해주세요");
						return false;	
					}
					else{
						alert();
					}
					return true;
				}  */
		
				 //var addData = function() {
					//if(validate() == true) {
						if($(iYear).val() != "n" && $(iSemester).val() != "n" && $(iGrade).val() != "n") {	
							var subject = {};
							subject.year= $(iYear).val();
							subject.semester = $(iSemester).val();
							subject.subjectCode = $(iSubCode).val();
							
							var report = {};
							report.grade = $(iGrade).val();
							report.retake = $(iRetake).val();
							report.subject = subject;
							
							reportList.push(report);
						}
						
					//}
				//} 
				// addData();
		}
		
			
			var json = JSON.stringify(reportList);
			$("#idJson").val(json);
			
			ajax();
		
	

	});
	
	var ajax = function() {
		$.ajax({
			type: "get"
			,url: "/SukangWeb/saveSecondPage.do"
			,data: {values: $("#idJson").val()
					,userId: $("#idId").val()
				}
			,traditional: true
			,success: successCallback
			,error: errorCallback
		});
	}
	
	var successCallback = function() {
		location.href="/SukangWeb/views/completed.jsp"
		
	}
	
	var errorCallback = function() {
		alert("처리중 오류가 발생하였습니다");
	}
	
});
		
</script>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h2>이수과목 및 성적 입력</h2>
                    </div>
                    <div class="panel-body">
                    <br><p class="text-info">이수한 과목을 선택해주세요!   (*재수강의 경우 재수강 할 과목만 체크해 주세요*)</p><br>
                        <form role="form" action="/SukangWeb/saveSecondPage.do" method="post">
                            <table class="table table-striped table-bordered table-hover"
									id="dataTables-example">
									<thead>
										<tr>
											<th class="thCenter">학년</th>
											<th class="thCenter">학기</th>
											<th class="thCenter">학수구분</th>
											<th class="thCenter">과목명</th>
											<th class="thCenter">학점</th>
											<th class="thCenter">성적</th>
											<th class="thCenter">재수강</th>
										</tr>
									</thead>

									<tbody>
									<input type="hidden" id="idJson" >
										<c:forEach var="list" items="${subjectList}" varStatus="count">
											<tr class="odd gradeX">
												<input type="hidden" id="idId" value="${list.interest}">
												<input type="hidden" id="idLen" value="${fn:length(subjectList)}">
											
							
												<td class="thCenter">
													<select id="idYear" name="nmYear">
														<option value="n">학년을 선택해주세요</option>
											<c:forEach var="i" begin="1" end="${yyear}" step="1">	
														<option value="${i}">${i}</option>
											</c:forEach>	
													</select>
												</td>
									
										
												<td class="thCenter">
													<select name="nmSemester">
														<option value="n">학기를 선택해주세요</option>
														<option value="1">1</option>
														<option value="2">2</option>
													</select>
												</td>
										
												
												<td class="thCenter"><input type="hidden" name="nmClasstyp" value="${list.classtype}">${list.classtype}</td>
												<td class="thCenter">
													<input type="hidden" name="nmSubjectName" value="${list.subjectName}">${list.subjectName}
													<input type="hidden" name="nmSubCode" value="${list.subjectCode}">
												</td>
												<td class="thCenter"><input type="hidden" name="nmCredit" value="${list.credit}">${list.credit}</td>
												<td class="thCenter">
													<select name="nmGrade">
														<option value="n">점수를 선택해주세요</option>
														<option value="4.5">A+</option>
														<option value="4.0">A</option>
														<option value="3.5">B+</option>
														<option value="3.0">B</option>
														<option value="2.5">C+</option>
														<option value="2.0">C</option>
														<option value="1.5">D+</option>
														<option value="1.0">D</option>
														<option value="0">F</option>
													</select>
												</td>
												<td class="thCenter"><input type="checkbox" id="idRetake" value="1" name="nmRetake"></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
                        </form>
                        				<div align="center">
											<button type="button" class="btn btn-warning" onclick="history.back();">뒤로가기</button>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="submit" id="idSave" class="btn btn-outline btn-default" value="저   장" width="100px;">
											<input type="hidden" value="${sessionScope.userId}">
										</div>	
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/plugins/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>

</body>

</html>
