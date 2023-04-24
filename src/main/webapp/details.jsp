<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Datails</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
      crossorigin="anonymous"
    />
    <style>
    	.detail_container{
    		display: flex;
    	}
    	.left{
            flex-basis: 15%;
        }
        .right{
            flex-basis: 85%;
            height: 100vh;
            background-color: burlywood;
        }
    </style>
  </head>
  <body>

	<%@ page import="jakarta.servlet.RequestDispatcher" %>
	<%! 
		private String firstName;
		private String lastName;
		private String fullName;
		private String accNumber;
		private String email;
		private String phone;
		private String dob;
		private String nominee;
	%>
	<%
		HttpSession hs = request.getSession();
		firstName = (String)hs.getAttribute("firstName");
		lastName = (String)hs.getAttribute("lastName");
		fullName = firstName+" "+lastName;
		email = (String)hs.getAttribute("email");
		phone = (String)hs.getAttribute("phone");
		dob = (String)hs.getAttribute("dob").toString();
		nominee = (String)hs.getAttribute("nominee");
		String acc = (String)hs.getAttribute("accNumber").toString();
		accNumber = "03941080226"+acc;
		
	%>  
	<jsp:include page="header.html"/>
  	<div class="detail_container">
  		<div class="left">
  			<jsp:include page="side_nav.jsp"/>
  		</div>
	    <div class="p-3 right">
	    	<label for="fullName" class="form-label">Full Name : </label>
	    	<label id="fullName" class="form-label"><%= fullName %></label><br>
	    	<label for="accNo" class="form-label">Account Number : </label>
	    	<label id="accNo" class="form-label"><%= accNumber %></label><br>
	    	<label for="dob" class="form-label">Date Of Birth : </label>
	    	<label id="dob" class="form-label"><%= dob %></label><br>
	    	<label for="nominee" class="form-label">Nominee Name : </label>
	    	<label id="nominee" class="form-label"><%= nominee %></label><br>
	    	<label for="email" class="form-label">Email Id : </label>
	    	<label id="email" class="form-label"><%= email %></label><br>
	    	<label for="phone" class="form-label">Phone Number : </label>
	    	<label id="phone" class="form-label"><%= phone %></label>
	    </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
