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

<section class="p-5 bg-secondary">
      <div class="container text-white">
    
        	<form method="POST" action="/updatePlace" class="row">
          <div class="col-lg-6">
            	
            	<input name = "id" type="hidden" value="${place.getId()}"/>
            	<input name="address" value="${place.getAddress()}" style="width:100%"/>
             
                <p class="card-text">
                	<textarea name="description" style="width:100%">
                	<c:out value="${place.getDescription()}" />
                	</textarea>
                </p>

          </div>

          <div class="col-lg-6">
            
					<p><span class="fs-5">Email:</span> <c:out value="${place.getHost().getEmail()}" /></p>
					<p><span class="fs-5">Name:</span><c:out value="${place.getHost().getFirstName()} ${place.getHost().getLastName()}" /></p>
					<p><span class="fs-5">Pool Size:</span>
					<select name="poolSize">
						
					<option value="place.getPoolSize()" selected><c:out value="${place.getPoolSize()}" /></option>
					<c:forEach items="${poolSizes}" var="Size">
						<c:choose>
						<c:when test="${Size != place.getPoolSize()}">
									<option value="${Size}" label="${Size}"></option>
						</c:when>
						</c:choose>
					</c:forEach>
					</select>
					</p>
					<p><span class="fs-5">Cost: </span><input type="number" name="cost" value="${place.getCost()}" /></p>
			<input class="btn btn-primary text-center" type="submit" value="Save Changes"/>
          </div> 
          </form>       
      </div>
    </section>
     <section>
         <div class="container">
         	
             <div class="col">
             		<h2>Reviews 
             			<c:choose>
						<c:when test="${place.getReviews().size() >0 }">
									(<c:out value="${place.getRating()} / ${place.getReviews().size()}"/>)
						</c:when>
						<c:otherwise>
							<c:out value="(No reviews yet)"/>
						</c:otherwise>
						</c:choose>
             			

             		</h2>
                     <div class="mb-3">
                     	<c:forEach items="${place.getReviews()}" var="review">
                     		<div class="border-dark">
                      		<p><c:out value="${review.getSender().getFirstName()} ${review.getSender().getLastName()}" /></p>
                      		<p>Rating:<c:out value="${review.getRating()}/5" /></p>                        	
                      		<p><c:out value="${review.getContent()}" /></p>
                     		</div>
                     	</c:forEach>
                     </div>

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