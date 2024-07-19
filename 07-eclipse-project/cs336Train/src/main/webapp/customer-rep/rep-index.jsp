<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Representative</title>
	</head>
<body>
<%
out.println("<a href='../logout.jsp'>Log out</a>");
String userid = (String) session.getAttribute("user");
out.println("<h1>Welcome, " + userid + "</h1>");
%>
<br>

<p><a href = "./train-schedule/train-schedule.jsp">Train Schedule</a></p>
<p><a href = "./forum/rep-forum.jsp">Answer Customer Questions</a></p>

</body>
</html>