<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<html>

<head>
</head>

<body>


<h1>Login Page</h1>

<div>
<form method = "POST" action = "./login-req.jsp">

	<label for="username">Username*</label>
	<input type="text" name="username" id="username" placeholder="John Doe">
	<br>
	
	<label for="password">Password*</label>
	<input type="text" name="password" id="password" placeholder="Apple Sauce">
	<br>
	
	<input type="radio" name="user" id="employee" value="Employee" checked>
	<label for="employee">Employee</label>
	
	<input type="radio" name="user" id="customer" value="Customer">
	<label for="customer">Customer</label>
	<br>
	
	<input type="submit" value="login-req">
	
</form>
</div>

</body>


</html>