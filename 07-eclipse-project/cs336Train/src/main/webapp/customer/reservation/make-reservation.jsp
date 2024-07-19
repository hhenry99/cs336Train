<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Make Reservation</title>
</head>
<body>
	<h1>Make Reservation</h1>
	<form method="post">
		<label for="train-id">Train ID:</label> 
		<input type="text" id="train-id" name="train-id" required> 
		<br><br> 
		<label for="rdate">Reservation Date:</label> 
		<input type="date" id="rdate" name="rdate" required>
		<br><br>
		<input type="radio" name="type" id="adult" value="adult" checked>
		<label for="adult">Adult</label>
		<input type="radio" name="type" id="child" value="child">
		<label for="child">Child (50% discount)</label>
		<input type="radio" name="type" id="" value="senior">
		<label for="senior">Senior (50% discount)</label>
		<input type="radio" name="type" id="" value="disabled">
		<label for="Disabled">Disabled (50% discount)</label>
		<br><br>
		<input type="submit" value="Make Reservation">
	</form>
	<%
	if (request.getMethod().equalsIgnoreCase("post")) {
		int cid = (Integer) session.getAttribute("customer-id");
		int trainid = Integer.parseInt(request.getParameter("train-id"));
		String rdate = request.getParameter("rdate");
		float fare = 0;

		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			String select = "SELECT ts.fare " + "FROM train t, trainschedule ts, train_has_schedule ths "
			+ "WHERE t.train_id = ths.train_id " + "AND ths.transit_name = ts.transit_name " + "AND t.train_id = ?";

			PreparedStatement ps = con.prepareStatement(select);
			ps.setInt(1, trainid);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				fare = rs.getFloat("fare");
				switch (request.getParameter("type")) {
				case "child" :
				case "senior" :
				case "disabled":
					fare = fare / 2;
					break;
				default:
					break;
				}
			}

			String maxResNum = "SELECT MAX(reservation_number) max FROM reservation";
			ps = con.prepareStatement(maxResNum);
			rs = ps.executeQuery();

			int resNum = 1;
			if (rs.next()) {
				resNum = rs.getInt("max") + 1;
			}

			String insert = "INSERT INTO reservation VALUES (?, ?, ?, ?)";

			ps = con.prepareStatement(insert);
			ps.setInt(1, resNum);
			ps.setString(2, rdate);
			ps.setFloat(3, fare);
			ps.setInt(4, cid);
			ps.executeUpdate();

			insert = "INSERT INTO isfortrainreservation VALUES (?, ?)";

			ps = con.prepareStatement(insert);
			ps.setInt(1, resNum);
			ps.setInt(2, trainid);
			ps.executeUpdate();

			response.getWriter().write("Reservation successfull");

			db.closeConnection(con);
		} catch (Exception e) {
			out.println(e);
		}
	}
	%>

	<div style="margin-left: 20px;">
		<h2>Train Schedule</h2>
		<table border="1">
			<tr>
				<th>Train ID</th>
				<th>Transit Line</th>
				<th>Departure</th>
				<th>Arrival</th>
				<th>Fare</th>
				<th>Origin</th>
				<th>Destination</th>
			</tr>
			<%
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();

				String select = "SELECT t.train_id, ts.transit_name, ts.dep_time, ts.arr_time, ts.fare, ts.origin_station_id, ts.destination_station_id " + "FROM train t "
				+ "JOIN train_has_schedule ths ON t.train_id = ths.train_id "
				+ "JOIN trainschedule ts ON ths.transit_name = ts.transit_name";

				PreparedStatement ps = con.prepareStatement(select);
				ResultSet rs = ps.executeQuery();

				while (rs.next()) {
					int trainId = rs.getInt("train_id");
					String transitName = rs.getString("transit_name");
					Timestamp depTime = rs.getTimestamp("dep_time");
					Timestamp arrTime = rs.getTimestamp("arr_time");
					int fare = rs.getInt("fare");
					
					int originID = rs.getInt("origin_station_id");
					int destinationID = rs.getInt("destination_station_id");
					
					String selectStation = "SELECT s.name FROM station s WHERE station_id = ?";
					
					String origin = "";
					String destination = "";
					
					PreparedStatement pst = con.prepareStatement(selectStation);
					pst.setInt(1, originID);
					
					ResultSet name = pst.executeQuery();
					
		
					
					if (name.next()) {
						origin = name.getString("name");
					}
					pst.setInt(1, destinationID);
					name = pst.executeQuery();
					if (name.next()) {
						destination = name.getString("name");
					}
			%>

			<tr>
				<td><%=trainId%></td>
				<td><%=transitName%></td>
				<td><%=depTime%></td>
				<td><%=arrTime%></td>
				<td><%=fare%></td>
				<td><%=origin%></td>
				<td><%=destination%>
				
			</tr>
			<%
			}
			db.closeConnection(con);
			} catch (Exception e) {
			out.println(e);
			}
			%>
		</table>
	</div>
</body>
</html>