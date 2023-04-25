<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registration Form</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
      crossorigin="anonymous"
    />
    <style>
        .nav-container{
    		display: flex;
            height: 100vh;
            background-color: aqua;
    	}
    	.nav-item label{
            padding-left: 20px;
        }
        .active{
            background-color: rgb(115, 185, 185);
        }
        a label{
        	color: black;
        }
        .navbar-nav{
            width: 100%;
        }
    </style>
  </head>
  <body>
  
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
	 
    <div class = "nav-container">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item active">
              <a href="details.jsp"><label class="form-label py-2">Account Details</label></a>
          </li>
          <li class="nav-item">
              <a href="dynamic.jsp"><label class="form-label py-2">Edit Profile</label></a>
          </li>
          <li class="nav-item">
              <a href="balance.jsp"><label class="form-label py-2">Check Balance</label></a>
          </li>
          <li class="nav-item">
              <a href="transfer.jsp"><label class="form-label py-2">Transfer Money</label></a>
          </li>
      </ul>
    </div>

    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
