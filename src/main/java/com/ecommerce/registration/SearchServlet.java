package com.ecommerce.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class SearchServlet
 */
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String n=request.getParameter("Search").toLowerCase();
		Connection con=null;
		RequestDispatcher dispatcher =null;
		   List<Integer> pidList=new ArrayList<Integer>();
		   try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
			PreparedStatement pst= con.prepareStatement("select * from inventory");
			ResultSet rs=pst.executeQuery();
			while(rs.next()) {
				pidList.add(rs.getInt("cid"));
			}
			for(int i: pidList){
				pst= con.prepareStatement("select* from inventory where cid=?");
				pst.setInt(1, i);
				rs=pst.executeQuery(); 
				
			 if (rs.next()) {
				 if(rs.getString("catitle").equals(n))
				 {
					 dispatcher=request.getRequestDispatcher("index.jsp?id="+rs.getString("cid"));
					 dispatcher.forward(request,response);
				 }
				}}
			}
		catch(Exception e){
			e.printStackTrace();}finally {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}
	}

}
