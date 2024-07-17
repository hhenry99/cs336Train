<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Schedules</title>
</head>
<body>
	<%
	Integer stationid = Integer.valueOf(request.getParameter("station-id"));

	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String select = "SELECT ts.transit_name Transit_Line, origin.name Origin, destination.name Destination "
		+ "FROM trainschedule ts ";

		String selectOrigin = select + "JOIN station origin ON origin.station_id = ts.origin_station_id "
		+ "JOIN station destination ON destination.station_id = ts.destination_station_id "
		+ "WHERE origin.station_id = ?";

		String selectDestination = select
		+ "JOIN station destination ON destination.station_id = ts.destination_station_id "
		+ "JOIN station origin ON origin.station_id = ts.origin_station_id " + "WHERE destination.station_id = ?";

		PreparedStatement ps = con.prepareStatement(selectOrigin);
		ps.setInt(1, stationid);

		ResultSet rsOrigin = ps.executeQuery();

		ps = con.prepareStatement(selectDestination);
		ps.setInt(1, stationid);

		ResultSet rsDestination = ps.executeQuery();

		ps = con.prepareStatement("SELECT name FROM station WHERE station_id = ?");
		ps.setInt(1, stationid);
		
		ResultSet rsName = ps.executeQuery();
		rsName.next();
	%>

	<h1>Schedules for <%=rsName.getString("name")%></h1>
	<br>
	<div>
		<h4>Origin</h4>
		<table style="border: 1px solid black;">
			<tr style="border: 1px solid black;">
				<th style="border: 1px solid black;"><label>Transit
						Line</label></th>
				<th style="border: 1px solid black;"><label>Origin</label></th>
				<th style="border: 1px solid black;"><label>Destination</label></th>
			</tr>

			<%
				boolean isEmptySet = true;

				while (rsOrigin.next()) {
					isEmptySet = false;
			%>

			<tr>
				<td style="border: 1px solid black;"><%=rsOrigin.getString("Transit_Line")%></td>

				<td style="border: 1px solid black;"><%=rsOrigin.getString("Origin")%></td>

				<td style="border: 1px solid black;"><%=rsOrigin.getString("Destination")%></td>
			</tr>

			<%
			}
			if (isEmptySet) {
			%>

			<tr>
				<td colspan="3">No Train Schedule Data! Add a train schedule</td>
			</tr>

			<%
			}
			%>
		</table>
	</div>

	
	<div>
	<h4>Destination</h4>
	<table style="border: 1px solid black;">
			<tr style="border: 1px solid black;">
				<th style="border: 1px solid black;"><label>Transit
						Line</label></th>
				<th style="border: 1px solid black;"><label>Origin</label></th>
				<th style="border: 1px solid black;"><label>Destination</label></th>
			</tr>

			<%
				isEmptySet = true;

				while (rsDestination.next()) {
					isEmptySet = false;
			%>

			<tr>
				<td style="border: 1px solid black;"><%=rsDestination.getString("Transit_Line")%></td>

				<td style="border: 1px solid black;"><%=rsDestination.getString("Origin")%></td>

				<td style="border: 1px solid black;"><%=rsDestination.getString("Destination")%></td>
			</tr>

			<%
			}
			if (isEmptySet) {
			%>

			<tr>
				<td colspan="3">No Train Schedule Data! Add a train schedule</td>
			</tr>

			<%
			}
			db.closeConnection(con);
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