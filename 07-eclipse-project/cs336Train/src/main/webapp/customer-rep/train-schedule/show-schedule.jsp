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
</body>
</html>