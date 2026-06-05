<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="base-head.jsp" />
    <title>Gerenciador de Estudos</title>
</head>
<body>
    <jsp:include page="nav-menu.jsp" />
    <div class="container">
        <h2>Sessões de Estudo</h2>
        <a href="${pageContext.request.contextPath}/study-tasks?action=new" class="btn btn-primary">Nova Sessão</a>
        <br><br>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Usuário</th>
                    <th>Assunto</th>
                    <th>Data</th>
                    <th>Status</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="task" items="${tasks}">
                    <tr>
                        <td>${task.id}</td>
                        <td>${task.user.name}</td>
                        <td>${task.subject}</td>
                        <td><fmt:formatDate pattern="dd/MM/yyyy" value="${task.studyDate}" /></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/study-tasks" method="POST" style="margin:0;">
                                <input type="hidden" name="id" value="${task.id}">
                                <input type="hidden" name="subject" value="${task.subject}">
                                <input type="hidden" name="studyDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${task.studyDate}" />">
                                <input type="hidden" name="userId" value="${task.user.id}">
                                <input type="hidden" name="notes" value="${task.notes}">
                                
                                <select name="status" class="form-control input-sm" onchange="this.form.submit()" style="width: 140px; display: inline-block;">
                                    <option value="Pendente" ${task.status == 'Pendente' ? 'selected' : ''}>Pendente</option>
                                    <option value="Em Andamento" ${task.status == 'Em Andamento' ? 'selected' : ''}>Em Andamento</option>
                                    <option value="Concluído" ${task.status == 'Concluído' ? 'selected' : ''}>Concluído</option>
                                </select>
                            </form>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/study-tasks?action=edit&id=${task.id}" class="btn btn-warning btn-sm">Editar</a>
                            <a href="${pageContext.request.contextPath}/study-tasks?action=delete&id=${task.id}" class="btn btn-danger btn-sm" onclick="return confirm('Excluir esta sessão?')">Excluir</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>