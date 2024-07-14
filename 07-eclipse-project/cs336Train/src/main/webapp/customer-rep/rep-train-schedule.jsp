<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Train Schedule</title>
</head>
<body>

<%
if (request.getMethod().equalsIgnoreCase("post")) {
	String newStationIdStr = request.getParameter("station-id");

	Integer newStationId = (newStationIdStr != null && !newStationIdStr.trim().isEmpty())
	? Integer.valueOf(newStationIdStr)
	: -1;
	
	String newStationName = request.getParameter("name");
	String newStationCity = request.getParameter("city");
	String newStationState = request.getParameter("state");
	
	if (newStationId != null && newStationName != null && !newStationName.trim().isEmpty() && newStationCity != null
			&& !newStationCity.trim().isEmpty() && newStationState != null && !newStationState.trim().isEmpty()) {
		
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			String insert = "Insert INTO station " + "VALUES (?, ?, ?, ?)";

			PreparedStatement pst = con.prepareStatement(insert);
			pst.setInt(1, newStationId);
			pst.setString(2, newStationState);
			pst.setString(3, newStationCity);
			pst.setString(4, newStationName);

			pst.executeUpdate();
			
			db.closeConnection(con);
			response.sendRedirect(request.getRequestURI());
			return;
		} catch (Exception e) {
			out.print(e);
		}
				
			}
}
%>

	<div style="display: flex; margin: 2%;">
		<div id="add-schedule-form">
			<h2>Add Train Schedule</h2>
			<br>
			<form method="post" action="./train-schedule/show-schedule.jsp">
				<table>
					<tr>
						<td>Transit Name</td>
						<td><input type="text" name="transit-name"></td>
					</tr>
					<tr>
						<td>Stops</td>
						<td><input type="text" name="stops"></td>
					</tr>
					<tr>
						<td>Fare</td>
						<td><input type="text" name="fare"></td>
					</tr>
					<tr>
						<td>Travel Time (minutes)</td>
						<td><input type="text" name="travel-time"></td>
					</tr>
					<tr>
						<td>Arrival</td>
						<td><input type="text" name="arrival"
							placeholder="YYYY-MM-DD HH:MM"></td>
					</tr>
					<tr>
						<td>Departure</td>
						<td><input type="text" name="departure"
							placeholder="YYYY-MM-DD HH:MM"></td>
					</tr>
					<tr>
						<td>Origin</td>
						<td><input type="text" name="origin"></td>
					</tr>
					<tr>
						<td>Destination</td>
						<td><input type="text" name="destination"></td>
					</tr>
				</table>
				<input type="submit" value="Add">
			</form>
		</div>
		<div id="station-section"
			style="margin-left: auto; display: flex; flex-direction: column; align-items: stretch;">
			<div id="station-list">
				<h2>Station List</h2>
				<table style="border: 1px solid black;">
					<tr style="border: 1px solid black;">
						<td style="border: 1px solid black;"><label>ID</label></td>
						<td style="border: 1px solid black;"><label>Name</label></td>
					</tr>

					<%
					try {
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();

						Statement stmt = con.createStatement();

						String str = "SELECT station_id, name " + "FROM station";

						ResultSet result = stmt.executeQuery(str);

						boolean isEmptySet = true;

						while (result.next()) {
							isEmptySet = false;
					%>

					<tr>
						<td style="border: 1px solid black;"><%=result.getString("station_id")%></td>
						<td style="border: 1px solid black;"><%=result.getString("name")%></td>
					</tr>

					<%
					}
					if (isEmptySet) {
					%>

					<tr>
						<td colspan="2">No Station Data! Add Stations before creating
							a train schedule</td>
					</tr>

					<%
					}
					%>

					<%
					db.closeConnection(con);
					%>

					<%
					} catch (Exception e) {
					out.print(e);
					}
					%>

				</table>
			</div>

			<div id="station-add" style="margin-top: 20px;">
				<form method="post">
					<table>
						<tr>
							<td>Station ID</td>
							<td><input type="text" name="station-id"></td>
						</tr>
						<tr>
							<td>Name</td>
							<td><input type="text" name="name"></td>
						</tr>
						<tr>
							<td>City</td>
							<td><input type="text" name="city"></td>
						</tr>
						<tr>
							<td>State</td>
							<td><input type="text" name="state"></td>
						</tr>
					</table>
					<input type="submit" value="add station" style="margin: 5px auto;">
				</form>
			</div>
		</div>
	</div>
</body>
</html>