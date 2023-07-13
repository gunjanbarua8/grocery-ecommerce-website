package com.ecommerce.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.lang.*;

/**
 * Servlet implementation class InventoryManagementServlet
 */
@WebServlet("/inventory_management")
@MultipartConfig
public class InventoryManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
       
		HttpSession session=request.getSession();
		RequestDispatcher dispatcher =null;
		String op=request.getParameter("operation");
		if(op.trim().equals("addcategory")) {
			String c_title=request.getParameter("categoryTitle");
			String c_desc=request.getParameter("categoryDescription");
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
				PreparedStatement pst= con.prepareStatement("insert into category(catitle,catdesc)values(?,?)");
				pst.setString(1, c_title);
				pst.setString(2, c_desc);
				int rowCount = pst.executeUpdate();
				dispatcher = request.getRequestDispatcher("inventory_management.jsp");
				
				if (rowCount > 0) {
					request.setAttribute("stats", "success");
				} else {
					request.setAttribute("stats", "failed");
				}
				dispatcher.forward(request, response);
			}
			
			
			catch(Exception e){
				e.printStackTrace();}
			}
		else if(op.trim().equals("addproduct")) {
			String pname=request.getParameter("productTitle");
			int pprice=Integer.parseInt(request.getParameter("productPrice"));
			int pquantity=Integer.parseInt(request.getParameter("productQuantity"));
			int poffer=Integer.parseInt(request.getParameter("productOffers"));
			String pdesc=request.getParameter("productDescription");
			int pdel=Integer.parseInt(request.getParameter("productDelivery"));
			String catitle=request.getParameter("categoryId");
			Part part=request.getPart("productPicture");
			

			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
				PreparedStatement pst= con.prepareStatement("insert into inventory(item_name,current_price,offer,quantity,delivery_time,item_img,item_desc,catitle)values(?,?,?,?,?,?,?,?)");
				pst.setString(1,pname );
				pst.setInt(2, pprice);
				pst.setInt(3, poffer);
				pst.setInt(4, pquantity);
				pst.setInt(5, pdel);
				pst.setString(6,part.getSubmittedFileName());
				pst.setString(7,pdesc);
				pst.setString(8,catitle);
				int rowCount = pst.executeUpdate();
				dispatcher = request.getRequestDispatcher("inventory_management.jsp");
				String path=request.getRealPath("images")+File.separator+"products"+File.separator+part.getSubmittedFileName();
				System.out.print(path);
				try{FileOutputStream fos=new FileOutputStream(path);
				InputStream is=part.getInputStream();
				byte data[]=new byte[is.available()];
				is.read(data);
				fos.write(data);
				fos.close();}
				catch(Exception e){
					e.printStackTrace();
				}
				if (rowCount > 0) {
					request.setAttribute("stats1", "success");
				} else {
					request.setAttribute("stats1", "failed");
				}
				dispatcher.forward(request, response);
			}
			
			
			catch(Exception e){
				e.printStackTrace();}
			
			
			
		}
		else if(op.trim().equals("editcategory")) {
			String c_title=request.getParameter("categoryTitle");
			String c_desc=request.getParameter("categoryDescription");
			int cid=Integer.parseInt(request.getParameter("categoryID"));
			PreparedStatement pst=null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
				if(c_title!=null&&c_desc!=null) {
				pst= con.prepareStatement("update category set catitle=?,catdesc=? where cid=?");
				pst.setString(1, c_title);
				pst.setString(2, c_desc);
				pst.setInt(3, cid);}
				else if(c_title!=null) {
					pst= con.prepareStatement("update category set catitle=? where cid=?");
					pst.setString(1, c_title);
					pst.setInt(2, cid);}
				else if(c_desc!=null) {
					pst= con.prepareStatement("update category set catdesc=? where cid=?");
					pst.setString(1, c_desc);
					pst.setInt(2, cid);}
				int rowCount = pst.executeUpdate();
				dispatcher = request.getRequestDispatcher("inventory_management.jsp");
				
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
		else if(op.trim().equals("editproduct")) {
			String pname=request.getParameter("productTitle");
			int pprice=Integer.parseInt(request.getParameter("productPrice"));
			int pquantity=Integer.parseInt(request.getParameter("productQuantity"));
			int poffer=Integer.parseInt(request.getParameter("productOffers"));
			String pdesc=request.getParameter("productDescription");
			int pdel=Integer.parseInt(request.getParameter("productDelivery"));
			String catitle=request.getParameter("categoryId");
			Part part=request.getPart("productPicture");
			

			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket?useSSL=false","root","12345");
				PreparedStatement pst= con.prepareStatement("insert into inventory(item_name,current_price,offer,quantity,delivery_time,item_img,item_desc,catitle)values(?,?,?,?,?,?,?,?)");
				pst.setString(1,pname );
				pst.setInt(2, pprice);
				pst.setInt(3, poffer);
				pst.setInt(4, pquantity);
				pst.setInt(5, pdel);
				pst.setString(6,part.getSubmittedFileName());
				pst.setString(7,pdesc);
				pst.setString(8,catitle);
				int rowCount = pst.executeUpdate();
				dispatcher = request.getRequestDispatcher("inventory_management.jsp");
				String path=request.getRealPath("images")+File.separator+"products"+File.separator+part.getSubmittedFileName();
				System.out.print(path);
				try{FileOutputStream fos=new FileOutputStream(path);
				InputStream is=part.getInputStream();
				byte data[]=new byte[is.available()];
				is.read(data);
				fos.write(data);
				fos.close();}
				catch(Exception e){
					e.printStackTrace();
				}
				if (rowCount > 0) {
					request.setAttribute("stats1", "success");
				} else {
					request.setAttribute("stats1", "failed");
				}
				dispatcher.forward(request, response);
			}
			
			
			catch(Exception e){
				e.printStackTrace();}
			
			
			
		}
		}
			
			
	}

