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
    <link rel="stylesheet" href="assets/css/register.css" />
  </head>
  <body>
    <div class="container1 mt-2">
      <img src="assets/images/bank/axis logo.jpg" alt="loading..." />
      <div class="frm_container mt-1">
      <!--action="${param.action}"--> 
        <form action="${param.action}" method="post">
          <div class="need_center">
            <h4>${param.header}</h4>
            <span style="color:red;" id="error">${requestScope.errorMsg}</span>
            <span style="color:green;">${param.success}</span>
          </div>
          <div class="frm_data">
            <div class="frm_left">
              <label for="fname" class="form-label">First Name</label>
              <input type="text" class="form-control bg-transparent" name="fname" id="fname" value="${param.fname}" />
              <label for="email" class="form-label">Email</label>
              <input
                type="email"
                class="form-control bg-transparent"
                name="email"
                id="email"
                value="${param.email}"
              />
              <label for="phone" class="form-label">Phone Number</label>
              <input type="text" class="form-control bg-transparent" name="phone" id="phone" value="${param.phone}" />
              <label for="password" class="form-label">Password</label>
              <input
                type="password"
                class="form-control bg-transparent"
                name="password"
                id="password"
                value="${param.password}"
              />
            </div>
            <div class="frm_right">
              <label for="lname" class="form-label">Last Name</label>
              <input type="text" class="form-control bg-transparent" name="lname" id="lname" value="${param.lname}" />
              <label for="dob" class="form-label">Date of Birth</label>
              <input type="date" class="form-control bg-transparent" name="dob" id="dob" value="${param.dob}" />
              <label for="nominee" class="form-label">Nominee Name</label>
              <input
                type="text"
                class="form-control bg-transparent"
                name="nominee"
                id="nominee"
                value="${param.nominee}"
              />
              <label for="re-password" class="form-label">Re-enter Password</label>
              <input
                type="password"
                class="form-control bg-transparent"
                name="re-password"
                id="re-password"
              />
            </div>
          </div>
          <div class="need_center">
            <button class="btn btn-info my-3" id="modify-btn">${param.operation}</button>
          </div>
          <div class="need_center">
            <p>Already have Account? <a href="login.html" ><span style="color: blue">Login</span></a></p>
          </div>
        </form>
      </div>
    </div>

	<script>
		$('#modify-btn').on('click', function(event){
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
	</script>

    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>
  </body>
</html>