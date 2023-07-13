
<nav class="navbar navbar-expand-lg bg-light">
	<div class="container-fluid">
		<a class="navbar-brand" href="#"> <img
			src="images/logo-black.png" alt="Logo" width="30" height="30"
			class="d-inline-block align-text-center"> MegaMart
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
			 <%if(session.getAttribute("role")==null){%>
            <li class="nav-item"><a class="nav-link active"
					aria-current="page" href="index.jsp">Home</a></li><%} 
              else if(session.getAttribute("role").equals("admin")||session.getAttribute("role").equals("manager")){ %>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="admin.jsp">Main Page</a></li><%} 
            else{%>	 
            <li class="nav-item"><a class="nav-link active"
					aria-current="page" href="index.jsp">Home</a></li><%} %>
			</ul>

			<form class="d-flex box" role="Search" action="SearchServlet" method="post">
				<input class="form-control me-2" type="search" placeholder="Search"
					aria-label="Search" name="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>

			<div class="d-flex justify-content-end">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<%if((session.getAttribute("role")==null||session.getAttribute("role").equals("user"))){%>
				<li class="nav-item">
          <a class="nav-link active" aria-current="page" href="" data-bs-toggle="modal" data-bs-target="#cart"><i class="fa-solid fa-cart-plus" style="font-size: 20px;"></i><span style="margin-left: 2px;" class="cart-items">( 0 )</span></a>
        </li><%} %>
					<%if (session.getAttribute("stats")==null) {%>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="login.jsp">Login</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="registration.jsp">Register</a></li>
					<%}
       else {%>
					<a class="nav-link active" aria-current="page" href="#"><%=session.getAttribute("name") %></a>
					</li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="LogoutServlet">Logout</a></li>
					<%} %>
					<li class="nav-item"><a class="nav-link" href="#">Contact</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</nav>