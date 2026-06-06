<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@include file="base-head.jsp"%>
    <title>Gerenciador de Estudos</title>
</head>

<body>

    <%@include file="nav-menu.jsp"%>

    <div id="container" class="container-fluid">

        <div id="top" class="row">
            <div class="col-md-3">
                <h3>Atividades</h3>
            </div>

            <div class="col-md-6">
                <div class="input-group h2">
                    <input class="form-control" id="search" type="text"
                           placeholder="Pesquisar atividades">
                    <span class="input-group-btn">
                        <button class="btn btn-danger" type="button">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                    </span>
                </div>
            </div>

            <div class="col-md-3">
                <a href="${pageContext.request.contextPath}/study-tasks?action=new"
                   class="btn btn-danger pull-right h2">
                    <span class="glyphicon glyphicon-plus"></span>
                    &nbsp;Nova atividade
                </a>
            </div>
        </div>

        <hr />

        <div id="list" class="row">
            <div class="table-responsive col-md-12">
                <table class="table table-striped table-hover"
                       cellspacing="0" cellpadding="0">

                    <thead>
                        <tr>
                            <th>Usuário</th>
                            <th>Professor</th>
                            <th>Assunto</th>
                            <th>Observações</th>
                            <th>Data</th>
                            <th>Status</th>
                            <th>Editar</th>
                            <th>Excluir</th>
                            
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="task" items="${tasks}">
                            <tr>

                                <td>${task.user.name}</td>

                                <td>${task.professor}</td>

                                <td>${task.subject}</td>
                                
                                <td>${task.notes}</td>

                                <td>
                                    <fmt:formatDate pattern="dd/MM/yyyy"
                                                    value="${task.studyDate}" />
                                </td>

                                <td>
                                    <form action="${pageContext.request.contextPath}/study-tasks"
                                          method="POST" style="margin:0;">

                                        <input type="hidden" name="id"
                                               value="${task.id}">

                                        <input type="hidden" name="subject"
                                               value="${task.subject}">

                                        <input type="hidden" name="professor"
                                               value="${task.professor}">

                                        <input type="hidden" name="studyDate"
                                               value="<fmt:formatDate pattern='yyyy-MM-dd' value='${task.studyDate}' />">

                                        <input type="hidden" name="userId"
                                               value="${task.user.id}">

                                        <input type="hidden" name="notes"
                                               value="${task.notes}">

                                        <select name="status"
									        class="form-control input-sm"
									        onchange="this.form.submit()"
									        style="width: 140px;">
									
									    <option value="Pendente"
									        ${task.status == 'Pendente' ? 'selected' : ''}>
									        Pendente
									    </option>
									
									    <option value="Em Andamento"
									        ${task.status == 'Em Andamento' ? 'selected' : ''}>
									        Em Andamento
									    </option>
									
									    <option value="Concluído"
									        ${task.status == 'Concluído' ? 'selected' : ''}>
									        Concluído
									    </option>
									    
									    <option value="Prazo perdido"
									        ${task.status == 'Prazo perdido' ? 'selected' : ''}>
									        Prazo perdido
									    </option>
									
									</select>

                                    </form>
                                </td>

                                <td class="actions">
                                    <a class="btn btn-info btn-xs"
                                       href="${pageContext.request.contextPath}/study-tasks?action=edit&id=${task.id}">
                                        <span class="glyphicon glyphicon-edit"></span>
                                    </a>
                                </td>

                                <td class="actions">
                                    <a class="btn btn-danger btn-xs"
                                       href="${pageContext.request.contextPath}/study-tasks?action=delete&id=${task.id}"
                                       onclick="return confirm('Excluir esta sessão?')">
                                        <span class="glyphicon glyphicon-trash"></span>
                                    </a>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>

                </table>
            </div>
        </div>

        <div id="bottom" class="row">
            <div class="col-md-12">
                <ul class="pagination">
                    <li class="disabled"><a>&lt; Anterior</a></li>
                    <li class="disabled"><a>1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li class="next"><a href="#">Próximo &gt;</a></li>
                </ul>
            </div>
        </div>

    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
   <script>
$(document).ready(function() {
    
    // 1. LÓGICA DE PESQUISA (Já existente)
    $("#search").on("keyup", function() {
        var value = $(this).val().toLowerCase();

        $("tbody tr").filter(function() {
            $(this).toggle(
                $(this).text().toLowerCase().indexOf(value) > -1
            );
        });
    });

    // 2. LÓGICA DE ORDENAÇÃO
    $('th').click(function() {
        var table = $(this).parents('table').eq(0);
        var tbody = table.find('tbody');
        var rows = tbody.find('tr').toArray();
        var columnIndex = $(this).index();
        
        // Impede a ordenação nas colunas de "Editar" e "Excluir" (índices 6 e 7)
        if (columnIndex === 6 || columnIndex === 7) return;

        // Alterna entre ordem crescente e decrescente
        this.asc = !this.asc;
        var isAscending = this.asc;

        rows.sort(function(a, b) {
            var valA = getCellValue(a, columnIndex);
            var valB = getCellValue(b, columnIndex);

            // Verifica se o valor é uma data no formato dd/MM/yyyy
            var dateRegex = /^(\d{2})\/(\d{2})\/(\d{4})$/;
            if (dateRegex.test(valA) && dateRegex.test(valB)) {
                var dateA = parseDate(valA);
                var dateB = parseDate(valB);
                return isAscending ? dateA - dateB : dateB - dateA;
            }

            // Ordenação alfabética padrão para o restante
            if (valA < valB) return isAscending ? -1 : 1;
            if (valA > valB) return isAscending ? 1 : -1;
            return 0;
        });

        // Atualiza a tabela com as linhas ordenadas
        $.each(rows, function(index, row) {
            tbody.append(row);
        });
    });

    // Função auxiliar para extrair o texto correto da célula
    function getCellValue(row, index) {
        var cell = $(row).children('td').eq(index);
        
        // Se a célula tiver um <select> (como na coluna de Status), pega o valor selecionado
        var select = cell.find('select');
        if (select.length > 0) {
            return select.val().toLowerCase();
        }
        
        // Caso contrário, pega o texto normal
        return cell.text().trim().toLowerCase();
    }

    // Função auxiliar para converter dd/MM/yyyy em um objeto Date do Javascript
    function parseDate(dateString) {
        var parts = dateString.split('/');
        // parts[0] = dia, parts[1] = mês (0-11 no JS), parts[2] = ano
        return new Date(parts[2], parts[1] - 1, parts[0]).getTime();
    }

});
</script>

</body>
</html>