<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forums</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String select = "SELECT * FROM ask_question WHERE answered = 0";

		Statement stmt = con.createStatement();

		ResultSet rs = stmt.executeQuery(select);

		if (request.getMethod().equalsIgnoreCase("post")) {
			String refresh = request.getParameter("refresh");
			if (refresh != null) {
		if (refresh.equalsIgnoreCase("true")) {
			response.sendRedirect("./browse.jsp");
		}
			}
			String search = "%" + request.getParameter("search-query") + "%";

			select = "SELECT * FROM ask_question q "
			+ "LEFT JOIN answer_question a ON (q.title = a.title AND q.cid = a.cid) "
			+ "WHERE (q.title LIKE ? OR q.content LIKE ? OR a.reply LIKE ?)";

			PreparedStatement ps = con.prepareStatement(select);
			ps.setString(1, search);
			ps.setString(2, search);
			ps.setString(3, search);

			rs = ps.executeQuery();
		} else {
		}

		while (rs.next()) {
		%>
		<div class="question"
			style="border: 1px solid black; padding: 15px; margin: 1%;">
			<form method="post" action="./answer-post.jsp">
				<label><%=rs.getString("title")%></label><input type="hidden"
					name="title" value="<%=rs.getString("title")%>"> <input
					type="hidden" name="cid" value="<%=rs.getInt("cid")%>"><input
					type="submit" value="view">
			</form>
		</div>

		<%
		}
		} catch (Exception e) {
		out.print(e);
		}
		%>
</body>
</html>