-- Criar o banco de dados
CREATE DATABASE biblioteca;
USE biblioteca;

-- Criar a tabela "Autores"
CREATE TABLE Autores (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome_autor VARCHAR(100) NOT NULL,
    pais_origem VARCHAR(50)
);

-- Criar a tabela "Livros"
CREATE TABLE Livros (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    ano_publicacao INT,
    id_autor INT,
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);

-- Criar a tabela de Log para registrar as mensagens do trigger
CREATE TABLE Log (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(100) NOT NULL,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criar o trigger que será acionado após a inserção de um novo livro
DELIMITER //
CREATE TRIGGER after_insert_livro
AFTER INSERT ON Livros
FOR EACH ROW
BEGIN
    DECLARE mensagem VARCHAR(100);
    SET mensagem = CONCAT('Livro "', NEW.titulo, '" inserido com sucesso.');
    INSERT INTO Log (mensagem) VALUES (mensagem);
END;
//
DELIMITER ;

-- Inserir um livro de exemplo
INSERT INTO Autores (nome_autor, pais_origem) VALUES ('Autor Exemplo', 'País Exemplo');
INSERT INTO Livros (titulo, ano_publicacao, id_autor) VALUES ('Livro Exemplo', 2023, 1);
