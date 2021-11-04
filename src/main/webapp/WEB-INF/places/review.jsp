<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>WaterBnB Practice Assignment</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />

    </head>
    <body>
        <nav class="navbar navbar-expand-lg bg-dark navbar-dark py-1 fixed-top">
            <div class="container">
              <a href="#" class="navbar-brand">WaterBnB Practice Assignment</a>
            </div>
            <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navmenu"
        >
	          <span class="navbar-toggler-icon"></span>
	        </button>
	
	        <div class="collapse navbar-collapse" id="navmenu">
	          <ul class="navbar-nav ms-auto">
	            <li class="nav-item">
	              <a href="/home" class="nav-link">Dashboard</a>
	            </li>
	          </ul>
	        </div>
        </nav>

        <section class="my-3 py-4"></section>


     <section>
         <div class="container">
         	
             <div class="col-lg-6 offset-lg-3">
             	<h2>Review of <c:out value="${place.getAddress()}" /></h2>
			        <form:form method="POST" action="/addReview" class="p-4 bg-secondary text-white" modelAttribute="review">
			        	<input type="hidden" name="placeId" value = "${place.getId()}">
						<div class="form-group mb-3">
			                <form:label path="content" class="fs-4 mb-2" >Content:</form:label>
			                <form:textarea path="content" class="form-control"/>
			            </div>
						<div class="form-group mb-3">
			                <form:label path="rating" class="fs-4 mb-2" >Rating</form:label>
               				<form:select path="rating" class="form-select">
								<form:option value="1" label="1"/>
								<form:option value="2" label="2"/>
								<form:option value="3" label="3"/>
								<form:option value="4" label="4"/>
								<form:option value="5" label="5"/>
							</form:select>
			                
			            </div>			
			            
			            <div class="form-group mt-5 px-5 mx-5">
			                <input type="submit" class="form-control" value="Submit Review">
			            </div>
			            
			        </form:form>

             </div>



         </div>

     </section>
        

        <section class="py-5 my-5"></section>
        <footer class="col-12 p-1 bg-dark text-white text-center position-fixed bottom-0">
            <div class="container">
              <p class="lead">Coding Dojo Web Dev Bootcamp</p>
            </div>
        </footer>
	<script src="/webjars/jquery/jquery.min.js"></script>
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>

