<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
Integer cid = Integer.valueOf(request.getParameter("cid"));
String title = request.getParameter("title");
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
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String selectAsk = "SELECT * FROM ask_question WHERE title = ? AND cid = ?";

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
	</div>
	<div>
		<div id="answer">
			<form method="post" action="./ans-success.jsp">
				<label>Answer: </label>
				<br>
				<textarea name="reply" rows="10" cols="50"></textarea>
				<br>
				<input type="submit" value="answer"> <input
					type="hidden" name="title" value="<%=rs.getString("title")%>">
					<input type="hidden" name="cid" value="<%=rs.getInt("cid")%>">
			</form>
		</div>
	</div>
	<%
	} catch (Exception e) {
	out.print(e);
	}
	%>

</body>
</html>