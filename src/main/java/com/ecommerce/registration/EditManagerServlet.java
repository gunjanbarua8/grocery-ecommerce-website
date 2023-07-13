package com.ecommerce.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class EditManagerServlet
 */
@WebServlet("/vieweditmanagers")
public class EditManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher =null;
		String uname=request.getParameter("managerName");
		String upwd=request.getParameter("managerPwd");
		String uemail=request.getParameter("managerEmail");
		
		if (uemail == null || uemail.equals("")) {
			request.setAttribute("stats2", "invalidemail");
			dispatcher = request.getRequestDispatcher("vieweditmanagers.jsp");
			dispatcher.forward(request, response);
		}

		if (upwd == null || upwd.equals("")) {
			request.setAttribute("stats2", "invalidpwd");
			dispatcher = request.getRequestDispatcher("vieweditmanagers.jsp");
			dispatcher.forward(request, response);
		}
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
				PreparedStatement pst= con.prepareStatement("insert into users(uname,uemail,urole,upwd)values(?,?,?,?)");
				pst.setString(1, uname);
				pst.setString(2, uemail);
				pst.setString(3, "manager");
				pst.setString(4, upwd);
				int rowCount = pst.executeUpdate();
				dispatcher = request.getRequestDispatcher("vieweditmanagers.jsp");
				
				if (rowCount > 0) {
					request.setAttribute("stats2", "success");
				} else {
					request.setAttribute("stats2", "failed");
				}
				dispatcher.forward(request, response);
			}
			
			
			catch(Exception e){
				e.printStackTrace();}
			}
	}


