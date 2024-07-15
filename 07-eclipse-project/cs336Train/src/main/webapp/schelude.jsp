<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h1>Search Train Schedules</h1>
    <form action="search.jsp" method="get">
        <label for="origin">Origin:</label>
        <input type="text" id="origin" name="origin" required>
        <br>
        <label for="destination">Destination:</label>
        <input type="text" id="destination" name="destination" required>
        <br>
        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required>
        <br>
        <button type="submit">Search</button>
        </form>
</body>
</html>