<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submitting</title>
</head>
<body>
	<%
	String userid = (String) session.getAttribute("user");
	Integer ssn = (Integer) session.getAttribute("ssn");

	String title = request.getParameter("title");
	Integer cid = Integer.valueOf(request.getParameter("cid"));

	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		String insert = "INSERT INTO answer_question VALUES (?, ?, ?, ?)";
		
		String update = "UPDATE ask_question SET answered = 1 WHERE title = ? AND cid = ?";
		
		PreparedStatement ps = con.prepareStatement(insert);
		
		ps.setString(1, title);
		ps.setInt(2, cid)
;
		ps.setInt(3, ssn);
		ps.setString(4, request.getParameter("reply"));
		
		ps.executeUpdate();
		
		ps = con.prepareStatement(update);
		ps.setString(1, title);
		ps.setInt(2, cid);
		
		ps.executeUpdate();
		
		db.closeConnection(con);
		response.sendRedirect("./rep-forum.jsp");
	} catch (Exception e) {
		out.print(e);
	}
	%>
</body>
</html>