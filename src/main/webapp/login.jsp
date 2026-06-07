<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <jsp:include page="base-head.jsp" />
    <title>Login - CRUD Manager</title>
</head>
<body style="padding-top: 50px;">
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title text-center">Entrar no Sistema</h3>
                    </div>
                    <div class="panel-body">
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                        <% } %>
                        <form action="${pageContext.request.contextPath}/login" method="POST">
                            <div class="form-group">
                                <label for="email">E-mail do Usuário:</label>
                                <input type="email" class="form-control" name="email" required autofocus placeholder="Digite o seu e-mail">
                            </div>
                            <div class="form-group">
                                <label for="senha">Senha:</label>
                                <input type="password" class="form-control" name="senha" required placeholder="Digite a sua senha">
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">Acessar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>