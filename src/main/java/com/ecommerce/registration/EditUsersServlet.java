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
@WebServlet("/vieweditusers")
public class EditUsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher =null;
		String uname=request.getParameter("userName");
		String uemail=request.getParameter("userEmail");
		String ucontact=request.getParameter("userContact");
		String upwd=request.getParameter("userPwd");
		if (uemail == null || uemail.equals("")) {
			request.setAttribute("stats3", "invalidemail");
			dispatcher = request.getRequestDispatcher("vieweditusers.jsp");
			dispatcher.forward(request, response);
		}
		if (ucontact == null || ucontact.equals("")) {
			request.setAttribute("stats3", "invalidmob");
			dispatcher = request.getRequestDispatcher("vieweditusers.jsp");
			dispatcher.forward(request, response);
		} else if (!(ucontact.length() == 10)) {
			request.setAttribute("stats3", "invalidmobn");
			dispatcher = request.getRequestDispatcher("vieweditusers.jsp");
			dispatcher.forward(request, response);

		}
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
				PreparedStatement pst= con.prepareStatement("insert into users(uname,uemail,urole,umobile,upwd)values(?,?,?,?,?)");
				pst.setString(1, uname);
				pst.setString(2, uemail);
				pst.setString(3, "user");
				pst.setString(4, ucontact);
				pst.setString(5, upwd);
				int rowCount = pst.executeUpdate();
				dispatcher = request.getRequestDispatcher("vieweditusers.jsp");
				
				if (rowCount > 0) {
					request.setAttribute("stats3", "success");
				} else {
					request.setAttribute("stats3", "failed");
				}
				dispatcher.forward(request, response);
			}
			
			
			catch(Exception e){
				e.printStackTrace();}
			}
	}


