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

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uemail=request.getParameter("username");
		String upwd=request.getParameter("password");
		HttpSession session=request.getSession();
		RequestDispatcher dispatcher =null;
		
		if (uemail==null||uemail.equals("")) {
			request.setAttribute("status","invalidemail");
			dispatcher=request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
		}
		if (upwd==null||uemail.equals("")) {
			request.setAttribute("status","invalidpassword");
			dispatcher=request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
		}
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
			PreparedStatement pst= con.prepareStatement("select* from users where uemail=? and upwd=?");
			pst.setString(1, uemail);
			pst.setString(2, upwd);
			
			ResultSet rs=pst.executeQuery();
			if(rs.next()) {
				session.setAttribute("name",rs.getString("uname"));
				session.setAttribute("id",rs.getInt("id"));
				session.setAttribute("role",rs.getString("urole"));
				session.setAttribute("stats", "loggedin");
				if(rs.getString("urole").equals("user")) {
					dispatcher=request.getRequestDispatcher("index.jsp");}
			
			
				else if(rs.getString("urole").equals("admin")||rs.getString("urole").equals("manager")) { 
			  dispatcher=request.getRequestDispatcher("admin.jsp"); }
				dispatcher.forward(request,response);}
			 
			else
			{
				session.setAttribute("stats", null);
				request.setAttribute("status", "failed");
				dispatcher=request.getRequestDispatcher("login.jsp");
				dispatcher.forward(request,response);
			}
			
					
		}catch(Exception e){
			e.printStackTrace();
			
		}
	}

}
