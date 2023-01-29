<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.net.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!-- 引入JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>會員登入</title>
	<!-- 引用Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
	<!-- 引用外部css -->
	<link rel="stylesheet" href="css/BodyDefault.css">
	<!-- 引用外部javascript -->
	<script src="scripts/GetCookie.js"></script>
	<script src="scripts/SetCookie.js"></script>
	<!-- 引用jQuery -->
	<script src="scripts/jquery.min.js"></script>
	<script src="scripts/jquery.cookie.js"></script>
	<!-- 下拉式選單需要的腳本 -->
	<script src="scripts/popper.min.js"></script>
	<!-- Bootstrap時間挑選器 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
	<style>
		body{
            background-image:url("images/back.png");
            background-size:cover;
        }
	</style>
</head>
<body>
	<!-- 讀取資料庫裏面的會員帳號與密碼 -->
	<c:set var="DataBaseName" value="newyear"/>
	<c:set var="DataBaseUserAccount" value="newyear"/>
	<c:set var="DataBaseUserPassword" value="newyear"/>
	<c:set var="DataBaseURL"/>
	<%
	String name=(String)pageContext.getAttribute("DataBaseName");
	String url="jdbc:mysql://localhost:3306/"+name;
	pageContext.setAttribute("DataBaseURL",url);
	%>
	<sql:setDataSource var="DataBase" driver="com.mysql.cj.jdbc.Driver"
	url="${DataBaseURL}" user="${DataBaseUserAccount}" password="${DataBaseUserPassword}"/>
    <sql:query dataSource="${DataBase}" var="result">
    	SELECT account,password from member;
	</sql:query>
	<!-- 檢查會員是否已經登入 -->
	<c:forEach var="row" items="${result.rows}">
		<script>                                                 
			var Row_account=String("${row.account}");            /*利用expression language，把JSTL的變數傳遞到Javascript*/
			var Row_password=String("${row.password}");          /*利用expression language，把JSTL的變數傳遞到Javascript*/
			if(Row_password==GetCookieValueByName(Row_account)){ /*檢查密碼的時候就會同時一起檢查帳號*/
				window.alert("會員已登入，前往會員中心");
				window.location.assign("member.jsp");
			}
		</script>
	</c:forEach>	
	<br>
	<div class="container-fluid"><!-- 標題內容 -->
		<div class="row">
			<div class="col-1">
				<h3></h3><!-- 空白部分 -->
			</div>
			<div class="col-2">
				<h3>會員登入</h3>
			</div>
			<div class="col-7">
				<h3></h3><!-- 中間空白部分 -->
			</div>
			<div class="col-2">
				<button type="button" class="btn" onclick="javascript:Return();">
					<script>
						function Return(){
							window.location.assign("index.html");
						}
					</script>
					<h3>返回首頁</h3>
				</button>
			</div><!-- 對應到返回按鍵 -->
		</div><!-- 對應到row -->
	</div><!-- 對應到container-fluid -->
	<form action="verify.jsp" method="get">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<table class="table">
						<tr>
							<td>帳號</td>
							<td><input type="text" name="account" placeholder="請輸入帳號"></td>
						</tr><!-- 第一列 -->
						<tr>
							<td>密碼</td>
							<td><input type="password" name="password" placeholder="請輸入密碼"></td>
						</tr><!-- 第二列 -->
						<tr>
							<td><input type="reset" value="重設"></td>
							<td><input type="submit" value="登入"></td>
						</tr><!-- 第三列 -->
						<tr>
							<td><a href='error.jsp'>忘記密碼</a></td>
							<td><a href='register.jsp'>沒有會員？前往註冊</a></td>
						</tr><!-- 第四列 -->
					</table>
				</div><!-- 對應到col-12 -->
			</div><!-- 對應到row -->
		</div><!-- 對應到container -->
	</form>
	<!-- 引用Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
</body>
</html>