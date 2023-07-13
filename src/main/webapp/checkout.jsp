<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<%if(session.getAttribute("role")==null){ response.sendRedirect("login.jsp");request.setAttribute("status","adminaccess");}%>
<%@include file="components/Common_css_js.jsp"%>
</head>
<body>
<%@include file="components/navbar.jsp"%>
	<%@ page import="java.sql.Connection"%>
	<%@ page import="java.sql.DriverManager"%>
	<%@ page import="java.sql.PreparedStatement"%>
	<%@ page import="java.sql.ResultSet"%>
	<%@ page import="java.sql.SQLException"%>
	<%@ page import="java.util.*"%>


	<div class="container">
		<div class="row mt-5">
			<div class="col-md-6">
			<!-- cart -->
				<div class="card">
					<div class="card-body">
						<h3 class="text-center mb-3">Your selected items</h3>
						<div class="cart-body"></div>
					</div>
				</div>
			</div>
			
			<div class="col-md-6">
			<!-- form details -->
			<% Connection con=null;
String uid="2";
String uname="3";
String uemail="4";
String ucontact="4";
int id=0;
//int id=(Integer)session.getAttribute("id");
   //List<Integer> uidList=new ArrayList<Integer>();
   //String a="user";
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
	PreparedStatement pst= con.prepareStatement("select * from users");
	ResultSet rs=pst.executeQuery();
	while(rs.next()) {
			 uname=rs.getString("uname");
			 uemail=rs.getString("uemail");
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
				<div class="card">
					<div class="card-body">
						<h3 class="text-center mb-3">Your details for order</h3>
							<form action="CheckoutServlet" method="post">
							<div class="mb-3 row">
    							<label for="staticName" class="col-sm-4 col-form-label">Name</label>
   							<div class="col-sm-8">
      							<input type="text" readonly class="form-control-plaintext" id="staticName" value="<%="Leah" %>">
    						</div>
    						<label for="staticEmail" class="col-sm-4 col-form-label  mb-3">Email</label>
   							<div class="col-sm-8">
   							
      							<input type="text" readonly class="form-control-plaintext" id="staticEmail" value="<%="f20202291@hyderabad.bits-pilani.ac.in" %>">
    						</div>
    						
								<label for="phone" class="col-sm-4 mb-3">Phone Number</label>
								<div class="col-sm-8">
								<input type="tel" id="phone" name="phone" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}">
								</div>
  								<div class="mb-3">
  									<label for="exampleFormControlTextarea1" class="form-label">Delivery address</label>
  										<textarea class="form-control" id="address" placeholder="Enter your address" rows="3"></textarea>
								</div>
								<label for="pincode" class="col-sm-4 mb-3">Area pin code</label>
								<div class="col-sm-8">
								
   									 <input type="text" name="pin" pattern="([1-9]{1}[0-9]{5}|[1-9]{1}[0-9]{3}\\s[0-9]{3})" maxlength="6">
    								<input type="submit" value="Validate">

								</div>
								
								</div>
								
								<div class="container text-center">
  									<button type="submit" class="btn btn-outline-success">Order Now</button>
  									<button  type="submit" class="btn btn-outline-primary">Continue Shopping</button>
  								</div>
							</form>
						
					</div>
				</div>
			
			</div>
		</div>
	
	</div>
		<div class="row mt-3">
		<div class="col-md-6">
		 </div>
		<div class="col-md-6 d-flex justify-content-center">
		<div class="wallet-container text-center">
		<p class="page-title"></i>My E-wallet<i class="fa fa-user"></i></p>

		<div class="amount-box text-center">
			<img src="https://lh3.googleusercontent.com/ohLHGNvMvQjOcmRpL4rjS3YQlcpO0D_80jJpJ-QA7-fQln9p3n7BAnqu3mxQ6kI4Sw" alt="wallet">
			<p>Total Balance</p>
			<p class="amount">Rs. 1500</p>
		</div>

		<div class="btn-group text-center">
			<button type="button" class="btn btn-outline-light">Add Money</button>
			<button type="button" class="btn btn-outline-light">Widthdraw</button>
			</div>
		</div>
	</div>
	</div>

<%@include file="components/common_modals.jsp"%>
</body>
</html>