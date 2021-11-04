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
	            <li class="nav-item">
	              <a href="/logout" class="nav-link">Logout</a>
	            </li>
	          </ul>
	        </div>
        </nav>

        <section class="my-3 py-4"></section>

<section class="py-2">
	<div class="container">
		<h1 class="text-center">Welcome <c:out value="${user.firstName}!"/></h1>
		<p class="text-center" >Here are your current listings:</p>
		<div class="col-lg-6 offset-lg-3">
			<table class="table table-striped table-hover">
				<thead class="table-dark">
					<tr>
						<td>Address</td>
						<td>Pool Size</td>
						<td>Cost per Night</td>
						<td>Details</td>
					</tr>
				</thead>
				<tbody>					
						<c:forEach items="${user.getPlaces()}" var="place">
								<tr>
									<td><c:out value="${place.getAddress()}"/></td>
									<td><c:out value="${place.getPoolSize()}"/></td>
									<td><c:out value="${place.getCost()}"/></td>
									<td>
										<c:choose>
											<c:when test="${place.getRating() != 0.0}">
												<a href="/host/place/${place.getId()}"><c:out value="${place.getRating()} / ${place.getReviews().size()} - Edit"/></a>
											</c:when>
											<c:otherwise>
												<a href="/host/place/${place.getId()}">No ratings yet- Edit</a>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
						</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</section> 



<section class="py-2">
	<div class="container">
		<h3 class="text-center">New Listing</h3>
		<p class="text-center"><form:errors path="place.*"/></p>
		<div class="col-lg-6 offset-lg-3">
			<form:form method="POST" action="/addPlace" class="p-4 bg-secondary text-white" modelAttribute="place">
                            <div class="form-group mb-3">
                                <form:label path="address" class="mb-2" >Address:</form:label>
                                <form:input path="address" class="form-control"/>
                            </div>
                            
                            <div class="form-group mb-3">
                                <form:label path="description" class="mb-2">Description:</form:label>
                                <form:textarea path="description" class="form-control"/>
                            </div>
                            
                             <div class="form-group mb-3">
                                <form:label path="cost" class="mb-2">Cost per night:</form:label>
                                <form:input path="cost" class="form-control"/>
                            </div>
                            
                            <div class="form-group mb-3">
                                <form:label path="poolSize" class="mb-2">Pool Size:</form:label>
                       			<form:select path="poolSize" class="form-select">
                       				<c:forEach items="${poolSizes}" var="Size">
    									<form:option value="${Size}" label="${Size}"></form:option>
    								</c:forEach>
								</form:select>
                            </div>
                            
                             <div class="form-group mb-3">
								<input  class="btn btn-primary" type="submit" class="form-control" value="Add Listing"/>
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