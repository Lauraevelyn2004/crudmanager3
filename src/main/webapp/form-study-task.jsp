<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="base-head.jsp" />
    <title>Atividades</title>
</head>
<body>
    <jsp:include page="nav-menu.jsp" />
    <div class="container">
        <h2>${task.id == 0 ? 'Nova Sessão de Estudo' : 'Editar Sessão'}</h2>
        <form action="${pageContext.request.contextPath}/study-tasks" method="POST">
            <input type="hidden" name="id" value="${task.id}">
            
            <div class="form-group">
                <label>Assunto:</label>
                <input type="text" class="form-control" name="subject" value="${task.subject}" required>
            </div>
            
            <div class="form-group">
                <label>Professor:</label>
                <input type="text" class="form-control" name="professor" value="${task.professor}" placeholder="Ex: Maicon Sônego" required>
            </div>
            
            <div class="form-group">
                <label>Data do Estudo:</label>
                <fmt:formatDate value="${task.studyDate}" pattern="yyyy-MM-dd" var="formattedDate" />
                <input type="date" class="form-control" name="studyDate" value="${formattedDate}" required>
            </div>
            
            <div class="form-group">
                <label>Status:</label><br>
                <label class="radio-inline"><input type="radio" name="status" value="Pendente" ${task.status == 'Pendente' ? 'checked' : ''} required> Pendente</label>
                <label class="radio-inline"><input type="radio" name="status" value="Em Andamento" ${task.status == 'Em Andamento' ? 'checked' : ''}> Em Andamento</label>
                <label class="radio-inline"><input type="radio" name="status" value="Concluído" ${task.status == 'Concluído' ? 'checked' : ''}> Concluído</label>
            </div>
            
            <div class="form-group">
                <label>Aluno:</label>
                <select class="form-control" name="userId" required>
                    <option value="">Selecione o aluno...</option>
                    <c:forEach var="u" items="${users}">
                        <option value="${u.id}" ${u.id == task.user.id ? 'selected' : ''}>${u.name}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label>Anotações:</label>
                <textarea class="form-control" name="notes" rows="4">${task.notes}</textarea>
            </div>
            
            <button type="submit" class="btn btn-success">Salvar</button>
            <a href="${pageContext.request.contextPath}/study-tasks" class="btn btn-default">Cancelar</a>
        </form>
        
    </div>
</body>
</html>