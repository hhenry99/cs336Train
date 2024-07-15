<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
	if (request.getMethod().equalsIgnoreCase("post")) {
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//get values from form
			String newTransitLine = request.getParameter("transit-name");
			Integer newStops = Integer.valueOf(request.getParameter("stops"));
			Integer newFare = Integer.valueOf(request.getParameter("fare"));
			Integer newTravelTime = Integer.valueOf(request.getParameter("travel-time"));
			String newDepartureTimeStr = request.getParameter("arrival");
			String newArrivalTimeStr = request.getParameter("departure");
			Integer newOrigin = Integer.valueOf(request.getParameter("origin"));
			Integer newDestination = Integer.valueOf(request.getParameter("destination"));

			//converting Departure and Arrival times to datetime to store in DB
			Timestamp newDepartureTime = Timestamp.valueOf(newDepartureTimeStr + ":00");
			Timestamp newArrivalTime = Timestamp.valueOf(newArrivalTimeStr + ":00");

			String insert = "INSERT INTO trainschedule " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement pst = con.prepareStatement(insert);

			pst.setString(1, newTransitLine);
			pst.setInt(2, newStops);
			pst.setInt(3, newFare);
			pst.setInt(4, newTravelTime);
			pst.setTimestamp(5, newDepartureTime);
			pst.setTimestamp(6, newArrivalTime);
			pst.setInt(7, newOrigin);
			pst.setInt(8, newDestination);

			pst.executeUpdate();

			db.closeConnection(con);
			response.sendRedirect(request.getRequestURI());
			return;
		} catch (Exception ex) {
			out.print(ex);
			out.print("insert failed, go back to modify fields and re-add.");
		}
	}
	%>

	<h1>Train Schedule</h1>
	<table border="1">
		<tr>
			<th>Transit Line</th>
			<th>Stops</th>
			<th>Fare</th>
			<th>Travel Time</th>
			<th>Departure</th>
			<th>Arrival</th>
			<th>Origin</th>
			<th>Destination</th>
		</tr>
		
		<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			
			ResultSet rs = stmt.executeQuery("SELECT * FROM trainschedule");
			
			while (rs.next()) {
				String transitLine = rs.getString("transitLine");
				%>
				
				<tr>
				<td>
				<%out.print(transitLine);%>
				</td>
				<td>
				
				</td>
				</tr>
				
				<%
			}
			con.close();
		} catch (Exception e) {
			out.println(e);
		}
		%>
		<%
	
        %>
		
		
	</table>
</body>
</html>