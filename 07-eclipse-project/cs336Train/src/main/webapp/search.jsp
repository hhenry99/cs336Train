<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>Search Results</h1>
    <%
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String date = request.getParameter("date");

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
        	ApplicationDB db = new ApplicationDB();	
            conn = db.getConnection();
            stmt = conn.createStatement();
            String query = "SELECT ts.transit_name, os.name AS origin, ds.name AS destination, ts.dep_time, ts.arr_time, ts.stops, ts.fare, ts.travel_time " +
                           "FROM TrainSchedule ts " +
                           "JOIN Station os ON ts.origin_station_id = os.station_id " +
                           "JOIN Station ds ON ts.destination_station_id = ds.station_id " +
                           "WHERE os.name = '" + origin + "' AND ds.name = '" + destination + "' AND DATE(ts.dep_time) = '" + date + "'";
            rs = stmt.executeQuery(query);

            if (!rs.isBeforeFirst()) {
                out.println("<p>No results found for the given search criteria.</p>");
            } else {
                out.println("<table>");
                out.println("<thead><tr><th>Transit Name</th><th>Origin</th><th>Destination</th><th>Departure Time</th><th>Arrival Time</th><th>Stops</th><th>Fare</th><th>Travel Time</th></tr></thead>");
                out.println("<tbody>");

                while (rs.next()) {
                    String transitName = rs.getString("transit_name");
                    String originName = rs.getString("origin");
                    String destinationName = rs.getString("destination");
                    String depTime = rs.getString("dep_time");
                    String arrTime = rs.getString("arr_time");
                    int stops = rs.getInt("stops");
                    int fare = rs.getInt("fare");
                    int travelTime = rs.getInt("travel_time");

                    out.println("<tr>");
                    out.println("<td>" + transitName + "</td>");
                    out.println("<td>" + originName + "</td>");
                    out.println("<td>" + destinationName + "</td>");
                    out.println("<td>" + depTime + "</td>");
                    out.println("<td>" + arrTime + "</td>");
                    out.println("<td>" + stops + "</td>");
                    out.println("<td>" + fare + "</td>");
                    out.println("<td>" + travelTime + "</td>");
                    out.println("</tr>");

                    // Nested table for stops
                    out.println("<tr><td colspan='8'>");
                    out.println("<table>");
                    out.println("<tr><th>Station</th><th>Arrival</th><th>Departure</th></tr>");

                    String stopsQuery = "SELECT s.name AS station_name, st.arrival, st.depart " +
                                        "FROM Stops st " +
                                        "JOIN Station s ON st.station_id = s.station_id " +
                                        "JOIN Train_Has_Schedule ths ON st.train_id = ths.train_id " +
                                        "WHERE ths.transit_name = '" + transitName + "' " +
                                        "ORDER BY st.arrival";
                    Statement stopsStmt = conn.createStatement();
                    ResultSet stopsRs = stopsStmt.executeQuery(stopsQuery);

                    while (stopsRs.next()) {
                        String stationName = stopsRs.getString("station_name");
                        String arrival = stopsRs.getString("arrival");
                        String depart = stopsRs.getString("depart");

                        out.println("<tr>");
                        out.println("<td>" + stationName + "</td>");
                        out.println("<td>" + arrival + "</td>");
                        out.println("<td>" + depart + "</td>");
                        out.println("</tr>");
                    }

                    stopsRs.close();
                    stopsStmt.close();

                    out.println("</table>");
                    out.println("</td></tr>");
                }

                out.println("</tbody>");
                out.println("</table>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>