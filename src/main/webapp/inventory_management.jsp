<% 
    if(session.getAttribute("role")==null){
	response.sendRedirect("login.jsp");}
	
	else if(session.getAttribute("role").equals("user")){
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
<title>Inventory Management</title> 
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
<%@include file="components/Common_css_js.jsp"%>
</head>
<body>


<%@ page import ="java.sql.Connection"%>
<%@ page import ="java.sql.DriverManager"%>
<%@ page import ="java.sql.PreparedStatement"%>
<%@ page import ="java.sql.ResultSet"%>
<%@ page import ="java.sql.SQLException"%>
<%@ page import ="java.util.*"%>


       	    <% 
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
			}
		catch(Exception e){
			e.printStackTrace();}finally {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}%>

<%@include file="components/navbar.jsp"%>

<div class="container">

<!-- First Row -->
	<div class="row mt-5">
		<div class="col-md-5">
			<div class="card text-center">
				<div class="card-body">
					<a href="/InventoryManagemn" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#add-category-Modal">Add Category</a>
				</div>
			</div>
		</div>
		<div class="col-md-7">
			<div class="card text-center">
				<div class="card-body">
					<a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#add-product-Modal">Add Product</a>
				</div>
			</div>
		</div>
	</div>

<!-- Second Row -->

	<div class="row mt-5">
		<div class="col-md-5 d-flex justify-content-center">
				<table class="styled-table">
				
