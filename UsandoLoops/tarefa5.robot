*** Settings ***
Documentation   Vamos aprender a fazer LOOPS usando o Robot Framework!!

*** Variables ***
### Indíce da lista        0  1  2  3  4  5
@{MINHA_LISTA}             1  2  4  5  8  10

*** Test Case ***
Percorrer FOR
    Percorrendo for

*** Keywords ***
Percorrendo for
    Log To Console    ${\n}
    FOR  ${NUMERO}   IN  @{MINHA_LISTA}
        IF   ${NUMERO} == 5      
            Log To Console  Eu sou o número ${MINHA_LISTA[3]}!
        ELSE IF  ${NUMERO} == 10
            Log To Console  Eu sou o número ${MINHA_LISTA[5]}!
        ELSE
            Log To Console  Eu não sou o número 5 e nem o 10!
        END
    END
