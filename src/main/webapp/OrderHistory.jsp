<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="components/Common_css_js.jsp"%>
</head>
<body>
<%@include file="components/navbar.jsp"%>
<table class="styled-table">
		<div class="container text-center">
				<thead>
					<tr>
						<td>Order ID</td>
						<td>UserName</td>
						<td>Email</td>
						<td>Phone Number</td>
						<td>Order</td>
						<td>Total Price</td>
						<td>Date</td>
					</tr>
				</thead>
					<tr>
						<td>123</td>
						<td>Leah</td>
						<td>f20202291@hyderabad.bits-pilani.ac.in</td>
						<td>1234123490</td>
						<td><table>
							<thead>
							<tr><td>Item</td><td>Price</td>
							</tr>
							</thead>
							<tr><td>Banana x 1</td><td>36</td>
							</tr>
							<tr><td>Apples x 1</td><td>99</td>
							</tr>
							
							</table></td>
						<td>Rs. 135</td>
						<td>22-11-2022</td>
					</tr>
					<tr>
						<td>234</td>
						<td>Aditya</td>
						<td>example@gmail.com</td>
						<td>1234123490</td>
						<td><table>
							<thead>
							<tr><td>Item</td><td>Price</td>
							</tr>
							</thead>
							<tr><td>Banana x 1</td><td>36</td>
							</tr>
							<tr><td>Apples x 1</td><td>99</td>
							</tr>
							
							</table></td>
						<td>Rs. 135</td>
						<td>15-06-2022</td>
					</tr>
			</table>
			</div>
</body>
</html>