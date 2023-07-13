<% 
    if(session.getAttribute("role")==null){
	response.sendRedirect("login.jsp");}
	
	else if(session.getAttribute("role").equals("user")||session.getAttribute("role").equals("manager")){
		request.setAttribute("status","adminaccess");
		response.sendRedirect("login.jsp");
	}
 %>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@include file="components/Common_css_js.jsp"%>
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<style>
.styled-table {
    border-collapse: collapse;
    margin: 25px 0;
    font-size: 0.9em;
    font-family: sans-serif;
    min-width: 400px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

.styled-table thead tr {
    background-color: #009879;
    color: #ffffff;
    text-align: left;
}

.styled-table th, td {
    padding: 12px 15px;
}</style>
</head>
<body>

<%@include file="components/navbar.jsp"%>
	<%@ page import="java.sql.Connection"%>
	<%@ page import="java.sql.DriverManager"%>
	<%@ page import="java.sql.PreparedStatement"%>
	<%@ page import="java.sql.ResultSet"%>
	<%@ page import="java.sql.SQLException"%>
	<%@ page import="java.util.*"%>
<% Connection con=null;
   List<Integer> uidList=new ArrayList<Integer>();
   String a="user";
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
	PreparedStatement pst= con.prepareStatement("select * from users where urole=?");
	pst.setString(1, a);
	ResultSet rs=pst.executeQuery();
	while(rs.next()) {
		uidList.add(rs.getInt("id"));
	}
	}
catch(Exception e){
	e.printStackTrace();}finally {
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}}%>

<!-- First Row -->
	<div class="row mt-5">
		<div class="col-md-12 d-flex justify-content-center">
					<a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#add-user-Modal">Add user</a>
				
		</div>
	</div>
	
<!-- Second Row -->
	<div class="row mt-5">
		<div class="col-md-12 d-flex justify-content-center">
				<table class="styled-table">

				<thead>
					<tr>
						<td>ID</td>
				<td>User Name</td>
				<td>Email</td>
				<td>Phone Number</td>
				<td>Delete</td>
				</tr>
				</thead>
				<%  String uid="2";
                    String uname="3";
                    String uemail="4";
                    String ucontact="4";
       			ResultSet rs=null;
       			for(int i: uidList){try {
       				
       				Class.forName("com.mysql.cj.jdbc.Driver");
       				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
       				PreparedStatement pst= con.prepareStatement("select* from users where id=?");
       				pst.setInt(1, i);
       				rs=pst.executeQuery(); 
       				
       			 if (rs.next()) {
       				 uid=rs.getString("id");
       				 uname=rs.getString("uname");
       				 uemail=rs.getString("uemail");
       				 ucontact=rs.getString("umobile");
       				}}
       			catch(Exception e){
       				e.printStackTrace();}
       			
       				%>
				<tr>
					<td><%=uid %></td>
					<td><%=uname %></td>
					<td><%=uemail %></td>
					<td><%=ucontact %></td>
					<td><a href="deleteCat.jsp?id=<%=uid %>&name=users1"">Delete</a></td>
				</tr><%} %>
				</table>
			
		</div>
	</div>

<!-- Add user Modal -->
<div class="modal fade" id="add-user-Modal" tabindex="-1" aria-labelledby="add-user-Label" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="add-user-Label">Fill user details</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
       <form method="post" action="EditUsersServlet">
       
        <input type="hidden" name="operation" value="editcategory">
       <input type="hidden" id="stats3" value="<%=request.getAttribute("stats3") %>">	
       
       		<div class="form-group">
       			<input type="text" class="form-control" name="userName" id="userName" placeholder="Enter user name" required="required" />
       		</div>
       		
       		<div class="form-group mt-3">
       			<input type="text" class="form-control" name="userContact" id="userContact" placeholder="Enter user contact details" required="required" />
       		</div>
       		
       		<div class="form-group mt-3">
       			<input type="email" class="form-control" name="userEmail" placeholder="Enter user Email" required/>
       		</div>
       		
       		<div class="form-group mt-3">
       			<input type="text" class="form-control" name="userPwd" placeholder="Enter user password" required/>
       		</div>
       		
       		<div class="btn btn-out-success">
				<input type="submit" name="submit" id="submit" class="form-submit" value="Add user" />
							</div>
       </form>
      </div>
      
      <div class="modal-footer">
      	
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        
      </div>
      
    </div>
  </div>
</div>

<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">
var status=document.getElementById("stats3").value;
	
	if (status=="success"){
		swal("Yay!","User added succesfully","success")
	}
	if (status=="fail"){
		swal("Sorry","User could not be added succesfully","error")
	}
	if (status=="invalidmob"){
		swal("Sorry","Invalid mobile no. entered","error")
	}
	if (status=="invalidemail"){
		swal("Sorry","Please enter a valid email","error")}
	if (status=="invalidmobn"){
		swal("Sorry","Mobile number should be of 10 digits","error")
	}
</script>
</body>
</html>