<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<%

// Invalidate the session
HttpSession currentSession = request.getSession(false); // Use a different variable name
if (currentSession != null) {
    currentSession.invalidate();
}
// Redirect to the login page
response.sendRedirect("./login.jsp");

%>