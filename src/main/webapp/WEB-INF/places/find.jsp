<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Events Core Assignment</title>
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
	          	<c:choose>
	          		<c:when test="${log != null}">
	          			<li class="nav-item">
	              			<a href="/logout" class="nav-link">Logout</a>
	            		</li>
	          		</c:when>
	          		<c:otherwise>
			            <li class="nav-item">
			              <a href="/guest/signin" class="nav-link">Login</a>
			            </li>	          		       		
	          		</c:otherwise>
	            </c:choose>
	          </ul>
	        </div>
        </nav>

        <section class="my-3 py-4"></section>

<section class="py-2">
	<div class="container">
		<div class="col-lg-6 offset-lg-3">
		<h1 class="text-center">Find places to swim and sleep on WaterBnB </h1>
		<form action="/search" method="get">
			<div class="row">
				<input class="col" type="text" name="location">
				<input class="col-2 btn btn-primary" type="submit" value="Search">
			</div>
		</form>
		
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