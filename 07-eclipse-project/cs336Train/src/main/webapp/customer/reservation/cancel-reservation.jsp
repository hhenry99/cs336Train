<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cancel Reservation</title>
</head>
<body>
<h1>Cancel a Reservation</h1>
    <form method="post">
        <label for="reservation-number">Reservation Number:</label>
        <input type="text" id="reservation-number" name="reservation-number" required><br><br>
        <input type="submit" value="Cancel Reservation">
    </form>
    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            int resNum = Integer.parseInt(request.getParameter("reservation-number"));

            try {
            	ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();
                
                String delete1 = "DELETE FROM isfortrainreservation WHERE reservation_number = ?";
                String delete2 = "DELETE FROM reservation WHERE reservation_number = ?";
                
                PreparedStatement ps = con.prepareStatement(delete1);
                
                ps.setInt(1, resNum);
                
               	ps.executeUpdate();
               	
               	ps = con.prepareStatement(delete2);
               	
               	ps.setInt(1, resNum);
               	
            	ps.executeUpdate();

                
                db.closeConnection(con);
            } catch (Exception e) {
                out.println(e);
            }
        }
    %>
    
    <%
		int cid = (Integer) session.getAttribute("customer-id");

		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			String select = "SELECT r.reservation_number, r.rdate, r.total_fare, i.train_id " + "FROM reservation r "
			+ "JOIN isfortrainreservation i ON r.reservation_number = i.reservation_number " + "WHERE r.cid = ?";

			PreparedStatement ps = con.prepareStatement(select);
			ps.setInt(1, cid);
			ResultSet rs = ps.executeQuery();
	%>
	<h2>Current Reservations</h2>
	<table border="1">
		<tr>
			<th>Reservation Number</th>
			<th>Reservation Date</th>
			<th>Total Fare</th>
			<th>Train ID</th>
		</tr>
		<%
		while (rs.next()) {
			out.println("<tr>");
			out.println("<td>" + rs.getInt("reservation_number") + "</td>");
			out.println("<td>" + rs.getDate("rdate") + "</td>");
			out.println("<td>" + rs.getFloat("total_fare") + "</td>");
			out.println("<td>" + rs.getInt("train_id") + "</td>");
			out.println("</tr>");
		}
		%>
	</table>
	<%
	con.close();
	} catch (Exception e) {
	out.print(e);
	}
	%>
</body>
</html>