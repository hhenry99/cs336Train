<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<html>

<body>
    <%
        String username = (String) session.getAttribute("user");
        if (username != null) {
            out.println("Welcome " + username);
            out.println("<a href='logout.jsp'>Log out</a>");
        } else {
            response.sendRedirect("login.jsp"); // Redirect to login page if user not logged in
        }
    %>
</body>

</html>