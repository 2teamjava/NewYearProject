<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.net.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.lang.Math" %>
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
	<title>商品1</title>
	<!-- 引用Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
	<!-- 引用外部css -->
	<link rel="stylesheet" href="css/BodyDefault.css">
	<!-- 引用外部javascript -->
	<script src="scripts/GetCookie.js"></script>
	<!-- 引用jQuery -->
	<script src="scripts/jquery.min.js"></script>
	<style>
	
		body{
            background-color:rgba(225,245,241,0.947);
            background-size:cover;
            }
        #align_center{
            width:80%;
            margin:auto;
            text-align:center;
        }
    </style>
</head>
<body>
	<c:set var="itemID" value="1"/>
	<c:set var="imgsrc"/>
	<c:set var="orderID"/>
	<%
	String id=(String)pageContext.getAttribute("itemID");
	String src="images/pic"+id+".jpg";
	String order="order"+id;
	pageContext.setAttribute("imgsrc",src);
	pageContext.setAttribute("orderID",order);
	%>
	<!-- 載入商品資料庫 -->
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
	<c:forEach var="row" items="${result.rows}">
		<c:if test="${row.item_index==itemID}">
			<c:set var="brand" value="${row.brand}"/>
			<c:set var="location" value="${row.location}"/>
			<c:set var="cost" value="${row.cost}"/>
			<c:set var="purchasetime" value="${row.purchasetime}"/>
			<c:set var="life_month" value="${row.life_month}"/>
		</c:if>
	</c:forEach>
	<br>
	<div class="container-fluid" id="align_center">
		<div class="row">
			<div class="col-5">
				<img src="${imgsrc}"  width="100%" height="95%">
			</div><!-- 對應到col-5 -->
			<div class="col-1"></div><!-- 空白部分 -->
			<div class="col-6">
				<h3><span>【White & Wood】北歐風雙人床架+床墊</span></h3>
				<p><span> 大板拼接，穩固支撐</span></p>
				<p><span> 琴弦造型床頭，簡約優雅</span></p>
                <p><span> 安全無毒板材，歐美雙重認證</span></p>
                <p><span> 床腳收合於床框內，避免碰撞</span></p>
                <p><span> 商品編號 : <c:out value="${itemID}"/></span></p>
                <hr size="8px" width="100%">
                <h3>商品規格</h3>
                <p>商品尺寸(寬/長/高)(cm) : 160 x 195 x 102/42 (床墊 : 寬152 x 長188)</p>
                <p>床架材質 : 白橡木實木</p>
                <hr size="8px" width="100%">
                <h3>每月租金計算</h3>
                <table class="table table-bordered">
                	<thead>
                    	<tr>
                        	<th scope="col">1個月</th>
                        	<th scope="col">6個月</th>
                        	<th scope="col">12個月</th>
                    	</tr>
                    </thead>
                    <tbody>
                        <tr>
                        	<th scope="row">$<fmt:formatNumber value="${(cost/life_month)*1}" minFractionDigits="0" maxFractionDigits="0"/></th>
                          	<th scope="row">$<fmt:formatNumber value="${(cost/life_month)*6}" minFractionDigits="0" maxFractionDigits="0"/></th>
                          	<th scope="row">$<fmt:formatNumber value="${(cost/life_month)*12}" minFractionDigits="0" maxFractionDigits="0"/></th>              
                        </tr>
                    </tbody>
                </table>
			</div><!-- 對應到col-6 -->
		</div><!-- 對應到row -->
	</div><!-- 對應到align_center -->
	<br>
	<div class="container">
		<div class="row">
			<div class="col-6" style="display: flex;"><!-- 顯示出租狀態與隱藏加入購物車 -->
				<!-- 找出現在出租的最大時間 -->
				<c:set var="MaxEnd"/>
				<sql:query dataSource="${DataBase}" var="orderlist">
    				SELECT * FROM orderlist;
				</sql:query>
				<c:forEach var="orderlist_row" items="${orderlist.rows}">
					<c:if test="${orderlist_row.item_index==itemID}">
						<c:set var="ThisEnd" value="${orderlist_row.end}"/>
						<%
						String MaxEnd=(String)pageContext.getAttribute("MaxEnd");
						String ThisEnd=(String)pageContext.getAttribute("ThisEnd");
						SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
						if(MaxEnd.length()<1){
							pageContext.setAttribute("MaxEnd",ThisEnd);
						}
						else{
							try{
								java.util.Date parsedMaxEnd=formatter.parse(MaxEnd);
					            java.util.Date parsedThisEnd=formatter.parse(ThisEnd);
					            long MaxEnd_millisecond=parsedMaxEnd.getTime();
					            long ThisEnd_millisecond=parsedThisEnd.getTime();
					            if(ThisEnd_millisecond>MaxEnd_millisecond){
					            	pageContext.setAttribute("MaxEnd",ThisEnd);
					            }
					            else{
					            	
					            }
							}
							catch (java.text.ParseException e) {
					            e.printStackTrace();
					        }
						}
						%>
					</c:if>
				</c:forEach>
				<c:set var="status"/>
				<c:set var="now" value="<%=new java.util.Date()%>"/>
				<fmt:formatDate var="today" pattern="yyyy-MM-dd" value="${now}" />
				<c:if test="${fn:length(MaxEnd)==0}">
					<%
						pageContext.setAttribute("MaxEnd","1970-12-30");
					%>
				</c:if>
				<%
				String MaxEnd=(String)pageContext.getAttribute("MaxEnd");
				String today=(String)pageContext.getAttribute("today");
				SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
				try{
					java.util.Date parsedMaxEnd=formatter.parse(MaxEnd);
		            java.util.Date parsedtoday=formatter.parse(today);
		            long MaxEnd_millisecond=parsedMaxEnd.getTime();
		            long today_millisecond=parsedtoday.getTime();
		            if(today_millisecond>MaxEnd_millisecond){
		            	pageContext.setAttribute("status","ok");/*出租狀態定義*/
		            }
		            else{
		            	pageContext.setAttribute("status","no");/*出租狀態定義*/
		            }
				}
				catch(java.text.ParseException e){
					e.printStackTrace();
				}
				%>
				<c:choose>
					<c:when test="${status=='ok'}">
						<h6><span style="color:blue;">出租狀態: 可出租</span></h6>
					</c:when>
					<c:otherwise>
						<h6 align="center"><span style="color:red;">出租狀態: 出租中</span></h6>
						<h6 align="center">結束時間: <c:out value="${MaxEnd}"/></h6>
					</c:otherwise>
				</c:choose>
			</div><!-- 對應到col-6 -->
			<div class="col-2">
				<button id="AddCart" type="button" class="btn btn-warning" onclick="javascript:AddCart();"><!-- 按下按鍵時就會觸發javascript函數AddCart -->
					<script>
            			function AddCart(){
            				/*點擊按鈕後就會新增cookie，並且跳出視窗提示使用者*/
            				document.cookie="${orderID}"+"="+"${itemID}";
                			window.alert("已加入購物車");
            			}
            		</script>
					加入購物車
				</button>
			</div><!-- 對應到col-2 -->
			<div class="col-2">
            	<button type="button" class="btn btn-warning" onclick="javascript:GoBack();">
            		<script>
            			function GoBack(){
            				window.location.assign("commodity.jsp");
            			}
            		</script>
            		繼續購物
            	</button>
            </div><!-- 對應到col-3 -->
            <div class="col-2">
            	<button type="button" class="btn btn-warning" onclick="javascript:ToCart();">
            		<sql:query dataSource="${DataBase}" var="result">
    					SELECT account,password from member;
					</sql:query>
					<c:set var="LoginAccount"/>
					<c:set var="LoginPassword"/>
					<c:forEach var="row" items="${result.rows}">
						<c:set var="row_account" value="${row.account}"/>
						<c:set var="row_password" value="${row.password}"/>
						<%
						String Row_account=(String)pageContext.getAttribute("row_account");
						String Row_password=(String)pageContext.getAttribute("row_password");
						Cookie[] cookies=request.getCookies();
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
            		<script>
            			function ToCart(){
            				if("${LoginPassword}"==GetCookieValueByName("${LoginAccount}")){
            					window.location.assign("cart.jsp");
            				}
            				else{
            					window.location.assign("login.jsp");
            				}
            			}
            		</script>
            		前往購物車
            	</button>
            </div><!-- 對應到col-3 -->
		</div><!-- 對應到row -->
	</div><!-- 對應到container -->
	<script>
		var hidebutton="${status}";
		if(hidebutton=="no"){
			$(document).ready(function(){
				$("#AddCart").hide();
	    	});
		}
	</script>
	<!-- 引用Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
</body>
</html>