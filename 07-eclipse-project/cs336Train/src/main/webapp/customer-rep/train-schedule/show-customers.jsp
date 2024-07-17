<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customers</title>
</head>
<body>
	<%
	String transitLine = request.getParameter("transit-line");
	String date = request.getParameter("date");
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String select = "SELECT DISTINCT c.cid, c.first_name, c.last_name " + "FROM customer c "
		+ "JOIN reservation r ON c.cid = r.cid "
		+ "JOIN isfortrainreservation iftr ON r.reservation_number = iftr.reservation_number "
		+ "JOIN train_has_schedule ths ON iftr.train_id = ths.train_id " + "WHERE ths.transit_name = ? "
		+ "AND DATE(r.rdate) = ?";

		PreparedStatement ps = con.prepareStatement(select);
		ps.setString(1, transitLine);
		ps.setString(2, date);

		ResultSet rs = ps.executeQuery();
	%>

	<h1>
		Reservations for
		<%=transitLine%>
		on
		<%=date%></h1>
	<br>
	<div>
		<h2>Customers</h2>
		<table style="border: 1px solid black;">
			<tr style="border: 1px solid black;">
				<th style="border: 1px solid black;"><label>ID</label></th>
				<th style="border: 1px solid black;"><label>Name</label></th>
			</tr>

			<%
			boolean isEmptySet = true;

			while (rs.next()) {
				isEmptySet = false;
			%>

			<tr>
				<td style="border: 1px solid black;"><%=rs.getInt("cid")%></td>
				<td style="border: 1px solid black;"><%=rs.getString("first_name") + " " + rs.getString("last_name")%></td>
			</tr>

			<%
			}
			if (isEmptySet) {
			%>

			<tr>
				<td colspan="3">No Customer Data</td>
			</tr>

			<%
			}
			%>
		</table>
	</div>

	<%
	} catch (Exception e) {
	out.print(e);
	}
	%>
</body>
</html>