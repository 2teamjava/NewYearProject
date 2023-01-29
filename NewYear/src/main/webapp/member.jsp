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
	<title>會員中心</title>
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
        #head{
        	font-size:25px;
        	text-align:center;
        }
	</style>
</head>
<body>
	<br>
	<!-- 標題按鈕 -->
	<div class="container-fluid" id="head">
		<div class="row">
			<div class="col-3">
				<button type="button" class="btn" onclick="javascript:Return();">
					<script>
						function Return(){
							window.location.assign("index.html");
						}
					</script>
					<h3>返回首頁</h3>
				</button>
			</div>
			<div class="col-3">
				<button type="button" class="btn" onclick="javascript:Logout();">
					<script>
						function Logout(){
							var CookieArray=document.cookie.split(";");
						    for(var index=0;index<CookieArray.length;index++){
						        var SPLIT=CookieArray[index].split("=");
						        var cookieName=SPLIT[0];
						        DeleteCookieByName(cookieName);
						        $.removeCookie(cookieName);/*jQuery的功能*/
						    }
							window.alert("會員已登出");
							window.location.assign("index.html");
						}
					</script>
					<h3>會員登出</h3>
				</button>
			</div>
			<div class="col-3">
				<button type="button" class="btn" onclick="javascript:ToCommodity();">
					<script>
						function ToCommodity(){
							window.location.assign("commodity.jsp");
						}
					</script>
					<h3>前往商城</h3>
				</button>
			</div>
			<div class="col-3">
				<button type="button" class="btn" onclick="javascript:ToCart();">
					<script>
						function ToCart(){
							window.location.assign("cart.jsp");
						}
					</script>
					<h3>進入購物車</h3>
				</button>
			</div>
		</div>
	</div>
	<!-- ------------------------------------------- -->
	<!-- 從登入畫面進來:蒐集cookie並確認使用者 -->
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
    	SELECT * from member;
	</sql:query>
	<c:set var="LoginAccount"/>
	<c:set var="LoginPassword"/>
	<c:forEach var="row" items="${result.rows}">
		<c:set var="row_account" value="${row.account}"/>
		<c:set var="row_password" value="${row.password}"/>
		<%
		String Row_account=(String)pageContext.getAttribute("row_account");
		String Row_password=(String)pageContext.getAttribute("row_password");
		Cookie[] cookies=request.getCookies();/*如果用email當作帳號，則會出現錯誤*/
		/*A cookie header was received [123@gmail.com=S123456789] that contained an invalid cookie. That cookie will be ignored.*/
		for(int i=0;i<cookies.length;i++){
	    	if((cookies[i].getName().equals(Row_account))&&(cookies[i].getValue().equals(Row_password))){
	    		pageContext.setAttribute("LoginAccount",Row_account);
	    		pageContext.setAttribute("LoginPassword",Row_password);
	    		break;
	    	}
	    	else{
	    	}
	    }
		%>
	</c:forEach>
	<!-- 從註冊畫面進來:蒐集表單送出資訊 -->
	<c:set var="Account" value="${param['account']}"/>
	<c:set var="Password" value="${param['password']}"/>
	<c:set var="Name" value="${param['name']}"/>
	<c:set var="Phone" value="${param['phone']}"/>
	<c:set var="Address" value="${param['address']}"/>
	<!-- 
	如果沒有輸入，則字串為空，也就是長度等於0
	現在把兩個字串的長度相乘，如果其中一個是空字串，那麼該字串長度為0，而且相乘的結果也是0
	用來檢查使用者是從哪個頁面進入會員中心
	-->
	<c:choose>
		<c:when test="${fn:length(Account)*fn:length(Password)*fn:length(Name)*fn:length(Phone)*fn:length(Address)>0}"><!-- 從註冊畫面進來 -->
			<script>
				/*新增cookie*/
				var account="${Account}";
				var password="${Password}";
				document.cookie=account+"="+password;
			</script>
			<!-- 找出最大的會員id -->
			<sql:query dataSource="${DataBase}" var="MaxID">
    			SELECT member_index from member;
			</sql:query>
			<c:set var="MaxIndex" value="${fn:length(MaxID.rows)}"/><!-- 會員編號是從0號開始，所以找出來的長度會比編號多1 -->
			<!-- 移除舊有資料 -->
			<sql:update dataSource="${DataBase}" var="Delete">
				DELETE FROM member WHERE account="<c:out value='${Account}'/>";
			</sql:update>
			<!-- 新增註冊資料 -->
			<sql:update dataSource="${DataBase}" var="Insert">
				INSERT INTO member VALUES 
				("<c:out value='${MaxIndex}'/>","<c:out value='${Name}'/>","<c:out value='${Phone}'/>","<c:out value='${Address}'/>"
				,"<c:out value='${Account}'/>","<c:out value='${Password}'/>","");
			</sql:update>
			<!-- 查詢新增資料 -->
			<sql:query dataSource="${DataBase}" var="After">
    			SELECT * from member;
			</sql:query>
			<br>
			<div class="container">
				<div class="row">
					<table class="table">
						<tr>
							<th>會員編號</th>
							<th>會員姓名</th>
							<th>手機號碼</th>
							<th>地址</th>
							<th>帳號</th>
							<th>密碼</th>
							<!-- 從註冊畫面進來就不用顯示訂單編號，反正也是空的 -->
						</tr>
						<c:forEach var="row" items="${After.rows}">
							<c:if test="${row.account==Account}">
								<tr>
									<td><c:out value="${row.member_index}"/></td>
									<td><c:out value="${row.name}"/></td>
									<td><c:out value="${row.phone}"/></td>
									<td><c:out value="${row.address}"/></td>
									<td><c:out value="${row.account}"/></td>
									<td><c:out value="${row.password}"/></td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</div>
			</div>
		</c:when>
		<c:otherwise><!-- 從登入畫面進來 -->
			<br>
			<div class="container">
				<div class="row">
					<table class="table">
						<tr>
							<th>會員編號</th>
							<th>會員姓名</th>
							<th>手機號碼</th>
							<th>地址</th>
							<th>帳號</th>
							<th>密碼</th>
							<th>訂單編號</th>
						</tr>
						<c:forEach var="row" items="${result.rows}">
							<c:if test="${row.account==LoginAccount}">
								<tr>
									<td><c:out value="${row.member_index}"/></td>
									<td><c:out value="${row.name}"/></td>
									<td><c:out value="${row.phone}"/></td>
									<td><c:out value="${row.address}"/></td>
									<td><c:out value="${row.account}"/></td>
									<td><c:out value="${row.password}"/></td>
									<td><c:out value="${row.order_id}"/></td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</div>
			</div>
			<br>
			<!-- 顯示會員訂單資訊 -->
			<sql:query dataSource="${DataBase}" var="orderlist">
    			SELECT * from orderlist;
			</sql:query>
			<div class="container">
				<div class="row">
					<table class="table">
						<tr>
							<th>訂單編號</th>
							<th>商品編號</th>
							<th>出租時間</th>
							<th>起始時間</th>
							<th>結束時間</th>
							<th>出租金額</th>
						</tr>
						<c:forEach var="row" items="${orderlist.rows}">
							<c:if test="${row.account==LoginAccount}">
								<tr>
									<td><c:out value="${row.order_name}"/></td>
									<td><c:out value="${row.item_index}"/></td>
									<td><c:out value="${row.item_rent_time}"/>個月</td>
									<td><c:out value="${row.start}"/></td>
									<td><c:out value="${row.end}"/></td>
									<td><c:out value="${row.price}"/>元</td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	<!-- 引用Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
</body>
</html>