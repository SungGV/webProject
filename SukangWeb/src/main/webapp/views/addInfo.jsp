<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="description" content="">
	    <meta name="author" content="">
		<title>요람</title> 

	    <!-- Bootstrap Core CSS -->
	    <link href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css" rel="stylesheet">

	    <!-- MetisMenu CSS -->
	    <link href="${pageContext.request.contextPath}/resource/css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
	
	    <!-- Timeline CSS -->
	    <link href="${pageContext.request.contextPath}/resource/css/plugins/timeline.css" rel="stylesheet">
	
	    <!-- Custom CSS -->
	    <link href="${pageContext.request.contextPath}/resource/css/sb-admin-2.css" rel="stylesheet">
	
	    <!-- Morris Charts CSS -->
	    <link href="${pageContext.request.contextPath}/resource/css/plugins/morris.css" rel="stylesheet">
	    
	    <!-- Include 이수상황_막대그래프 css -->
	    <link class="include" rel="stylesheet" type="text/css" 
	    	href="${pageContext.request.contextPath}/jqplot/jquery.jqplot.css" />

	    <!-- Include . 이수상황_막대그래프 plugin -->
	    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jqplot/jquery.jqplot.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jqplot/plugins/jqplot.barRenderer.min.js"></script>
	   
	    
	    <script type="text/javascript">

	    </script>
	    <style type="text/css">
	    #add {
	    		width: 1000px;
	    		height:500px;
	    		
	    		}
	    
	    </style>
	</head>

	<body>
    <div id="wrapper">

        <!-- 배너 부분 -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
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
							<img class="profile-pic animated" src="${pageContext.request.contextPath}/img/profile-pic.jpg" alt="">
	                        <ul>
	                            <li><a href="">My Profile</a></li>
	                            <li><a href="">Sign Out</a></li>
	                        </ul>
	                    </div>
	                    
	                    <!-- Calendar -->
	                    
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

                      
		<!-- main center 부분 -->
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"> 제목줄 </h1>
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
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-green">
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
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
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
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-red">
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
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-gray">
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
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
              </div>
              
              <div class="container" id="">
        <div class="row" >
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default" >
                    <div class="panel-heading" style="">
                        <h3 class="panel-title" align="center">추가 정보가 없습니다</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form">
                            <fieldset>
                               
                                <!-- Change this to a button or input when using this as a form -->
                                <a href="http://localhost:8080/SukangWeb/views/additional.jsp" 
                                	class="btn btn-lg btn-success btn-block">추가정보입력</a>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
            
            

    <!-- jQuery -->
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
    <script src="${pageContext.request.contextPath}/resource/js/sb-admin-2.js"></script>
</body>

</html>