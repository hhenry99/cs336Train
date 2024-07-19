<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer</title>
</head>
<body>

<%
out.println("<a href='../logout.jsp'>Log out</a>");
String userid = (String) session.getAttribute("user");
Integer cid = (Integer) session.getAttribute("customer-id");
out.println("<h1>Welcome, " + userid + "</h1>");
out.println("customer ID: " + cid);
%>
<br>

<p><a href = "./reservation/reservation-index.jsp">Reservation</a></p>
<p><a href = "./customer-forum/forum-index.jsp">Forum</a></p>

</body>
</html>