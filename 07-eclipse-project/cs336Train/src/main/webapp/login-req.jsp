<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login</title>
	</head>
	<body>
		<%
		String userid = request.getParameter("username");
		String pwd = request.getParameter("password");
		String table = request.getParameter("user");
		
		try{
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			Statement stmt = con.createStatement();
			
	        String query = "select * from " + table + " where username = ? and password = ?";
	        
	     	PreparedStatement pst = con.prepareStatement(query);
		    pst.setString(1, userid);
		    pst.setString(2, pwd);
		    
		    ResultSet rs = pst.executeQuery();
		    
		    if (rs.next()) {
		    	HttpSession s = request.getSession();
		    	
		        s.setAttribute("user", userid); 

		        if (table.equalsIgnoreCase("customer")) {
		        	response.sendRedirect("./success.jsp");
		        } else {
		        	response.sendRedirect("./customer-rep/rep-index.jsp");
		        }
		        
		    } else {
		        out.println("Invalid username or password <a href='login.jsp'>try again</a>");
		    }
			
		    rs.close();
		    pst.close();
		    con.close();
		        		
		} catch (Exception e) {
		    // Handle other exceptions
		    out.println("Unable to connect to DB. Please try again later.");
		    e.printStackTrace();
		}
		%>
	</body>
	

</html>