*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net/api/v1/books
Resource         ResourceAPI.robot
Suite Setup      Conectar API

*** Test Case ***
Buscar listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir Status Code    200
    Conferir reason         OK
    Conferir se retorna uma lista com 200 livros

Buscar listagem de livro especifico
    Requisitar livro especifico
    Conferir Status Code    200
    Conferir reason         OK
    Conferir se retorna todos os dados corretos do livro 15

POST
    Cadastrar um novo livro
    Conferir Status Code    200
    Conferir reason         OK
    Conferir se cadastrou as informações do livro "2323" de forma correta

PUT
    Alterar um livro
    Conferir Status Code    200
    Conferir reason         OK
    Conferir se retorna todos os dados alterados do livro "10"

DELETE
    Deletar um livro
    Conferir Status Code    200
    Conferir reason         OK
    Conferir se deleta o livro "150" (response body vazio)