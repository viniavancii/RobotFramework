*** Settings ***
Resource         ../resource/Resource.robot
#Test Setup       Abrir navegador
#Test Teardown    Fechar navegador

*** Variables ***
${URL}      http://automationpractice.com   
${BROWSER}  chrome

*** Test Cases ***
Cenário 01: Listar Produtos
    [Tags]    cenario1
    Acessar a página home do site
    Passar o mouse por cima da categoria "Women" no menu principal superior de categorias.
    Clicar na sub categoria "Summer Dresses"
    Conferir a categoria do produto "Summer Dresses"

Cenário 02: Adicionar Produtos no Carrinho
    [Tags]    cenario2
    Acessar a página home do site
    Digitar o nome de produto "t-shirt" no campo de pesquisa.
    Clicar no botão Pesquisar
    Clicar no botão "Add to cart" do produto
    Clicar no botão "Proceed to checkout"
    Verificar tela do carrinho

Cenário 03: Remover Produtos
    [Tags]    cenario3
    Acessar a página home do site
    Digitar o nome de produto "t-shirt" no campo de pesquisa.
    Clicar no botão Pesquisar
    Clicar no botão "Add to cart" do produto
    Clicar no botão "Proceed to checkout"
    Verificar tela do carrinho
    Clicar no botão de remoção de produtos (delete) no produto do carrinho
    O sistema deve exibir a mensagem "Your shopping cart is empty."

Cenário 04: Adicionar Cliente
    [Tags]    cenario4
    Acessar a página home do site
    Clicar no botão superior direito “Sign in”
    Inserir um e-mail válido
    Clicar no botão "Create na account"
    Preencher os campos obrigatórios
    Clicar em "Register"para finalizar o cadastro

Cenário 05: Criar e-mail
    [Tags]    cenario5
    Acessar ele
    E-mail custom
    Informar um e-mail válido

         
# Cenario 05: Teste outro site decente
#     [Tags]    cenario5
#     Acessar ele
#     Colocar os campos
