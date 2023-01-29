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
	<title>商品資訊</title>
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
        #div_top{
        	height:20%;
            margin:0 auto;
            text-align:center;
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
	<br>
	<div class="container-fluid" id="div_top"><!-- fluid:讓div的寬度佔滿版面 -->
		<div class="row">
			<div class="col-2"><button class="btn">商品資訊</button></div>
			<div class="col-2">
				<button class="btn" onclick="javascript:Login();">
					<script>
						function Login(){
							window.location.assign("login.jsp");
						}
					</script>
				會員中心
				</button>
			</div>
			<div class="col-2">
				<button class="btn" onclick="javascript:ToCart();">
					<script>
						function ToCart(){
							window.location.assign("cart.jsp");
						}
					</script>
				進入購物車
				</button>
			</div>
			<div class="col-2">
				<div class="dropdown">
					<button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">種類</button>
  					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" id="ul_button1">
    					<li>
    						<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection1();"><!-- 點擊超連結時順便增加cookie -->
    							<script>
    								function AddSelection1(){
    									document.cookie="select=bed";
    								}
    							</script>
    						床
    						</a>
    					</li>
    					<li>
    						<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection2();">
    							<script>
    								function AddSelection2(){
    									document.cookie="select=table";
    								}
    							</script>
    						桌子
    						</a>
    					</li>
    					<li>
    						<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection3();">
    							<script>
    								function AddSelection3(){
    									document.cookie="select=refrigerator";
    								}
    							</script>
    						冰箱
    						</a>
    					</li>
    					<li>
    						<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection4();">
    							<script>
    								function AddSelection4(){
    									document.cookie="select=television";
    								}
    							</script>
    						電視
    						</a>
    					</li>
    					<li>
    						<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection5();">
    							<script>
    								function AddSelection5(){
    									document.cookie="select=air_conditioner";
    								}
    							</script>
    						冷氣
    						</a>
    					</li>
    					<li>
    						<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection6();">
    							<script>
    								function AddSelection6(){
    									document.cookie="select=laundry_machine";
    								}
    							</script>
    						洗衣機
    						</a>
    					</li>
  					</ul>
				</div>
			</div>
			<div class="col-2">
				<div class="dropdown">
  					<button class="btn dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">價格</button>
  					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2" id="ul_button2">
    					<li>
    						<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection7();">
    							<script>
    								function AddSelection7(){
    									document.cookie="select=low_price";
    								}
    							</script>
    						低價位
    						</a>
    					</li>
    					<li>
    						<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection8();">
    							<script>
    								function AddSelection8(){
    									document.cookie="select=medium_price";
    								}
    							</script>
    						中價位
    						</a>
    					</li>
    					<li>
    						<a class="dropdown-item" href="select.jsp" onclick="javascript:AddSelection9();">
    							<script>
    								function AddSelection9(){
    									document.cookie="select=high_price";
    								}
    							</script>
    						高價位
    						</a>
    					</li>
  					</ul>
				</div>
			</div>
			<div class="col-2">
				<button type="button" class="btn" onclick="javascript:Return();">
					<script>
						function Return(){
							window.location.assign("index.html");
						}
					</script>
					返回首頁
				</button>
			</div>
		</div><!-- 對應到row -->
	</div><!-- 對應到container-fluid -->
	<br>
    <!-- ------------------------------------------------------------------------------------------------------- -->
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
    	SELECT * FROM commodity;
	</sql:query>
    <div class="container" id="div_all">
    	<div class="row">
    		<c:forEach var="row" items="${result.rows}">
    			<c:set var="i" value="${row.item_index}"/>
				<c:set var="web"/>
				<c:set var="pic"/>
				<%
				String id=Integer.toString((int)pageContext.getAttribute("i"));/*商品的index是整數，讀取物件時要先強制轉型成整數，然後再轉成字串*/
				String Web="detail"+id+".jsp";
				String Pic="images/pic"+id+".jpg";
				pageContext.setAttribute("web",Web);
				pageContext.setAttribute("pic",Pic);
				%>
				<div class="col-4">
					<a href=<c:out value="${web}"/>><!-- 直接把c:out輸出的字串拿來使用，不用再另外定一個字串變數 -->
   						<img src=<c:out value="${pic}"/> width="90%" height="90%">
   					</a>
				</div>
				<c:remove var="web"/>
				<c:remove var="pic"/>
			</c:forEach>
    	</div>
    </div>
    <script>
    	/*使用jQuery與Bootstrap來控制下拉選單*/
    	$(document).ready(function(){
        	$("#dropdownMenuButton1").click(function(){
            	$("#ul_button1").toggle(500);
        	});
        	$("#dropdownMenuButton2").click(function(){
            	$("#ul_button2").toggle(500);
        	});
    	});
    </script>
	<!-- 引用Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
</body>
</html>