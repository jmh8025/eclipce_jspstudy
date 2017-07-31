<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 첫번째 예제</title>
</head>
<body>

<% 
//자바 코드를 사용할수 있는 영역(Scriplet)
String str="홍길동";
System.out.println("str=>"+str);//디버깅용으로 콘솔에 출력시켜보리기
out.println("<h1>"+"웹에 출력하기 str=>"+str+"</h1>");
%>
<hr>
str값 출력=<%=str %>
</hr>
</body>
</html>