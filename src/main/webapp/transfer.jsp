<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Balance Transfer</title>
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
    	.balance_container{
    		width: 25rem;
    	}
    	.container3{
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
  	<%
	  	HttpSession hs = request.getSession();		
		int accNumber = (int)hs.getAttribute("accNumber");
  	%>
  	<jsp:include page="header.html"/>
  	<div class="container3">
	  	<div class = left>
	  		<jsp:include page="side_nav.jsp"/>
	  	</div>
	  	<div class = right>
		  	<div class="balance_container p-4">
			  	<label>Transfer Money</label><br>
				<span id="error"></span><br>
				<label for="acc-input" class="form-label">Payee Account No</label><br>
				<div style="display:flex;">
				<label style="color:white;">003941080226</label><input type="text" id="acc-input" placeholder="Enter last 5 digits" class="form-control mx-2"/>
				</div>
				<label for="amount-input" class="form-label">Amount</label><br>
				<input type="text" id="amount-input" placeholder="Amount" class="form-control"/>
				<input type="button" id="transfer" class="btn btn-danger my-3" value="Transfer">
				<input type="hidden" id="accNumber" value="${accNumber}">
			</div>
		</div>
	</div>
	<script>		
		$("#transfer").on('click', function(){
			let payee = document.getElementById("acc-input").value;
			let accNumber = document.getElementById("accNumber").value;
			let amount = document.getElementById("amount-input").value;
			let params = "amount="+amount+"&accNumber="+accNumber+"&payee="+payee;
			console.log(params);
			$.ajax({
	    		url: "transfer",
	    		data: params,
	    		type: 'post',
	    		success: function(data, textStatus, jqXHR){
	    			if(data.trim() == "insufficient"){
	    				error.innerHTML = "Insufficient Balance";
	    				$("#error").css('color','red');
	    				$("#error").css('display','block');
	    				$("#error").css('text-align','center');
	    			}
	    			if(data.trim() == "success"){
	    				error.innerHTML = "Transaction Successful";
	    				$("#error").css('color','green');
	    				$("#error").css('display','block');
	    				$("#error").css('text-align','center');
	    				
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
