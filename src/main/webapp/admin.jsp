
<% 
    if(session.getAttribute("role")==null){
	response.sendRedirect("login.jsp");}
	
	else if(session.getAttribute("role").equals("user")){
		request.setAttribute("status","adminaccess");
		response.sendRedirect("login.jsp");
	}
 %>

<%@ page import ="java.sql.Connection"%>
<%@ page import ="java.sql.DriverManager"%>
<%@ page import ="java.sql.PreparedStatement"%>
<%@ page import ="java.sql.ResultSet"%>
<%@ page import ="java.sql.SQLException"%>
<%@ page import ="java.util.*"%>
       	    <% int cn=0;
       	   Connection con=null;
       	   List<Integer> idList=new ArrayList<Integer>();
       	   try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
			PreparedStatement pst= con.prepareStatement("select * from category");
			ResultSet rs=pst.executeQuery();
			while(rs.next()) {
				idList.add(rs.getInt("cid"));
			}
			cn=idList.size();
			}
		catch(Exception e){
			e.printStackTrace();}finally {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}%>
<% int pn=0;
con=null;
   List<Integer> pidList=new ArrayList<Integer>();
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
	PreparedStatement pst= con.prepareStatement("select * from inventory");
	ResultSet rs=pst.executeQuery();
	while(rs.next()) {
		pidList.add(rs.getInt("cid"));
	}
	pn=pidList.size();
	}
catch(Exception e){
	e.printStackTrace();}finally {
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}}%>
<% int mn=0;
       	   con=null;
       	   List<Integer> midList=new ArrayList<Integer>();
       	   String a="manager";
       	   try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
			PreparedStatement pst= con.prepareStatement("select * from users where urole=?");
			pst.setString(1, a);
			ResultSet rs=pst.executeQuery();
			while(rs.next()) {
				midList.add(rs.getInt("id"));
			}
			mn=midList.size();
			}
		catch(Exception e){
			e.printStackTrace();}finally {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}%>
				<% int un=0;
       	   con=null;
       	   List<Integer> uidList=new ArrayList<Integer>();
       	   try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
			PreparedStatement pst= con.prepareStatement("select * from users");
			ResultSet rs=pst.executeQuery();
			while(rs.next()) {
				uidList.add(rs.getInt("id"));
			}
			un=uidList.size();
			}
		catch(Exception e){
			e.printStackTrace();}finally {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Panel</title>
<%@include file="components/Common_css_js.jsp"%>
<style>
.card:hover {
	background-color: #EFEFEF;
}
</style>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
<body>

	<div class="container">
		<h1 class="text-center mt-5">Welcome, <%=session.getAttribute("name") %>.</h1>

		<!-- First Row -->
		<div class="row mt-5">
			<div class="col-md-3">
			<%
			if(session.getAttribute("role")==null||session.getAttribute("role").equals("admin")){%>
				<div class="card text-center">
				
					<div class="card-body">
						<div class="container">
							<img style="max-width: 100px" class="img-fluid"
								src="images/users.png" alt="Users">
						</div>
						 
						<h1><%=un %></h1>
						<h1>Users</h1> 
					</div>
				</div><%} %> 
			</div>

			<div class="col-md-3">
				<div class="card text-center">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 100px" class="img-fluid"
								src="images/categories.png" alt="Users">

						</div>
						<h1><%=cn %></h1>
						<h1>Categories</h1>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-center">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 100px" class="img-fluid"
								src="images/products.png" alt="Users">

						</div>
						<h1><%=pn %></h1>
						<h1>Products</h1>
					</div>
				</div>
			</div>
			<div class="col-md-3">
			<%if(session.getAttribute("role")==null||session.getAttribute("role").equals("admin")){%>
				<div class="card text-center">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 100px" class="img-fluid"
								src="images/managers.png" alt="Users">

						</div>
						<h1><%=mn %></h1>
						<h1>Managers</h1>
					</div>
				</div><%} %>
			</div>
		</div>

		<!-- Second Row -->
		<div class="row mt-5">
			<div class="col-md-3">
			<%if(session.getAttribute("role")==null||session.getAttribute("role").equals("admin")){%>
				<div class="card text-center">
					<div class="card-body">
						<a href="OrderHistory.jsp" class="btn btn-success">Order History</a>
					</div>
				</div><%} %>
			</div>
			
			<div class="col-md-3">
				<div class="card text-center">
					<div class="card-body">
						<a href="vieweditusers.jsp" class="btn btn-success">Add/Remove Users</a>
					</div>
				</div>
			</div>
			
			<div class="col-md-3">
				<div class="card text-center">
					<div class="card-body">
						<a href="inventory_management.jsp" class="btn btn-success">Inventory
							Management</a>
					</div>
				</div>
			</div>
			
			
			
			<div class="col-md-3">
			<%if(session.getAttribute("role")==null||session.getAttribute("role").equals("admin")){%>
				<div class="card text-center">
					<div class="card-body">
						<a href="vieweditmanagers.jsp" class="btn btn-success">Add/Remove
							Managers</a>
					</div>
				</div><%} %>
			</div>

		</div>

	</div>

</body>
</html>