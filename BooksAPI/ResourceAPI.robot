*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net/api/v1/books
Library          RequestsLibrary
Library          Collections

*** Variables ***
${URL}           https://fakerestapi.azurewebsites.net/api/v1/
&{Livro1}        id=1    #não pode ter espaços em branco antes do value
...              title=Book 1         
...              pageCount=100

&{BOOK_2323}    id=2323
...             title=teste
...             description=teste
...             pageCount=1
...             excerpt=teste
...             publishDate=2018-04-26T17:58:14.765Z

# &{BOOK_150}     ID=150
# ...             Title=Book 150 alterado
# ...             Description=Descrição do book 150 alteada
# ...             PageCount=600
# ...             Excerpt=Resumo do book 150 alteado
# ...             PublishDate=2017-04-26T15:58:14.765Z


*** Keywords ***
Conectar API
    Create Session     fakeAPI    ${URL}




## GET de todos os livros
Requisitar todos os livros
    ${Resposta_API}    Get Request    fakeAPI     Books    #endpoint
    Log    ${Resposta_API.text}
    Set Test Variable    ${Resposta_API}

Conferir Status Code
    [Arguments]     ${STATUS_CODE}
    Should Be Equal As Strings    ${Resposta_API.status_code}    ${STATUS_CODE}

Conferir reason
    [Arguments]     ${REASON}
    Should Be Equal As Strings    ${Resposta_API.reason}    ${REASON}

Conferir se retorna uma lista com ${ITENS} livros
    Length Should Be    ${Resposta_API.json()}    ${ITENS}        
    





## GET Especifico
Requisitar livro especifico
    ${Resposta_API}    Get Request    fakeAPI     Books/1    #endpoint
    Log    ${Resposta_API.text}
    Set Test Variable    ${Resposta_API}

Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item     ${Resposta_API.json()}    id              ${Livro1.id}
    Dictionary Should Contain Item     ${Resposta_API.json()}    title           ${Livro1.title}
    Dictionary Should Contain Item     ${Resposta_API.json()}    pageCount       ${Livro1.pageCount}
              
    Should Not Be Empty                ${Resposta_API.json()["description"]}    
    Should Not Be Empty                ${Resposta_API.json()["excerpt"]}    
    Should Not Be Empty                ${Resposta_API.json()["publishDate"]}







#POST
Cadastrar um novo livro
    ${HEADERS}             Create Dictionary           content-type=application/json
    ${Resposta_API}        Post Request    fakeAPI     Books    #endpoint
    ...                                    data={"id": ${BOOK_2323.id}, "title": "${BOOK_2323.title}", "description": "${BOOK_2323.description}", "pageCount": "${BOOK_2323.pageCount}", "excerpt": "${BOOK_2323.excerpt}", "publishDate": "${BOOK_2323.publishDate}"}
    ...                                    headers=${HEADERS}
    Log                    ${Resposta_API.text}
    Set Test Variable      ${Resposta_API}

Conferir se cadastrou as informações do livro ${ID_LIVRO} de forma correta
    Dictionary Should Contain Item     ${Resposta_API.json()}    id              ${BOOK_2323.id}
    Dictionary Should Contain Item     ${Resposta_API.json()}    title           ${BOOK_2323.title}
    Dictionary Should Contain Item     ${Resposta_API.json()}    description     ${BOOK_2323.description}
    Dictionary Should Contain Item     ${Resposta_API.json()}    pageCount       ${BOOK_2323.pageCount}
    Dictionary Should Contain Item     ${Resposta_API.json()}    excerpt         ${BOOK_2323.excerpt}
    Dictionary Should Contain Item     ${Resposta_API.json()}    publishDate     ${BOOK_2323.publishDate}

    



#PUT
Alterar um livro
    ${HEADERS}         Create Dictionary           content-type=application/json
    ${Resposta_API}    Put Request    fakeAPI     Books/10
    ...                                    data={"id": 10, "title": "teste", "description": "teste", "pageCount": 44, "excerpt": "teste", "publishDate": "2022-01-31T14:28:34.986Z"}
    ...                                    headers=${HEADERS}
    Log                    ${Resposta_API.text}
    Set Test Variable      ${Resposta_API}


Conferir se retorna todos os dados alterados do livro ${ID_LIVRO}
    Dictionary Should Contain Item     ${Resposta_API.json()}    id              10
    Dictionary Should Contain Item     ${Resposta_API.json()}    title           teste
    Dictionary Should Contain Item     ${Resposta_API.json()}    description     teste
    Dictionary Should Contain Item     ${Resposta_API.json()}    pageCount       44
    Dictionary Should Contain Item     ${Resposta_API.json()}    excerpt         teste
    Dictionary Should Contain Item     ${Resposta_API.json()}    publishDate     2022-01-31T14:28:34.986Z




#DELETE
Deletar um livro
    ${Resposta_API}    Delete Request    fakeAPI     Books/150
    Set Test Variable    ${Resposta_API}

Conferir se deleta o livro ${ID_LIVRO} (response body vazio)
    Should Be Empty  ${Resposta_API.content}        