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
	<title>篩選結果</title>
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
		#div_all{
    		width:100%;
    		height:80%;
    		margin:0 auto;
    		text-align:center;
    	}
	</style>
</head>
<body>
	<!-- 找出挑選的選項 -->
	<c:set var="selection"/>
	<%
	Cookie[] cookies=request.getCookies();
	for(int i=0;i<cookies.length;i++){
    	if(cookies[i].getName().equals("select")){
    		pageContext.setAttribute("selection",cookies[i].getValue());
    		break;
    	}
    }
	%>
	<c:set var="word"/>
	<c:choose>
		<c:when test="${selection=='bed'}">
			<%
			pageContext.setAttribute("word","床");
			%>
		</c:when>
		<c:when test="${selection=='table'}">
			<%
			pageContext.setAttribute("word","桌子");
			%>
		</c:when>
		<c:when test="${selection=='refrigerator'}">
			<%
			pageContext.setAttribute("word","冰箱");
			%>
		</c:when>
		<c:when test="${selection=='television'}">
			<%
			pageContext.setAttribute("word","電視");
			%>
		</c:when>
		<c:when test="${selection=='air_conditioner'}">
			<%
			pageContext.setAttribute("word","冷氣");
			%>
		</c:when>
		<c:when test="${selection=='laundry_machine'}">
			<%
			pageContext.setAttribute("word","洗衣機");
			%>
		</c:when>
		<c:when test="${selection=='low_price'}">
			<%
			pageContext.setAttribute("word","低價位");
			%>
		</c:when>
		<c:when test="${selection=='medium_price'}">
			<%
			pageContext.setAttribute("word","中價位");
			%>
		</c:when>
		<c:when test="${selection=='high_price'}">
			<%
			pageContext.setAttribute("word","高價位");
			%>
		</c:when>
		<c:otherwise>
			<script>
				window.location.assign("error.jsp");
			</script>
		</c:otherwise>
	</c:choose>
	<br>
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
	<div class="container" id="div_all">
    	<div class="row">
    		<br>
    		<div class="container">
    			<div class="row">
    				<h3><c:out value="${word}"/></h3>
    			</div>
    		</div>
    		<br>
    		<c:choose>
    			<c:when test="${word=='床'||word=='桌子'||word=='冰箱'||word=='電視'||word=='冷氣'||word=='洗衣機'}">
    				<sql:query dataSource="${DataBase}" var="result">
    					SELECT * FROM commodity WHERE type="${selection}";
					</sql:query>
					<c:forEach var="row" items="${result.rows}">
						<c:set var="i" value="${row.item_index}"/>
						<c:set var="detail"/>
						<c:set var="pic"/>
						<%
						String num=String.valueOf(pageContext.getAttribute("i"));/*這裡把整數i轉換成字串*/
						String Detail="detail"+num+".jsp";
						String Pic="images/pic"+num+".jpg";
						pageContext.setAttribute("detail",Detail);
						pageContext.setAttribute("pic",Pic);
						%>
						<div class="col-4">
							<a href="${detail}">
								<img src="${pic}" width="100%" height="100%">
							</a>
						</div>
						<c:remove var="i"/>
						<c:remove var="detail"/>
						<c:remove var="pic"/>
					</c:forEach>
    			</c:when>
    			<c:when test="${word=='低價位'}">
    				<sql:query dataSource="${DataBase}" var="result">
    					SELECT min(item_index) FROM `commodity` GROUP BY type ORDER BY item_index ASC;
					</sql:query>
					<c:forEach var="row" items="${result.rows}">
						<c:set var="i" value="${row['min(item_index)']}"/>
						<c:set var="detail"/>
						<c:set var="pic"/>
						<%
						String num=String.valueOf(pageContext.getAttribute("i"));
						String Detail="detail"+num+".jsp";
						String Pic="images/pic"+num+".jpg";
						pageContext.setAttribute("detail",Detail);
						pageContext.setAttribute("pic",Pic);
						%>
						<div class="col-4">
							<a href="${detail}">
								<img src="${pic}" width="100%" height="100%">
							</a>
						</div>
						<c:remove var="i"/>
						<c:remove var="detail"/>
						<c:remove var="pic"/>
					</c:forEach>
    			</c:when>
    			<c:when test="${word=='中價位'}">
    				<!-- 這個篩選條件能再更改 -->
    				<sql:query dataSource="${DataBase}" var="result">
    					SELECT item_index FROM `commodity` WHERE item_index%3=2;
					</sql:query>
					<c:forEach var="row" items="${result.rows}">
						<c:set var="i" value="${row['item_index']}"/>
						<c:set var="detail"/>
						<c:set var="pic"/>
						<%
						String num=String.valueOf(pageContext.getAttribute("i"));
						String Detail="detail"+num+".jsp";
						String Pic="images/pic"+num+".jpg";
						pageContext.setAttribute("detail",Detail);
						pageContext.setAttribute("pic",Pic);
						%>
						<div class="col-4">
							<a href="${detail}">
								<img src="${pic}" width="100%" height="100%">
							</a>
						</div>
						<c:remove var="i"/>
						<c:remove var="detail"/>
						<c:remove var="pic"/>
					</c:forEach>
    			</c:when>
    			<c:when test="${word=='高價位'}">
    				<sql:query dataSource="${DataBase}" var="result">
    					SELECT max(item_index) FROM `commodity` GROUP BY type ORDER BY item_index ASC;
					</sql:query>
					<c:forEach var="row" items="${result.rows}">
						<c:set var="i" value="${row['max(item_index)']}"/>
						<c:set var="detail"/>
						<c:set var="pic"/>
						<%
						String num=String.valueOf(pageContext.getAttribute("i"));
						String Detail="detail"+num+".jsp";
						String Pic="images/pic"+num+".jpg";
						pageContext.setAttribute("detail",Detail);
						pageContext.setAttribute("pic",Pic);
						%>
						<div class="col-4">
							<a href="${detail}">
								<img src="${pic}" width="100%" height="100%">
							</a>
						</div>
						<c:remove var="i"/>
						<c:remove var="detail"/>
						<c:remove var="pic"/>
					</c:forEach>
    			</c:when>
    		</c:choose>
    	</div>
    </div>
	<!-- 引用Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
</body>
</html>