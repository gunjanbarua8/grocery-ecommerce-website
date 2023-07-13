
<%-- <%
if(session.getAttribute("role").equals("admin")){
	response.sendRedirect("admin.jsp");
}%> --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<title>Home</title>
<%@include file="components/Common_css_js.jsp"%>
</head>
<body>
<%@include file="components/navbar.jsp"%>

<div class="container-fluid">
	<div class="row mt-3 mx-2">
	
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
				
		
		<!--show categories -->
		<div class="col-md-2">
			
			<div class="list-group mt-4">
				<a href="index.jsp" class="list-group-item list-group-item-action active" aria-current="true">All products</a>
				
				
			

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
       				 //n=rs.getString("cid");
       				}}
       			catch(Exception e){
       				e.printStackTrace();}
       				%>
				
				<a href="index.jsp?category=<%=m %>" class="list-group-item list-group-item-action"><%=m %></a>
				
			<% 
       			}/* Rest of the backend loop*/
			%>
			
			</div>
	</div>
	
	<% con=null;
   List<Integer> pidList=new ArrayList<Integer>();
   PreparedStatement pst=null;
   String a=request.getParameter("category");
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
	if(a==null){
	pst= con.prepareStatement("select * from inventory");}
	else{
		pst= con.prepareStatement("select * from inventory where catitle=?");
		pst.setString(1,a);
	}
	rs=pst.executeQuery();
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
	
		<!--show products  -->
		<div class="col-md-10" style="background-color: white;">
			
			<!-- row -->
			
			<div class="row mt-4 mb-4">
				<!-- col full width of grid -->
				<div class="col-md-12">
					<div class="row row-cols-1 row-cols-md-3 g-4">
  						<%  int pid=0;
                    String pname="";
                    String cat="";
        			int pprice=0;
        			int price=0;
        			int pquantity=0;
        			int poffer=0;
        			String pdesc="";
        			int pdel=0;
        			String ppic="";
        			
       			for(int i: pidList){
       			try {
       				
       				Class.forName("com.mysql.cj.jdbc.Driver");
       				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
       				pst= con.prepareStatement("select* from inventory where cid=?");
       				pst.setInt(1, i);
       				rs=pst.executeQuery(); 
       				
       			 if (rs.next()) {
       				 pname=rs.getString("item_name");
       				 pdesc=rs.getString("item_desc");
       				 pid=rs.getInt("cid");
       				 cat=rs.getString("catitle");
       				 ppic=rs.getString("item_img");
       				 pprice=rs.getInt("current_price");
       				 poffer=rs.getInt("offer");
       				 pdel=rs.getInt("delivery_time");
       				}}
       			catch(Exception e){
       				e.printStackTrace();}
       			price=(100-poffer)*pprice/100;
       			String[] st=pdesc.split(" ");
       			String nd="";
       			if (st.length>10){
       				for(int j=0;j<10;j++){
       					nd=nd+" "+st[j];
       				}
       				pdesc=nd;
       			}
       				%>
  						<div class="col">
  						
  							 
    						<div class="card h-100">
      							<div class="container text-center">
      							<img src="images/products/<%=ppic %>" style="max-height:200px; max-width:100%; width:auto;" class="card-img-top m-2" alt="...">
      							</div>
      								<div class="card-body">
        								<h5 class="card-title"><%=pname %></h5>
        									<!-- USE A HELPER FUNCTION HERE TO DISPLAY ONLY SOME WORDS OF DESCRIPTION -->
        									<p class="card-text"><%=pdesc %></p>
      											<div class="card-footer"> 
      												<button class="btn btn-success text-white" onclick="add_to_cart(<%=pid%>,'<%=pname%>',<%=price%>)"> Add to Cart</button>
      												<button class="btn btn-outline-success"> Rs.<%=price %> <span class="text-secondary discount-label"><span class="og-price"><%=pprice %>/-</span> <%=poffer %>%</span></button>
      								</div>
    						</div>
  						</div>
  						
					</div>
					<%
		/*List Products in loop*/ }
		%>
				</div>
				
			</div>
			
			</div>
		
		
		
		</div>
		
	</div>
</div>
<%@include file="components/common_modals.jsp"%>

</body>
</html>