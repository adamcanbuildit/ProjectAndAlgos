<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<title>My Pokemon</title>
</head>
<body class="bg-secondary">
	<div id="header" class="opacity-4 pt-4 bg-danger bg-gradient text-black fw-bold">
		<h1 class="display-2 text-center mb-4">My <span class="fw-bold">Pokemon</span></h1>
		<div id="navbar" class="opacity-50 ps-5 pb-1 d-flex bg-light flex-row rounded-bottom">
			<a href="/show/mypokedex/${user.id}" class="ms-2 me-2">MyPokedex</a> |
			<a href="/show/mypokemon/${user.id}" class="ms-2 me-2">View My Pokemon</a> |
			<a href="/findpokemon" class="ms-2 me-2">Find a New Pokemon</a> |
			<a href="/show/users" class="ms-2 me-2 flex-grow-1">View Other Pokedexes</a>
			<a href="/logout" class="ms-2 pe-5 me-5">Logout</a>
		</div>
	</div>
	
	
	
	<div id="body" class="d-flex flex-column p-5">
		<c:forEach var="pokemon" items="${pokemonlist}">
			<div class="row mb-4 p-4 bg-white rounded border border-dark border-3">
				<!-- display pokemon image -->
				<div class="col-md-2">
					<img class="img-thumbnail position-relative top-50 start-50 translate-middle" 
					width="150" height="150" src="${pokemon.pictureUrl}" alt="" />
				</div>
				<!-- display pokemon name -->
				<div class="col-md-2 d-flex align-content-center flex-wrap">
					<a class="fs-2 fw-bold" href="/rename/${pokemon.id}"><c:out value="${pokemon.name}" /></a>
				</div>
				<!-- display pokemon species & types -->
				<div class="col-md-3 d-flex flex-column pt-3 mb-2">
					<h3 class="mt-3 mb-4 text-uppercase fs-4 fw-bold fst-italic d-flex flex-row justify-content-evenly flex-wrap"><c:out value="${pokemon.species}" /></h3>
					<div class="d-flex flex-row justify-content-evenly flex-wrap">
						<c:forEach var="type" items="${pokemon.types}">
							<p class="fst-italic text-uppercase"><c:out value="${type}" /></p>
						</c:forEach>
					</div>
				</div>
				<!-- display pokemon stats -->
				<div class="col-md-3 fw-bold d-flex flex-column pt-3">
					<div class="d-flex flex-row justify-content-evenly">
						<p><c:out value="HP - ${pokemon.hp}" /></p>
						<p><c:out value="SPD - ${pokemon.spd}" /></p>
					</div>
					<div class="d-flex flex-row justify-content-evenly">
						<p><c:out value="ATK - ${pokemon.atk}" /></p>
						<p><c:out value="DEF - ${pokemon.def}" /></p>
					</div>
					<div class="d-flex flex-row justify-content-evenly">
						<p><c:out value="SP. ATK - ${pokemon.spAtk}" /></p>
						<p><c:out value="SP. DEF - ${pokemon.spDef}" /></p>
					</div>
				</div>
				<!-- display pokemon links (Release & Edit) -->
				<div class="col-md-2 d-flex flex-column justify-content-evenly flex-wrap">
					<form action="/release/${pokemon.id}" method="post">
						<input type="hidden" name="_method" value="delete">
						<input type="submit" class="btn btn-danger" value="Release Pokemon">
					</form>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>