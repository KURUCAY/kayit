<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
	integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<html>
<head>

<script>
	$(document).ready(function() {
		$('#kayitEkle').click(function() {
			var adi = $('#adi').val();
			var soyadi = $('#soyadi').val();
			var mail = $('#mail').val();
			var sifre = $('#sifre').val();
			$.ajax({

				url : '<s:url value="/kayitekle"></s:url>',
				type : 'post',
				data : {
					'adi' : adi,
					'soyadi' : soyadi,
					'mail' : mail,
					'sifre' : sifre
				},
				success : function(row) {

					if (row == "") {
						alert("islem basarisiz oldu");
					} else {
						
						$('#kayit').append(row);

					}

				}

			});

		});

	});
</script>



<title>Home</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


</head>
<body>

	<div class="row container-fluid">
		<div class="col-sm-4 ">


			<form>
				<div class="form-group">
					<label for="adi">Adınız</label> <input name="adi" type="text"
						class="form-control" id="adi" placeholder="Adınız">
				</div>
				<div class="form-group">
					<label for="soyadi">Soyadınız</label> <input name="soyadi"
						type="text" class="form-control" id="soyadi"
						placeholder="Soyadınız">
				</div>
				<div class="form-group">
					<label for="mail">Mail Adresi</label> <input name="mail"
						type="email" class="form-control" id="mail"
						aria-describedby="emailHelp" placeholder="Mail Giriniz">
				</div>
				<div class="form-group">
					<label for="sifre">Password</label> <input name="sifre"
						type="password" class="form-control" id="sifre"
						placeholder="Şifre">
				</div>

				<button type="submit" class="btn btn-primary" id="kayitEkle">Kayıt</button>
			</form>

		</div>
		<div class="col-sm-8">

			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">adi</th>
						<th scope="col">soyadi</th>
						<th scope="col">mail</th>
					</tr>
				</thead>

				<tbody id="kayit">
					<c:if test="${not empty kullaniciLs }">
						<c:forEach var="item" items="${kullaniciLs}">
							<tr>

								<td>${item.getAdi()}</td>
								<td>${item.getSoyadi()}</td>
								<td>${item.getMail()}</td>
							</tr>

						</c:forEach>
					</c:if>
				</tbody>
			</table>


		</div>
	</div>
</body>
</html>
