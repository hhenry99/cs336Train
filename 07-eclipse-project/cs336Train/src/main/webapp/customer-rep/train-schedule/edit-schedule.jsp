<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<%
String existingTransitLine = request.getParameter("transit-name");
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>
	<%
	if (existingTransitLine != null) {
		out.print(existingTransitLine);
		existingTransitLine = existingTransitLine.trim();
		request.getSession().setAttribute("existingName", existingTransitLine);
	} else {
		out.print("Editing");
	}
	%>
</title>
<style>
div {
	border: 1px solid black;
	padding: 25px;
	margin: 2%;
}
</style>
</head>
<body>

	<%
	if (existingTransitLine != null && !existingTransitLine.isEmpty()) {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		Statement stmt = con.createStatement();

		String targetTuple = "SELECT * FROM trainschedule WHERE transit_name = ?";
		PreparedStatement pst = con.prepareStatement(targetTuple);
		pst.setString(1, existingTransitLine);

		ResultSet rs = pst.executeQuery();

		if (rs.next()) {
	%>

	<div id="edit-schedule-form">
		<h4>Edit</h4>
		<form method="post">
			<table>
				<tr>
					<td>Stops</td>
					<td><input type="text" name="edit-stops"
						value="<%=rs.getInt("stops")%>"></td>
				</tr>
				<tr>
					<td>Fare</td>
					<td><input type="text" name="edit-fare"
						value="<%=rs.getInt("fare")%>"></td>
				</tr>
				<tr>
					<td>Travel Time (minutes)</td>
					<td><input type="text" name="edit-travel-time"
						value="<%=rs.getInt("travel_time")%>"></td>
				</tr>
				<tr>
					<td>Arrival</td>
					<td><input type="text" name="edit-arrival"
						value="<%String arrival = rs.getString("arr_time");
out.print(arrival.substring(0, 16));%>"></td>
				</tr>
				<tr>
					<td>Departure</td>
					<td><input type="text" name="edit-departure"
						value="<%String departure = rs.getString("arr_time");
out.print(departure.substring(0, 16));%>"></td>
				</tr>
				<tr>
					<td>Origin</td>
					<td><input type="text" name="edit-origin"
						value="<%=rs.getInt("origin_station_id")%>"></td>
				</tr>
				<tr>
					<td>Destination</td>
					<td><input type="text" name="edit-destination"
						value="<%=rs.getInt("destination_station_id")%>"></td>
				</tr>
			</table>
			<input type="submit" value="submit">
		</form>
	</div>

	<%
	}
	} else {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	//get update values
	String editStopsStr = request.getParameter("edit-stops");
	String editFareStr = request.getParameter("edit-fare");
	String editTravelTimeStr = request.getParameter("edit-travel-time");
	String editDepartureTimeStr = request.getParameter("edit-arrival");
	String editArrivalTimeStr = request.getParameter("edit-departure");
	String editOriginStr = request.getParameter("edit-origin");
	String editDestinationStr = request.getParameter("edit-destination");

	//converts string value to integer
	Integer editStops = (editStopsStr != null && !editStopsStr.trim().isEmpty()) ? Integer.valueOf(editStopsStr) : null;
	Integer editFare = (editFareStr != null && !editFareStr.trim().isEmpty()) ? Integer.valueOf(editFareStr) : null;
	Integer editTravelTime = (editTravelTimeStr != null && !editTravelTimeStr.trim().isEmpty())
			? Integer.valueOf(editTravelTimeStr)
			: null;
	Timestamp editDepartureTime = (editDepartureTimeStr != null && !editDepartureTimeStr.trim().isEmpty())
			? Timestamp.valueOf(editDepartureTimeStr + ":00")
			: null;
	Timestamp editArrivalTime = (editArrivalTimeStr != null && !editArrivalTimeStr.trim().isEmpty())
			? Timestamp.valueOf(editArrivalTimeStr + ":00")
			: null;
	Integer editOrigin = (editOriginStr != null && !editOriginStr.trim().isEmpty()) ? Integer.valueOf(editOriginStr) : null;
	Integer editDestination = (editDestinationStr != null && !editDestinationStr.trim().isEmpty())
			? Integer.valueOf(editDestinationStr)
			: null;

	String update = "UPDATE trainschedule " + "SET stops = ?, fare = ?, "
			+ "travel_time = ?, dep_time = ?, arr_time = ?, " + "origin_station_id = ?, destination_station_id = ? "
					+ "WHERE transit_name = ?";

	PreparedStatement ps = con.prepareStatement(update);
	ps.setInt(2, editStops);
	ps.setInt(3, editFare);
	ps.setInt(4, editTravelTime);
	ps.setTimestamp(5, editDepartureTime);
	ps.setTimestamp(6, editArrivalTime);
	ps.setInt(7, editOrigin);
	ps.setInt(8, editDestination);
	ps.setString(9, (String) session.getAttribute("existingName"));

	ps.executeUpdate();

	db.closeConnection(con);

	response.sendRedirect("./train-schedule.jsp");
	}
	%>

</body>
</html>