<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ask Question</title>
</head>
<body>

	<%
	String userid = (String) session.getAttribute("user");
	Integer cid = (Integer) session.getAttribute("customer-id");

	if (request.getMethod().equalsIgnoreCase("post")) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		if (title != null && !title.trim().isEmpty() && content != null && !content.trim().isEmpty()) {
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				
				String insert = "INSERT INTO ask_question VALUES (?, ?, ?, ?)";
				
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, title);
				ps.setInt(2, cid);
				ps.setString(3, content);
				ps.setInt(4, 0);
				
				ps.executeUpdate();
				
				db.closeConnection(con);
				
				session.setAttribute("created-title", title);
				response.sendRedirect("./show-post.jsp");
			} catch (Exception e) {
				out.print(e);
			}
		}
	}
	%>

	<form method="post">
		<h3>Title</h3>
		<input type="text" name="title">
		<h3>Question Content</h3>
		<textarea name="content" rows="10" cols="50"></textarea>
		<br> <input type="submit" value="submit">
	</form>
</body>
</html>