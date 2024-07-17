<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
String userid = (String) session.getAttribute("user");
Integer cid = (Integer) session.getAttribute("customer-id");
String title = (String) session.getAttribute("created-title");
session.removeAttribute("title");
%>
<title><%=title%></title>
<style>
#question, #answer {
	border: 1px solid black;
	margin: 2%;
	padding: 25px;
}

#go {
	margin: 2%;
	padding: 25px;
}

h2 {
	margin: 2%;
}
</style>
</head>
<body>
	<%
	
	if (request.getMethod().equalsIgnoreCase("post")) {
		title = request.getParameter("title");
		cid = Integer.valueOf(request.getParameter("cid"));
	}
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String selectAsk = "SELECT * FROM ask_question WHERE title = ? AND cid = ?";
		
		String selectAnswer = "SELECT reply FROM answer_question WHERE title = ? AND cid = ?";	

		PreparedStatement ps = con.prepareStatement(selectAsk);
		ps.setString(1, title);
		ps.setInt(2, cid);

		ResultSet rs = ps.executeQuery();
		rs.next();
	%>
	<div id="container">
		<div id="question-section">
			<h2><%=rs.getString("title")%></h2>
			<div id="question">
				<h4>
					Author ID:
					<%=rs.getInt("cid")%></h4>
				<div>
					<%=rs.getString("content")%>
				</div>
			</div>
		</div>
		<%
		ps = con.prepareStatement(selectAnswer);
		ps.setString(1, title);
		ps.setInt(2, cid);

		ResultSet rs2 = ps.executeQuery();
		if (rs2.next()) {
		%>
		<div id="answer-section">
			<h2>Representative Reply:</h2>
			<div id="answer">
				<br>
				<div>
					<%=rs2.getString("reply")%>
				</div>
			</div>
		</div>

		<%
		}
		%>
	</div>
	<%
	db.closeConnection(con);
	} catch (Exception e) {
	out.print(e);
	}
	%>
	<div id="go">
		<form method="post" action="./browse.jsp">
			<label>Browse Forum: </label> <input type="submit" value="go">
			<input type="hidden" name="refresh" value="true">
		</form>
	</div>
</body>
</html>