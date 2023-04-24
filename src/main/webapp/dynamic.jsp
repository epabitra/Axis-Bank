<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Axis Bank</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
      crossorigin="anonymous"
    />
    <script
	  src="https://code.jquery.com/jquery-3.6.0.js"
	  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	  crossorigin="anonymous">
  	</script>
    <style>
        .container2{
            display: flex;
        }
        .left{
            flex-basis: 15%;
            height: 100vh;
            background-color: aqua;
        }
        .right{
            flex-basis: 85%;
            height: 100vh;
            background-color: burlywood;
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
  	<jsp:include page="header.html"></jsp:include>
    <div class="container2">
        <div class="left">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a href="details.jsp"><label class="form-label py-2">Account Details</label></a>
                </li>
                <li class="nav-item active">
                    <label class="form-label py-2">Edit Profile</label>
                </li>
                <li class="nav-item">
                    <a href="balance.jsp"><label class="form-label py-2">Check Balance</label></a>
                </li>
                <li class="nav-item">
                    <a href="transfer.jsp"><label class="form-label py-2">Transfer Money</label></a>
                </li>
            </ul>
        </div>
        <div class="right" id="right">
        	<jsp:include page="register.jsp?header=Modify Details&operation=Save Details&action=modify&fname=${firstName}&lname=${lastName}&email=${email}&dob=${dob}&phone=${phone}&nominee=${nominee}&password=${password}"></jsp:include>        	
        </div>
    </div>
	<%--<jsp:include page="register.jsp?header=Modify Details&operation=Save Details&action=modify&fname=${firstName}&lname=${lastName}&email=${email}&dob=${dob}&phone=${phone}&nominee=${nominee}&password=${password}"></jsp:include>--%>
	<script>
	// This is for perform onclick on a dynamic page
	$('body').on('click', '#modify-btn', function(event){
		event.preventDefault();
    	let fname = document.getElementById("fname").value;
    	let lname = document.getElementById("lname").value;
        let email = document.getElementById("email").value;
        let dob = document.getElementById("dob").value;
        let phone = document.getElementById("phone").value;
        let nominee = document.getElementById("nominee").value;
        let password = document.getElementById("password").value;
        let re_password = document.getElementById("re-password").value;
        let error = document.getElementById("error");
     
        let params = "fname="+fname+"&lname="+lname+"&dob="+dob+"&email="+email+"&phone="+phone+"&nominee="+nominee+"&password="+password+"&re-password="+re_password;
        $.ajax({
    		url: "modify",
    		data: params,
    		type: 'post',
    		success: function(data, textStatus, jqXHR){
    			if(data.trim() == "empty"){
    				error.innerHTML = "Please Fill All The Fields";
    				$("#error").css('color','red');
    				$("#error").css('display','block');
    				$("#error").css('text-align','center');
    			}
    			if(data.trim() == "mismatch"){
    				error.innerHTML = "Password Mismatch";
    				$("#error").css('color','red');
    				$("#error").css('display','block');
    				$("#error").css('text-align','center');
    			}
    			if(data.trim() == "success"){
    				window.location.href = "login.html?success=User Updated Successfully Please Login Again";
    			}
    			if(data.trim() == "error"){
    				error.innerHTML = "Some error occured try again";
    				$("#error").css('color','red');
    				$("#error").css('display','block');
    				$("#error").css('text-align','center');
    			}
    		}
    	})
	})
	<%--
		// loadContent Function called below
		function loadContent(link) {
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					document.getElementById("right").innerHTML = this.responseText;
				}
			};
			console.log(link);
			xhttp.open("GET", link, true);
			xhttp.send();
		}
		
		$(".nav-item").on('click', function(){
			$(".active").removeClass("active");
            $(this).addClass("active");
            
            let tag1 = document.querySelector('.active .hb').value;
            if(tag1 == 1){
            	loadContent("details.jsp");
            }
            if(tag1 == 2){
            	loadContent("register.jsp?header=Modify Details&operation=Save"+
            			"Details&action=modify&fname=${firstName}&lname=${lastName}&email=${email}"+
            			"&dob=${dob}&phone=${phone}&nominee=${nominee}&password=${password}");
            }
            if(tag1 == 3){
            }
		})--%>
	</script>
	
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
