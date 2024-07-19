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

		//check for values from station add
		Integer newStationId = (newStationIdStr != null && !newStationIdStr.trim().isEmpty())
		? Integer.valueOf(newStationIdStr)
		: null;
		String newStationName = request.getParameter("name");
		String newStationCity = request.getParameter("city");
		String newStationState = request.getParameter("state");

		//checks for values from schedule add
		String newTransitLine = request.getParameter("transit-name");
		String newStopsStr = request.getParameter("stops");
		String newFareStr = request.getParameter("fare");
		String newTravelTimeStr = request.getParameter("travel-time");
		String newDepartureTimeStr = request.getParameter("arrival");
		String newArrivalTimeStr = request.getParameter("departure");
		String newOriginStr = request.getParameter("origin");
		String newDestinationStr = request.getParameter("destination");

		//converts string value to integer
		Integer newStops = (newStopsStr != null && !newStopsStr.trim().isEmpty()) ? Integer.valueOf(newStopsStr) : null;
		Integer newFare = (newFareStr != null && !newFareStr.trim().isEmpty()) ? Integer.valueOf(newFareStr) : null;
		Integer newTravelTime = (newTravelTimeStr != null && !newTravelTimeStr.trim().isEmpty())
		? Integer.valueOf(newTravelTimeStr)
		: null;
		Timestamp newDepartureTime = (newDepartureTimeStr != null && !newDepartureTimeStr.trim().isEmpty())
		? Timestamp.valueOf(newDepartureTimeStr + ":00")
		: null;
		Timestamp newArrivalTime = (newArrivalTimeStr != null && !newArrivalTimeStr.trim().isEmpty())
		? Timestamp.valueOf(newArrivalTimeStr + ":00")
		: null;
		Integer newOrigin = (newOriginStr != null && !newOriginStr.trim().isEmpty()) ? Integer.valueOf(newOriginStr) : null;
		Integer newDestination = (newDestinationStr != null && !newDestinationStr.trim().isEmpty())
		? Integer.valueOf(newDestinationStr)
		: null;

		//check for value from schedule delete
		String deleteTransitLine = request.getParameter("delete-transit-name");

		//check for value from station delete and convert to an Integer
		String deleteStationStr = request.getParameter("delete-station-id");
		Integer deleteStation = (deleteStationStr != null && !deleteStationStr.trim().isEmpty())
		? Integer.valueOf(deleteStationStr)
		: null;

		//handle station add
		if (newStationId != null && newStationName != null && !newStationName.trim().isEmpty() && newStationCity != null
		&& !newStationCity.trim().isEmpty() && newStationState != null && !newStationState.trim().isEmpty()) {

			try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String insert = "Insert INTO station VALUES (?, ?, ?, ?)";

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

			//handle schedule add
		} else if (newTransitLine != null && !newTransitLine.trim().isEmpty() && newStops != null && newFare != null
		&& newTravelTime != null && newDepartureTime != null && newArrivalTime != null && newOrigin != null
		&& newDestination != null) {
			try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		String maxTrainID = "SELECT MAX(train_id) max FROM train";
		PreparedStatement ps = con.prepareStatement(maxTrainID);
		ResultSet rs = ps.executeQuery();

		int trainId = 1;
		if (rs.next()) {
		trainId = rs.getInt("max") + 1;
		}
		
		String insertTrain = "INSERT INTO train VALUES (?)";
		
		ps = con.prepareStatement(insertTrain);
		ps.setInt(1, trainId);
		
		ps.executeUpdate();

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
		
		pst = con.prepareStatement("INSERT INTO train_has_schedule VALUES (?, ?)");
		pst.setInt(1, trainId);
		pst.setString(2, newTransitLine);
		
		pst.executeUpdate();

		db.closeConnection(con);
		response.sendRedirect(request.getRequestURI());
		return;
			} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed.");
			}
			
			//handle delete schedule
		} else if (deleteTransitLine != null && !deleteTransitLine.trim().isEmpty()) {
			try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String delete = "DELETE FROM trainschedule WHERE transit_name = ?";

		PreparedStatement pst = con.prepareStatement(delete);

		pst.setString(1, deleteTransitLine);

		int deletedRow = pst.executeUpdate();

		db.closeConnection(con);

		if (deletedRow > 0) {
			response.sendRedirect(request.getRequestURI());
		} else {
			response.getWriter().write("No schedule with the name provided.");
		}
			} catch (Exception e) {
		out.println(e);
		out.println("delete failed");
			}
			
			//handle station delete
		} else if (deleteStation != null) {
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();

				String delete = "DELETE FROM station WHERE station_id = ?";

				PreparedStatement pst = con.prepareStatement(delete);

				pst.setInt(1, deleteStation);

				int deletedRow = pst.executeUpdate();

				db.closeConnection(con);

				if (deletedRow > 0) {
					response.sendRedirect(request.getRequestURI());
				} else {
					response.getWriter().write("No station with the ID provided.");
				}
					} catch (Exception e) {
				out.println(e);
				out.println("delete failed");
					}
		}
	}
	%>

	<div style="display: flex; margin: 2%;">
		<div id="train-schedule-section"
			style="display: flex; flex-direction: column; border: 1px solid black; padding: 15px;">
			<div id="train-shedule">
				<h2>Train Schedules</h2>
				<table style="border: 1px solid black;">
					<tr style="border: 1px solid black;">
						<th style="border: 1px solid black;"><label>Transit
								Line</label></th>
						<th style="border: 1px solid black;"><label>Stops</label></th>
						<th style="border: 1px solid black;"><label>Fare</label></th>
						<th style="border: 1px solid black;"><label>Travel
								Time</label></th>
						<th style="border: 1px solid black; min-width: 100px;"><label>Departure</label></th>
						<th style="border: 1px solid black; min-width: 100px;"><label>Arrival</label></th>
						<th style="border: 1px solid black;"><label>Origin</label></th>
						<th style="border: 1px solid black;"><label>Destination</label></th>
					</tr>

					<%
					try {
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();

						Statement stmt = con.createStatement();

						String str = "SELECT * FROM trainschedule";

						ResultSet result = stmt.executeQuery(str);

						boolean isEmptySet = true;

						while (result.next()) {
							isEmptySet = false;
					%>

					<tr>
						<td style="border: 1px solid black;"><%=result.getString("transit_name")%></td>
						<td style="border: 1px solid black;"><%=result.getInt("stops")%></td>
						<td style="border: 1px solid black;"><%=result.getInt("fare")%></td>
						<td style="border: 1px solid black;"><%=result.getInt("travel_time")%></td>
						<td style="border: 1px solid black;">
							<%
							String arrival = result.getString("arr_time");
							out.print(arrival.substring(5, 15));
							%>
						</td>
						<td style="border: 1px solid black;">
							<%
							String departure = result.getString("arr_time");
							out.print(departure.substring(5, 15));
							%>
						</td>
						<td style="border: 1px solid black;"><%=result.getInt("origin_station_id")%></td>

						<td style="border: 1px solid black;"><%=result.getInt("destination_station_id")%></td>
					</tr>

					<%
					}
					if (isEmptySet) {
					%>

					<tr>
						<td colspan="8">No Train Schedule Data! Add a train schedule</td>
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
			<div id="schedule-edit" style="margin: 5px;">
				<h4>Edit Existing</h4>
				<form method="post" action="./edit-schedule.jsp">
				Transit Line:
					<input type="text" name="transit-name" placeholder="e.g. Express Line">
					<input type="submit" value="edit">
				</form>
			</div>
			<div id="schedule-delete">
				<h4>Delete Existing</h4>
				<form method="post">
				Transit Line:
					<input type="text" name="delete-transit-name"
						placeholder="e.g. Coastal Line"> <input type="submit"
						value="delete">
				</form>
			</div>
			<div id="add-schedule-form">
				<h4>Add New</h4>
				<form method="post">
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
		</div>
		<div id="station-section"
			style="margin-left: 20px; display: flex; flex-direction: column; align-items: stretch; border: 1px solid black; padding: 15px;">
			<div id="station-list">
				<h2>Station List</h2>
				<table style="border: 1px solid black;">
					<tr style="border: 1px solid black;">
						<th style="border: 1px solid black;"><label>ID</label></th>
						<th style="border: 1px solid black;"><label>Name</label></th>
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
					db.closeConnection(con);
					} catch (Exception e) {
					out.print(e);
					}
					%>

				</table>
			</div>
			<div id="station-delete">
				<h4>Delete Existing</h4>
				<form method="post">
				Station ID:
					<input type="text" name="delete-station-id" placeholder="e.g. 4">
					<input type="submit" value="delete">
				</form>
			</div>
			<div id="station-add" style="margin-top: 20px;">
				<h4>Add Station</h4>
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
	<div id="produce-lists" style="border: 1px solid black; margin: 2%; padding: 25px;">
		<h1>Produce Lists</h1>
		<br>
		<div id="search-by-station">
		<h4>Search Train Schedules by Station</h4>
		<form method="post" action="./show-schedules.jsp">
		<label>Station ID: </label><input type="text" name="station-id">
		<input type="submit" value="create list"> 
		</form>
		</div>
		<h4>Search Reservations by Date</h4>
		<form method="post" action="./show-customers.jsp">
		<label>Transit Line: </label><input type="text" name="transit-line">
		<label>Date: </label><input type="text" placeholder="YYYY-MM-DD" name="date">
		<input type="submit" value="create list">
		</form>
		</div>
</body>
</html>