# CRUD Manager 

Sistema web desenvolvido em Java para gerenciamento de estudos, permitindo cadastrar, consultar, editar e excluir tarefas de estudo de forma prática e organizada.

## Funcionalidades

- Cadastro de usuários
- Login e autenticação
- Cadastro de tarefas de estudo
- Edição de tarefas
- Exclusão de tarefas
- Listagem de tarefas
- Pesquisa de tarefas
- Controle de status das atividades
- Registro de observações e anotações
- Associação das tarefas aos usuários

## Tecnologias Utilizadas

- Java
- JSP
- Servlets
- JSTL
- HTML5
- CSS3
- Bootstrap
- MySQL
- JDBC
- Apache Tomcat

## Estrutura do Projeto

```
src/
├── controller/
├── model/
│   ├── dao/
│   └── entities/
├── util/
WebContent/
├── css/
├── js/
├── views/
└── WEB-INF/
```

## Configuração do Banco de Dados

1. Crie um banco de dados MySQL.

```sql
CREATE DATABASE crudmanager3;
```

2. Configure as credenciais de acesso ao banco no projeto.

3. Execute os scripts SQL necessários para criação das tabelas.

Exemplo da tabela de tarefas:

```sql
CREATE TABLE study_tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(150) NOT NULL,
    study_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    notes TEXT,
    professor VARCHAR(150),
    user_id INT NOT NULL
);
```

## Como Executar

1. Clone o repositório:

```bash
git clone https://github.com/Lauraevelyn2004/crudmanager3.git
```

2. Importe o projeto no Eclipse.

3. Configure o Apache Tomcat.

4. Configure o banco de dados MySQL.

5. Execute o projeto através do servidor.

6. Acesse:

```
http://localhost:8080/crudmanager3
```

## Funcionalidades Principais

### Gerenciamento de Tarefas

- Criar tarefas de estudo
- Editar informações
- Excluir registros
- Consultar tarefas cadastradas

### Controle de Estudos

- Organização por disciplina
- Registro de professor responsável
- Controle de status
- Observações personalizadas

## Objetivo do Projeto

O sistema foi desenvolvido com fins acadêmicos para praticar conceitos de:

- Programação Orientada a Objetos
- Arquitetura MVC
- Padrão DAO
- Desenvolvimento Web com Java
- Integração com Banco de Dados
- CRUD completo

## Desenvolvedora

**Laura Evelyn Oliveira**

Estudante de Sistemas de Informação - IFSULDEMINAS Campus Machado

GitHub: https://github.com/Lauraevelyn2004

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais.
