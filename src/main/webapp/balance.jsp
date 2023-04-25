<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Balance</title>
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
			  	<label for="balance">Current Balance:</label>
				<span id="balance"></span><br>
				<span id="msg"></span><br>
				<label for="deposit-input" class="form-label mt-4">Deposit</label><br>
				<div style="display: flex">
					<input type="text" id="deposit-input" class="form-control"/>
					<input type="button" id="deposit" class="btn btn-primary mx-2" value="Deposit"><br>
				</div>
				<label for="withdraw-input" class="form-label">Withdraw</label><br>
				<div style="display:flex">
					<input type="text" id="withdraw-input" class="form-control"/>
					<input type="button" id="withdraw" class="btn btn-danger mx-2" value="Withdraw">
					<input type="hidden" id="accNumber" value="${accNumber}">
				</div>
			</div>
		</div>
	</div>
	<script>
		initialize();
		function initialize(){
			let balance = document.getElementById("balance");
			let accNumber = document.getElementById("accNumber").value;
			let params = "amount=0&accNumber="+accNumber+"&operation=plus";
			console.log(params);
			$.ajax({
	    		url: "updateBalance",
	    		data: params,
	    		type: 'post',
	    		success: function(data, textStatus, jqXHR){
	    			
	    			if(data.trim() == "-1"){
	    				console.log("Some error occured");
	    			}
	    			balance.innerHTML = data.trim();
	    		}
	    	})
		}
		
		$("#deposit").on('click', function(){
			let balance = document.getElementById("balance");
			let amount = parseInt(document.getElementById("deposit-input").value);
			let accNumber = document.getElementById("accNumber").value;
			let params = "amount="+amount+"&accNumber="+accNumber+"&operation=plus";
			let msg = document.getElementById("msg");
			$.ajax({
	    		url: "updateBalance",
	    		data: params,
	    		type: 'post',
	    		success: function(data, textStatus, jqXHR){
	    			if(data.trim() == "error"){
	    				console.log("Some error occured");
	    			}else{
	    				balance.innerHTML = data.trim();
	    				msg.innerHTML = "Deposit of amount "+amount+" is Successful";
	    				$("#msg").css('color','green');
	    				$("#msg").css('display','block');
	    				$("#msg").css('text-align','center');
	    			}
	    		}
	    	})
		})
		
		$("#withdraw").on('click', function(){
			let balance = document.getElementById("balance");
			let amount = parseInt(document.getElementById("withdraw-input").value);
			let accNumber = document.getElementById("accNumber").value;
			let params = "amount="+amount+"&accNumber="+accNumber+"&operation=minus";
			console.log(params);
			$.ajax({
	    		url: "updateBalance",
	    		data: params,
	    		type: 'post',
	    		success: function(data, textStatus, jqXHR){
	    			if(data.trim() == "insufficient"){
	    				msg.innerHTML = "Insufficient Fund";
	    				$("#msg").css('color','red');
	    				$("#msg").css('display','block');
	    				$("#msg").css('text-align','center');
	    			}else if(data.trim() == "-1"){
	    				console.log("Some error occured");
	    			}else{
	    				balance.innerHTML = data.trim();
	    				msg.innerHTML = "Withdraw of amount "+amount+" is Successful";
	    				$("#msg").css('color','yellow');
	    				$("#msg").css('display','block');
	    				$("#msg").css('text-align','center');
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
