<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>模擬登入</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
	<script>
    	/*從Cookie來確認使用者的登入狀態*/
    	function GetCookieValueByName(cookie_name){
        	var CookieArray=document.cookie.split(";");
        	for(var index=0;index<CookieArray.length;index++){
            	var Cookie_String=String(CookieArray[index]);
            	if (Cookie_String.indexOf(cookie_name,0)!=-1){
                	var SPLIT=CookieArray[index].split("=");
                	return SPLIT[1];
            	}
        	}
    	}
    	function LoginCheck(cookie_name){
        	var CookieArray=document.cookie.split(";");
        	for(var index=0;index<CookieArray.length;index++){
            	var Cookie_String=String(CookieArray[index]);
            	if (Cookie_String.indexOf(cookie_name,0)!=-1){
                	return true;
            	}
        	}
    	}
    </script>
</head>
<body>
	<%
	String account="user";
	String password="S123456789";
	Cookie MyCookie=new Cookie(account,password);
	response.addCookie(MyCookie);
	out.println("<h1 align='center'></h1>");
	out.println("<h1 align='center'>使用者已登入</h1>");
	%>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
</body>
</html>