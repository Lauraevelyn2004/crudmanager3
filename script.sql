
DROP DATABASE IF EXISTS crud_manager;

CREATE DATABASE IF NOT EXISTS crud_manager;

USE crud_manager;

CREATE TABLE IF NOT EXISTS users(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    sexo ENUM('M', 'F'),
    email VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS posts(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    post_date DATE NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) 
    REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS companies (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(128) NOT NULL,
	`role` VARCHAR(128) NOT NULL,
	`start` DATE NOT NULL,
	`end` DATE,
	user_id INT NOT NULL,
	FOREIGN KEY(user_id)
	REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS companies (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(128) NOT NULL,
`role` VARCHAR(128) NOT NULL,
`start` DATE NOT NULL,
`end` DATE,
user_id INT NOT NULL,
FOREIGN KEY(user_id)
REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS study_tasks (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(150) NOT NULL,
    study_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    notes TEXT,
    professor VARCHAR(150),
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO users VALUES
(DEFAULT, "Amanda Dias Alves Ferreira", "F", "Amanda@mail.com"),
(DEFAULT, "Joice de Araujo Alves", "F", "joice@mail.com"),
(DEFAULT, "Brian Gustavo Martins Silva", "M", "brian@mail.com"),
(DEFAULT, "Melissa Graciano Ferreira", "F", "melissa@mail.com"),
(DEFAULT, "Augusto Mezavila Caixeta Moreira", "F", "augusto@mail.com");

INSERT INTO posts VALUES
(DEFAULT, "Olá do Emerson", CURDATE(), 1),
(DEFAULT, "Olá da Luiza", CURDATE(), 2),
(DEFAULT, "Olá da Denise", CURDATE(), 3),
(DEFAULT, "Olá do Noé", CURDATE(), 4),
(DEFAULT, "Olá da Rosânia", CURDATE(), 5),
(DEFAULT, "Olá da Rosânia 1", CURDATE(), 5),
(DEFAULT, "Olá da Rosânia 2", CURDATE(), 5),
(DEFAULT, "Olá da Rosânia 3", CURDATE(), 5);

INSERT INTO study_tasks
(subject, study_date, status, notes, professor, user_id)
VALUES
("Programação Web", "2026-06-10", "Pendente", "Estudar JSTL e EL", "Carlos Silva", 1),
("Banco de Dados", "2026-06-11", "Concluído", "Praticar consultas SQL", "Maria Souza", 2),
("Engenharia de Software", "2026-06-12", "Em andamento", "Criar diagrama de classes", "João Pereira", 3),
("Redes de Computadores", "2026-06-13", "Pendente", "Revisar modelo TCP/IP", "Ana Lima", 4),
("Sistemas Operacionais", "2026-06-14", "Concluído", "Estudar escalonamento de processos", "Pedro Santos", 5),
("Estrutura de Dados", "2026-06-15", "Pendente", "Implementar árvore binária", "Ricardo Alves", 1),
("Desenvolvimento Mobile", "2026-06-16", "Em andamento", "Criar tela de login", "Camila Freitas", 2),
("Inteligência Artificial", "2026-06-17", "Pendente", "Estudar algoritmos de busca", "Fernanda Rocha", 3),
("Segurança da Informação", "2026-06-18", "Concluído", "Revisar conceitos de criptografia", "Juliana Costa", 4),
("Gestão de Projetos", "2026-06-19", "Pendente", "Pesquisar metodologia Scrum", "Lucas Ribeiro", 5);
