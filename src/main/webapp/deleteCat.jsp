<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.*"%>
<%
int id=Integer.parseInt(request.getParameter("id"));
String n=request.getParameter("name");
Connection con=null;
RequestDispatcher dispatcher =null;
   List<Integer> idList=new ArrayList<Integer>();
   try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	PreparedStatement pst=null;
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
	if (n.equals("inventory")){
	 pst= con.prepareStatement("delete from inventory where cid=?");}
	else if(n.equals("category")){
	 pst= con.prepareStatement("delete from category where cid=?");	
	}
	else if(n.equals("users")||n.equals("users1")){
		 pst= con.prepareStatement("delete from users where id=?");	
		}
	pst.setInt(1,id);
	int rowCount = pst.executeUpdate();
	if(n.equals("users"))
		dispatcher = request.getRequestDispatcher("vieweditmanagers.jsp");
	else if(n.equals("users1"))
		dispatcher = request.getRequestDispatcher("vieweditusers.jsp");
	else
	dispatcher = request.getRequestDispatcher("inventory_management.jsp");
	if (rowCount > 0) {
		request.setAttribute("delete", "success");
	} else {
		request.setAttribute("delete", "failed");
	}
	dispatcher.forward(request, response);
}
catch(Exception e){
	
	e.printStackTrace();}
%>
