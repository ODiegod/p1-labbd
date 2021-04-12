<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Grupos</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body class="pattern">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4">

				<table class="table">
					<thead>
						<tr>
							<th class="table-danger text-center">Grupo A</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="grupos" items="${listaGrupos_A}">
							<tr class="table-active">
								<td>${grupos.getNomeTime()}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-md-4">
				<table class="table">

					<thead>
						<tr>
							<th class="table-danger text-center">Grupo B</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="grupos" items="${listaGrupos_B}">
							<tr class="table-active">
								<td>${grupos.getNomeTime()}</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
		</div>
					<div class="row">
			<div class="col-md-4">
		<table class="table">
			<thead>
				<tr>
					<th class="table-danger text-center">Grupo C</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="grupos" items="${listaGrupos_C}">
					<tr class="table-active">
						<td>${grupos.getNomeTime()}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
			<div class="col-md-4">
		<table class="table">
			<thead>
				<tr>
					<th class="table-danger text-center">Grupo D</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="grupos" items="${listaGrupos_D}">
					<tr class="table-active">
						<td>${grupos.getNomeTime()}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</div>
	</div>
</body>
</html>