<% con=null;
   List<Integer> pidList=new ArrayList<Integer>();
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
	PreparedStatement pst= con.prepareStatement("select * from inventory");
	ResultSet rs=pst.executeQuery();
	while(rs.next()) {
		pidList.add(rs.getInt("cid"));
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

				<thead>
					<tr>
						<td>Category ID</td>
				<td>CategoryName</td>
				<td>Delete</td>
				</tr>
				</thead>
				<%  String m="";
String n="";
       			ResultSet rs=null;
       			for(int i: idList){
       			try {
       				
       				Class.forName("com.mysql.cj.jdbc.Driver");
       				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
       				PreparedStatement pst= con.prepareStatement("select* from category where cid=?");
       				pst.setInt(1, i);
       				rs=pst.executeQuery(); 
       				
       			 if (rs.next()) {
       				 m=rs.getString("catitle");
       				 n=rs.getString("cid");
       				}}
       			catch(Exception e){
       				e.printStackTrace();}
       				%>
<tr>

<td><%=n %></td>
<td><%=m %></td>

					<td><a href="deleteCat.jsp?id=<%=n %>&name=category">Delete</a></td>
					
</tr> <%} %>
				</table>
			
		</div>
		<div class="col-md-7 d-flex justify-content-center">
			<table class="styled-table">

				<thead>
				
					<tr>
						<td>Product ID</td>
						<td>Product Name</td>
						<td>Category</td>
						<td>Price</td>
						<td>Quantity</td>
						<td>Offers</td>
						<td>Delivery time(in days)</td>
						<td>Delete</td>
					</tr>
				</thead>
				<%  int pid=0;
                    String pname="";
                    String cat="";
        			int pprice=0;
        			int pquantity=0;
        			int poffer=0;
        			String pdesc="";
        			int pdel=0;
       			for(int i: pidList){
       			try {
       				
       				Class.forName("com.mysql.cj.jdbc.Driver");
       				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
       				PreparedStatement pst= con.prepareStatement("select* from inventory where cid=?");
       				pst.setInt(1, i);
       				rs=pst.executeQuery(); 
       				
       			 if (rs.next()) {
       				 pname=rs.getString("item_name");
       				 pid=rs.getInt("cid");
       				 cat=rs.getString("catitle");
       				 pprice=rs.getInt("current_price");
       				 pquantity=rs.getInt("quantity");
       				 poffer=rs.getInt("offer");
       				 pdel=rs.getInt("delivery_time");
       				}}
       			catch(Exception e){
       				e.printStackTrace();}
       				%>
					<tr>
						<td><%= pid%></td>
						<td><%=pname %></td>
						<td><%= cat%></td>
						<td><%=pprice %></td>
						<td><%= pquantity%></td>
						<td><%= poffer%></td>
						<td><%=pdel %></td>
						<td><a href="deleteCat.jsp?id=<%=pid %>&name=inventory">Delete</a></td>
					</tr><%} %>
			</table>
		</div>
</div>
</div>


	

<!-- Add Category Modal -->
<div class="modal fade" id="add-category-Modal" tabindex="-1" aria-labelledby="add-category-Label" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="add-category-Label">Fill category details</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
       <form method="post" action="InventoryManagementServlet">
       
        <input type="hidden" name="operation" value="addcategory">
       <input type="hidden" id="stats" value="<%=request.getAttribute("stats") %>">	
       
       		<div class="form-group">
       			<input type="text" class="form-control" name="categoryTitle" id="categoryTitle" placeholder="Enter category title" required="required" />
       		</div>
       		
       		
       		<div class="form-group mt-3">
       			<textarea style="height:200px" class="form-control" name="categoryDescription" placeholder="Enter category description" required="required"></textarea>
       		</div>
       		
       		<div class="btn btn-out-success">
								<input type="submit" name="submit" id="submit"
									class="form-submit" value="Add Category" />
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

	
	
	

<!-- Add Product Modal -->
<div class="modal fade" id="add-product-Modal" tabindex="-1" aria-labelledby="add-product-Label" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="add-product-Label">Fill product details</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
       <form action="InventoryManagementServlet" method="post" enctype="multipart/form-data">
       
       <input type="hidden" name="operation" value="addproduct">
       <input type="hidden" id="stats1" value="<%=request.getAttribute("stats1") %>">	
       
       		<div class="form-group">
       			<input type="text" class="form-control" name="productTitle" placeholder="Enter product title" required/>
       		</div>
       		
       		<div class="form-group mt-3">
       			<input type="text" class="form-control" name="productPrice" placeholder="Enter product price" required/>
       		</div>
       		<div class="form-group mt-3">
       			<input type="text" class="form-control" name="productQuantity" placeholder="Enter product quantity" required/>
       		</div>
       		<div class="form-group mt-3">
       			<input type="text" class="form-control" name="productOffers" placeholder="Enter product offers (if any)"/>
       		</div>
       		
       		<div class="form-group mt-3">
       			<input type="text" class="form-control" name="productDelivery" placeholder="Enter product delivery details" required></textarea>
       		</div>
       		
       		<div class="form-group mt-3">
       			<textarea style="height:200px" class="form-control" name="productDescription" placeholder="Enter product description" required></textarea>
       		</div>
       		 <%@ page import ="java.io.IOException"%>
<%@ page import ="java.sql.Connection"%>
<%@ page import ="java.sql.DriverManager"%>
<%@ page import ="java.sql.PreparedStatement"%>
<%@ page import ="java.sql.ResultSet"%>
<%@ page import ="java.sql.SQLException"%>
<%@ page import ="java.util.*"%>

       	   <%--  <% 
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
			}
		catch(Exception e){
			e.printStackTrace();}finally {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}%> --%>
       		
       		<!-- product category -->
       		<div class="form-group mt-3">
       			<select name="categoryId" class="form-control" id="">
       			<% m="1";
       			rs=null;
       			for(int i: idList){ 
       			try {
       				
       				Class.forName("com.mysql.cj.jdbc.Driver");
       				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
       				PreparedStatement pst= con.prepareStatement("select* from category where cid=?");
       				pst.setInt(1, i);
       				rs=pst.executeQuery(); 
       				
       			 if (rs.next()) {
       				 m=rs.getString("catitle");
       				}}
       			catch(Exception e){
       				e.printStackTrace();}
       				%>
       			
       			<option value="<%=m%>"><%=m%></option> <%}%> 
       			</select>
       		</div>  
       		
       		<!-- product file -->
       		<div class="form-group mt-3">
       		<label for="productPicture" >Select product picture:</label><br>
       			<input type="file" name="productPicture" required=""/>
       		</div><br><br>
       		
       		<div class="btn btn-out-success">
								<input type="submit" name="submit" id="submit"
									class="form-submit" value="Add Product" />
							</div>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        
       </form>
       
      </div>
      
    </div>
  </div>
</div>

 
 
 <script src="vendor/jquery/jquery.min.js"></script>
<script src="js/main.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">

	
	<script type="text/javascript">
	
	var statusp=document.getElementById("stats1").value;
	var statusc=document.getElementById("stats").value;
	var statusce=document.getElementById("stats3").value;
	
	if (statusp=="success"){
		swal("Yay!","Product added succesfully","success")
	}
	if (statusp=="fail"){
		swal("Sorry","Product could not be added succesfully","error")
	}
	if (statusc=="success"){
		swal("Yay!","Category added succesfully","success")
	}
	if (statusc=="fail"){
		swal("Sorry","Category could not be added succesfully","error")
	}
	if (statusce=="success"){
		swal("Yay!","Category edited succesfully","success")
	}
	if (statusce=="fail"){
		swal("Sorry","Category could not be edited succesfully","error")
	}
	</script>

</body>
</html>