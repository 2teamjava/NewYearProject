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
	<title>付款頁面</title>
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
	<c:set var="ID_Value_list"/>
	<c:set var="Price" value="${0}"/>
	<%
	/*找出表單送出的所有變數與數值，並且把結果儲存到一個list裡面。奇數項為名稱，偶數項為數值*/
	/*在JSTL則是把結果儲存到一個字串，用逗點隔開項目。奇數項為名稱，偶數項為數值*/
	Enumeration ParameterNames=request.getParameterNames();
	List<String> id_value_list=new ArrayList<String>();
	while(ParameterNames.hasMoreElements()){
		String Id_value_list=(String)pageContext.getAttribute("ID_Value_list");
		/*------------------------------------------------------*/
		String ParameterName=(String)ParameterNames.nextElement();
		String ParameterValue=request.getParameter(ParameterName);
		id_value_list.add(ParameterName.substring(5)); /*java物件*/
		id_value_list.add(ParameterValue);             /*java物件*/
		/*------------------------------------------------------*/
		Id_value_list=Id_value_list+","+ParameterName.substring(5)+"="+ParameterValue;
		pageContext.setAttribute("ID_Value_list",Id_value_list);
	}
	/*刪除開頭的逗號*/
	String Id_value_list=(String)pageContext.getAttribute("ID_Value_list");
	if(Id_value_list.length()>1){  /*1代表這個字串只有一個開頭的逗號*/
		Id_value_list=Id_value_list.substring(1);
		pageContext.setAttribute("ID_Value_list",Id_value_list);
	}
	%>
	<c:if test="${ID_Value_list.length()<3}"><!-- 如果遇到購物車都沒選就來按結帳，就使用此情況 -->
		<!-- 最短的字串為1=1，長度=3 -->
		<script>
			window.alert("空的購物車不能結帳喔~");
			window.location.assign("commodity.jsp");
		</script>
	</c:if>
	<form action="bill.jsp" method="get">
		<br>
		<div class="container" id="div_all">
			<div class="row">
				<c:forTokens var="Item_Value" delims="," items="${ID_Value_list}"><!-- 先把項目清單拆開來 -->
					<c:set var="array" value="${fn:split(Item_Value,'=')}"/>
					<c:set var="ID" value="${array[0]}"/>
					<c:set var="Value" value="${array[1]}"/>
					<c:set var="InfoID"/>
					<c:set var="PicID"/>
					<c:set var="ImgID"/>
					<c:set var="StartID"/>
					<%
					String id=(String)pageContext.getAttribute("ID");
					String value=(String)pageContext.getAttribute("Value");
					String infoid="info"+id;
					String picid="pic"+id;
					String imgid="images/pic"+id+".jpg";
					String startid="Start"+id;
					pageContext.setAttribute("InfoID",infoid);
					pageContext.setAttribute("PicID",picid);
					pageContext.setAttribute("ImgID",imgid);
					pageContext.setAttribute("StartID",startid);
					%>
					<div class="col-6" id="${PicID}">
						<img src="${ImgID}" width="95%" height="95%">
					</div><!-- 對應到PicID -->
					<div class="col-6" id="${InfoID}">
						<br>
						<h3>商品編號 : <c:out value="${ID}"/></h3>
						<h3>租期 : <c:out value="${Value}"/> 個月</h3>
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
							<c:if test="${row.item_index==Integer.parseInt(ID)}">
								<h3>租金 : <fmt:formatNumber  value="${(row.cost/row.life_month)*Value}" minFractionDigits="0" maxFractionDigits="0"/>元</h3>
								<fmt:formatNumber var="Rent" groupingUsed="false" value="${(row.cost/row.life_month)*Value}" minFractionDigits="0" maxFractionDigits="0"/>
								<!-- 格式化數字的時候，預設會加上逗號，這裡設置變數Rent的時候，把逗號去除掉 -->
								<%
								/*這裡的資料型態要特別注意*/
								long price=(long)pageContext.getAttribute("Price");
								String rent=(String)pageContext.getAttribute("Rent");
								int num=Integer.parseInt(rent);
								price+=num;/*使用委派運算子，省去轉換型態的步驟*/
								pageContext.setAttribute("Price",price);
								%>
								<br>
    							<label for="validationCustomUsername" class="form-label"><h3>請選擇起始日期</h3></label>
    							<c:set var="now" value="<%=new java.util.Date()%>" />                   <!-- 獲取今天的日期 -->
								<fmt:formatDate var="DefaultDate" pattern="yyyy-MM-dd" value="${now}" /><!-- 設定預設日期，避免出現沒有填寫日期的情況 -->
    							<div class="input-group has-validation">
      								<input type="text" class="form-control datepicker" name="${StartID}" id="validationCustomUsername" value="${DefaultDate}"
      								 readonly="readonly" placeholder="點擊選擇日期" aria-describedby="inputGroupPrepend" required>
      								<!-- 設置readonly屬性，使用者就不能在狀態列輸入日期，避免使用者亂打導致程式無法判斷 -->
    							</div>
							</c:if>
						</c:forEach>
						<br>
						<button type="button" class="btn btn-warning"><a href="contract.jsp">簽署合約</a></button>
					</div><!-- 對應到InfoID -->
					<c:remove var="ID"/>
					<c:remove var="Value"/>
					<c:remove var="InfoID"/>
					<c:remove var="PicID"/>
					<c:remove var="ImgID"/>
					<c:remove var="StartID"/>
				</c:forTokens>
			</div><!-- 對應到row -->
		</div><!-- 對應到div_all -->
		<div class="container" id="div_all">
			<div class="row">
				<table class="table">
					<tr>
						<td><h3>總金額</h3></td>
						<td><h3><c:out value="${Price}"/> 元</h3></td>
					</tr>
					<tr>
						<td><h3>付款方式</h3></td>
						<td>
							<select class="form-select" name="pay">
								<option selected value="0" id="noselect">請選擇</option>
								<option value="mobile_payment">行動支付</option>
								<option value="credit_card">信用卡</option>
								<option value="store">超商繳費</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<button type="reset" class="btn btn-warning" onclick="javascript:Return();">
								<script>
									function Return(){
										window.location.assign("cart.jsp");
									}
								</script>
								重新選擇
							</button>
						</td>
						<td>
							<button type="submit" class="btn btn-success">付款</button>
						</td>
					</tr>
				</table>
			</div><!-- 對應到row -->
		</div><!-- 對應到div_all -->
		<input type="hidden" name="ID_Value_list" value="${ID_Value_list}">
		<input type="hidden" name="price" value="${Price}"><!-- 在表單裡面用來記錄價錢的項目 -->
	</form>
	<br>
	<script>
		$(document).ready(function(){
			$('#noselect').attr('disabled',true);/*停用相同class的功能，這裡用來停止選項的功能*/
			$('.datepicker').datepicker({
				format:'yyyy-mm-dd',             /*設定時間篩選器的格式*/
				autoclose:true,                  /*選完日期之後，畫面自動關閉*/
				weekStart:1,                     /*周一當作第一天*/
				startDate:new Date()             /*設定起始日期是從今天開始*/
			});
		});
	</script>
	<!-- 引用Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
</body>
</html>