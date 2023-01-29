<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
	<title>結帳</title>
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
	<br>
	<!-- 讀取資料庫 -->
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
	<!-- 找出最大訂單名稱MaxOrderName -->
	<sql:query dataSource="${DataBase}" var="orderlist">
    	SELECT * FROM orderlist;
	</sql:query>
	<c:set var="MaxOrderName" value="order1"/><!-- MaxOrderName會比現有的order_name多1 -->
	<c:forEach var="row" items="${orderlist.rows}">
		<c:set var="ordername" value="${row.order_name}"/>
		<%
		String maxname=(String)pageContext.getAttribute("MaxOrderName");
		String maxid=maxname.substring(5);/*取出數字字串部分*/
		int max=Integer.parseInt(maxid);  /*把字串轉成數字*/
		String ordername=(String)pageContext.getAttribute("ordername");
		String orderid=ordername.substring(5);
		int order=Integer.parseInt(orderid);
		if(max<=order){
			int NEXT=order+1;
			String maxorder="order"+Integer.toString(NEXT);
			pageContext.setAttribute("MaxOrderName",maxorder);
		}
		%>
		<c:remove var="ordername"/>
	</c:forEach>
	<!-- 確認登入帳號 -->
	<sql:query dataSource="${DataBase}" var="member">
    	SELECT * FROM member;
	</sql:query>
	<c:set var="LoginAccount"/>
	<c:set var="LoginPassword"/>
	<c:set var="LoginAddress"/>
	<c:forEach var="row" items="${member.rows}">
		<c:set var="row_account" value="${row.account}"/>
		<c:set var="row_password" value="${row.password}"/>
		<c:set var="row_address" value="${row.address}"/>
		<%
		String Row_account=(String)pageContext.getAttribute("row_account");
		String Row_password=(String)pageContext.getAttribute("row_password");
		String Row_address=(String)pageContext.getAttribute("row_address");
		Cookie[] cookies=request.getCookies();
		for(int i=0;i<cookies.length;i++){
	    	if((cookies[i].getName().equals(Row_account))&&(cookies[i].getValue().equals(Row_password))){
	    		pageContext.setAttribute("LoginAccount",Row_account);
	    		pageContext.setAttribute("LoginPassword",Row_password);
	    		pageContext.setAttribute("LoginAddress",Row_address);
	    		break;
	    	}
	    	else{
	    	}
	    }
		%>
		<c:remove var="row_account"/>
		<c:remove var="row_password"/>
		<c:remove var="row_address"/>
	</c:forEach>
	<!-- 更改會員訂單資訊 -->
	<c:forEach var="row" items="${member.rows}">
		<c:if test="${(row.account==LoginAccount)&&(row.password==LoginPassword)}">
			<c:set var="order_id" value="${row.order_id}"/>
			<c:set var="Original_order_id" value="${row.order_id}"/><!-- 紀錄原本訂單資料 -->
			<c:choose>
				<c:when test="${fn:length(row.order_id)==0}"><!-- 會員的訂單紀錄為空 -->
					<sql:update dataSource="${DataBase}" var="update">
						UPDATE member SET order_id="${MaxOrderName}" WHERE account="${LoginAccount}";
					</sql:update>
				</c:when>
				<c:otherwise>
					<c:set var="order"/>
					<%
					String order_id=(String)pageContext.getAttribute("order_id");
					String maxname=(String)pageContext.getAttribute("MaxOrderName");
					String order=order_id+","+maxname;
					pageContext.setAttribute("order",order);
					%>
					<sql:update dataSource="${DataBase}" var="update">
						UPDATE member SET order_id="${order}" WHERE account="${LoginAccount}";
					</sql:update>
					<c:remove var="order"/>
				</c:otherwise>
			</c:choose>
			<c:remove var="order_id"/>
		</c:if>
	</c:forEach>
	<!-- 新增訂單資料庫資料 -->        
	<c:set var="ID_Value_list" value="${param['ID_Value_list']}"/>
	<c:forTokens var="ID_Value" delims="," items="${ID_Value_list}">
		<sql:query dataSource="${DataBase}" var="orderlist">
    		SELECT * FROM orderlist;
		</sql:query>
		<c:set var="OrderlistMaxIndex" value="${fn:length(orderlist.rows)}"/><!-- 新增資料後長度會改變，所以要放進迴圈裏面，每次都要查詢 -->
		<c:set var="array" value="${fn:split(ID_Value,'=')}"/>
		<c:set var="array_0" value="${array[0]}"/>
		<c:set var="array_1" value="${array[1]}"/>
		<c:set var="item_index"/>
		<c:set var="item_rent_time"/>
		<%
		String id=(String)pageContext.getAttribute("array_0");
		String rent=(String)pageContext.getAttribute("array_1");
		int int_id=Integer.parseInt(id);
		int int_rent=Integer.parseInt(rent);
		pageContext.setAttribute("item_index",int_id);
		pageContext.setAttribute("item_rent_time",int_rent);
		%>
		<sql:update dataSource="${DataBase}" var="insert">
   				INSERT INTO orderlist VALUES 
   				(<c:out value='${OrderlistMaxIndex+1}'/>,"<c:out value='${LoginAccount}'/>"
   				,"<c:out value='${LoginAddress}'/>","<c:out value='${MaxOrderName}'/>"
   				,<c:out value='${item_index}'/>,<c:out value='${item_rent_time}'/>
   				,"","",0);
		</sql:update>
	</c:forTokens>	
	<!-- 讀取商品最大編號 -->
	<sql:query dataSource="${DataBase}" var="commodity">
    	SELECT item_index FROM commodity;
	</sql:query>
	<c:set var="CommodityMaxID" value="${fn:length(commodity.rows)}"/>
	<!-- 修改訂單的起始時間 -->
	<c:forEach var="i" begin="1" end="${CommodityMaxID}" step="1">
		<c:set var="paramName"/>
		<%
		int i=(int)pageContext.getAttribute("i");
		String str_i=String.valueOf(i);
		String param_name="Start"+str_i;
		pageContext.setAttribute("paramName",param_name);
		%>
		<c:if test="${fn:length(param[paramName])>0}">
			<sql:update dataSource="${DataBase}" var="update">
				UPDATE orderlist SET start="${param[paramName]}" WHERE order_name="${MaxOrderName}" AND item_index=${i};
			</sql:update>
		</c:if>
	</c:forEach>
	<!-- 修改訂單結束時間以及新增價錢 -->
	<c:forTokens var="ID_Value" delims="," items="${ID_Value_list}">
		<sql:query dataSource="${DataBase}" var="orderlist">
    		SELECT * FROM orderlist;
		</sql:query>
		<c:set var="array" value="${fn:split(ID_Value,'=')}"/>
		<c:set var="array_0" value="${array[0]}"/>
		<c:set var="array_1" value="${array[1]}"/>
		<c:set var="item_index"/>
		<c:set var="item_rent_time"/>
		<%
		String id=(String)pageContext.getAttribute("array_0");
		String rent=(String)pageContext.getAttribute("array_1");
		int int_id=Integer.parseInt(id);
		int int_rent=Integer.parseInt(rent);
		pageContext.setAttribute("item_index",int_id);
		pageContext.setAttribute("item_rent_time",int_rent);
		%>
		<c:forEach var="row" items="${orderlist.rows}">
			<c:if test="${(row.order_name==MaxOrderName)&&(row.item_index==item_index)}">
				<c:set var="month" value="${1000*60*60*24*30}"/>
				<c:set var="count" value="${item_rent_time}"/>
				<c:set var="start" value="${row.start}"/>
				<fmt:parseDate type="both" value="${start}" var="parsedStart" pattern="yyyy-MM-dd"/>
				<c:set var="end" value="${parsedStart}"/>
				<c:set target="${end}" property="time" value="${end.time+month*count}"/>
				<fmt:formatDate var="parsedEnd" value="${end}" pattern="yyyy-MM-dd"/>
				<sql:update dataSource="${DataBase}" var="update">
					UPDATE orderlist SET end="${parsedEnd}" WHERE order_name="${MaxOrderName}" AND item_index=${item_index};
				</sql:update>
				<!-- 新增價錢 -->
				<sql:query dataSource="${DataBase}" var="commodity">
    				SELECT * FROM commodity;
				</sql:query>
				<c:forEach var="row" items="${commodity.rows}">
					<c:if test="${row.item_index==item_index}">
						<fmt:formatNumber var="money" groupingUsed="false" value="${(row.cost/row.life_month)*item_rent_time}" minFractionDigits="0" maxFractionDigits="0"/>
						<sql:update dataSource="${DataBase}" var="update">
							UPDATE orderlist SET price="${money}" WHERE order_name="${MaxOrderName}" AND item_index=${item_index};
						</sql:update>
					</c:if>
				</c:forEach>
				
			</c:if>
		</c:forEach>
	</c:forTokens>
	<!-- 畫面顯示 -->
	<c:set var="pay" value="${param['pay']}"/><!-- 付款方式 -->   
	<c:choose>
		<c:when test="${pay=='mobile_payment'}">
			<h1 align='center'>付款方式： 行動支付</h1>
		</c:when>
		<c:when test="${pay=='credit_card'}">
			<h1 align='center'>付款方式： 信用卡</h1>
		</c:when>
		<c:when test="${pay=='store'}">
			<h1 align='center'>付款方式： 超商繳費</h1>
		</c:when>
		<c:otherwise>
			<a href="cart.jsp"><h1 align='center'>請重新選擇付款資訊</h1></a>
			<!-- 沒有選擇付款方式，所以把會員的訂單資料重設為原本的樣子 -->
			<sql:query dataSource="${DataBase}" var="member">
    			SELECT * FROM member;
			</sql:query>
			<c:forEach var="row" items="${member.rows}">
				<c:if test="${(row.account==LoginAccount)&&(row.password==LoginPassword)}">
					<sql:update dataSource="${DataBase}" var="update">
						UPDATE member SET order_id="${Original_order_id}" WHERE account="${LoginAccount}";
					</sql:update>
				</c:if>
			</c:forEach>
			<!-- 沒有選擇付款方式，刪除訂單資料庫裡面新增的資料 -->
			<sql:update dataSource="${DataBase}" var="delete">
				DELETE FROM orderlist WHERE order_name="${MaxOrderName}";
			</sql:update>
		</c:otherwise>
	</c:choose>
	<c:set var="price" value="${param['price']}"/><!-- 總金額 -->   
	<h1 align="center">付款金額： <c:out value="${price}"/> 元</h1>
	<div align="center">
		<button type="button" class="btn btn-outline-dark">
			<a href="member.jsp">返回會員中心</a>
		</button>
	</div>
	<!-- 引用Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
</body>
</html>