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
	          	<c:choose>
	          		<c:when test="${log == true}">
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

<section class="p-5 bg-primary">
      <div class="container">
        <div class="row g-4">
          <div class="col-md-6">
            <div class="card bg-light">
            	<h2 class="text-center"><c:out value="${place.getAddress()}" /></h2>
              <div class="card-body text-center">
                <p class="card-text">
                  <c:out value="${place.getDescription()}" />
                </p>
              </div>
            </div>
          </div>

          <div class="col-md-6">
            <div class="card bg-light">
              <div class="card-body text-center">
					<p><span class="fs-5">Email:</span> <c:out value="${place.getHost().getEmail()}" /></p>
					<p><span class="fs-5">Name:</span><c:out value="${place.getHost().getFirstName()} ${place.getHost().getLastName()}" /></p>
					<p><span class="fs-5">Pool Size:</span><c:out value="${place.getPoolSize()}" /></p>
					<p><span class="fs-5">Cost:</span><c:out value="${place.getCost()}" /></p>
              </div>
            </div>
          </div>    
        </div>
      </div>
    </section>
     <section>
         <div class="container">
         	
             <div class="col">
             		<h2>Reviews 
             		<c:choose>
						<c:when test="${place.getReviews().size() >0 }">
									(<c:out value="${place.getRating()}" /> /<c:out value="${place.getReviews().size()}" />)
						</c:when>
						<c:otherwise>
							<c:out value="(No reviews yet)"/>
						</c:otherwise>
					</c:choose>
					</h2>
					<a href="/place/${place.getId()}/review" class="btn btn-primary">Add Review</a>
                     <div class="my-3">
                     	<c:forEach items="${place.getReviews()}" var="review">
                     		<div class="border border-dark">
                      		<p><c:out value="${review.getSender().getFirstName()} ${review.getSender().getLastName()}" /></p>
                      		<p>Rating: <c:out value="${review.getRating()}/5" /></p>                        	
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