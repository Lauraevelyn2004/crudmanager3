<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@include file="base-head.jsp"%>
    <title>Início - Gerenciador de Estudos</title>
</head>

<body>
    <%@include file="nav-menu.jsp"%>

    <div id="container" class="container-fluid">
        
        <div class="jumbotron" style="margin-top: 20px; background-color: #f8f9fa;">
            <h1>Bem-vindo ao Gerenciador de Estudos!</h1>
            <p>Utilize este sistema para organizar suas sessões de estudo, acompanhar o andamento de cada matéria com seus respectivos professores e manter suas anotações sempre em dia.</p>
            <p>
                <a class="btn btn-danger btn-lg" href="${pageContext.request.contextPath}/study-tasks" role="button">
                    <span class="glyphicon glyphicon-book"></span> Acessar Atividades
                </a>
            </p>
        </div>

    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>