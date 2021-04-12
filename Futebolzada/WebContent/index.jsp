<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Futebolas</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<h3 class="text-center text-success">Futebolzada Rapaziada</h3>
				<form action="GeraGrupos" method="post">
					<button type="submit" class="btn btn-success btn-block btn-lg">
						Gerar Grupos</button>
				</form>
				<form action="GeraJogos" method="post">
					<button type="submit"
						class="btn btn-block active btn-lg btn-outline-primary my-3">
						Gerar Jogos</button>
				</form>
				<form action="MostrarGrupos" method="post">
					<button type="submit" class="btn btn-block btn-lg btn-warning">
						Mostrar Grupos</button>
				</form>
				<form action="PesquisarData" method="post">
					<div>
						<label class="text-white">PESQUISAR POR DATA</label>
					</div>
					<div>
						<input type="date" name="data" id="data" placeholder="data">
					</div>
					<div>
						<input type="submit" value="Pesquisar Data">
					</div>
				</form>
				<c:forEach var="grupos" items="${lista}">
					<tr class="table-active">
						<td>// ${grupos.getNomeTimeA()} vs ${grupos.getNomeTimeB()} </td>						
					</tr>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>