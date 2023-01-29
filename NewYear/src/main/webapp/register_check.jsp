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
	<title>註冊資訊確認</title>
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
</head>
<body>
	<!-- 載入會員資料庫 -->
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
    	SELECT * FROM member;
	</sql:query>
	<c:set var="account" value="${param['account']}"/>
	<c:set var="password" value="${param['password']}"/>
	<c:set var="name" value="${param['name']}"/>
	<c:set var="phone" value="${param['phone']}"/>
	<c:set var="address" value="${param['address']}"/>
	<!-- 檢查帳號是否已註冊 -->
	<c:forEach var="row" items="${result.rows}">
		<c:if test="${account==row.account}">
			<script>
				window.alert("帳號已被註冊，返回註冊頁面");
				window.location.assign("register.jsp");
			</script>
		</c:if>
	</c:forEach>
	<!-- 檢查是否有資料沒填 -->
	<c:if test="${account.length()==0||password.length()==0||name.length()==0||phone.length()==0||address.length()==0}">
		<script>
			window.alert("仍有資料尚未填寫，返回註冊頁面");
			window.location.assign("register.jsp");
		</script>
	</c:if>
	<br>
	<form action="member.jsp" method="post">
		<div class="container">
			<div class="row">
				<table class="table">
					<tr>
						<td colspan="2"><h3 align="center">輸入資訊確認</h3></td>
					</tr>
					<tr>
						<td>帳號</td>
						<td><c:out value="${account}"/></td>
					<tr>
					<tr>
						<td>密碼</td>
						<td><c:out value="${password}"/></td>
					<tr>
					<tr>
						<td>姓名</td>
						<td><c:out value="${name}"/></td>
					<tr>
					<tr>
						<td>電話</td>
						<td><c:out value="${phone}"/></td>
					<tr>
					<tr>
						<td>地址</td>
						<td><c:out value="${address}"/></td>
					<tr>
					<tr>
						<td>
							<button type="button" onclick="javascript:GoBack();">
								<script>
									function GoBack(){
										window.location.assign("register.jsp");
									}
								</script>
								重新輸入
							</button>
						</td>
						<td>
							<button type="button" name="check" id="check">是否送出?</button>
							<input type="submit" name="submit" id="submit" value="確定">
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input type="hidden" name="account" value="${account}"><!-- 在表單裡面用來記錄送出的項目 -->
		<input type="hidden" name="password" value="${password}">
		<input type="hidden" name="name" value="${name}">
		<input type="hidden" name="phone" value="${phone}">
		<input type="hidden" name="address" value="${address}">
	</form>
	<script>
		$(document).ready(function(){
			$("#submit").hide();
			$("#check").click(function(){
				$("#submit").toggle(500);
			});
		});
	</script>
	<!-- 引用Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
</body>
</html>