*** Settings ***
Library          SeleniumLibrary
Library          FakerLibrary
Library          Telnet
Library          String

*** Variables ***
${LINK}         http://automationpractice.com/index.php?id_product=2&controller=product&search_query=Blouse&results=1
${URL}          http://automationpractice.com   
${BROWSER}      chrome
${IMAGEM}       http://automationpractice.com/img/p/7/7-home_default.jpg
&{PESSOA}       nome=Vinicius    sobrenome=Avanci    senha=admin123    endereco=Rua Teste    cidade=Teste    ZIP=12345    telefone=12345    
...             id=Admin
@{ROUPAS}       Summer Dresses    Printed Summer Dress    Printed Chiffon Dress


*** Keywords ***
   
# Abrir navegador
#     Open Browser      http://automationpractice.com   ${BROWSER}

Fechar navegador
    Close Browser    


#Passos
Acessar a página home do site
    Title Should Be     My Store

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text                       id=search_query_top    ${PRODUTO}

Clicar no botão Pesquisar
    Click Element                    name=submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible    css=#center_column > h1
    Title Should Be                  Search - My Store
    Page Should Contain Image        css=#center_column > ul > li > div > div > div > a > img[src="${IMAGEM}"]
    Page Should Contain Link         css=#center_column > ul > li > div > div > h5 > a[href="${LINK}"]

Conferir mensagem de erro "${MENSAGEM}"
    Wait Until Element Is Visible    css=#center_column > p
    Element Text Should Be           css=#center_column > p        ${MENSAGEM}

Passar o mouse por cima da categoria "${MENU}" no menu principal superior de categorias.
    Wait Until Element Is Visible    css= #block_top_menu > ul > li:nth-child(1) > a
    Mouse Over                       css= #block_top_menu > ul > li:nth-child(1) > a 

Clicar na sub categoria "${SUBMENU}"
    Click Element                    css= #block_top_menu > ul > li:nth-child(1) > ul > li:nth-child(2) > ul > li:nth-child(3) > a

Conferir a categoria do produto "${SUBMENU}"
    Wait Until Element Is Visible    css= #center_column > div.content_scene_cat > div > div > span
    Element Text Should Be           css= #center_column > div.content_scene_cat > div > div > span    ${SUBMENU}  

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa. 
    Input Text                       id=search_query_top    ${PRODUTO}  

Clicar no botão "Add to cart" do produto
    Wait Until Element Is Visible    css=#center_column > ul > li > div > div.left-block > div > a.product_img_link > img
    Mouse Over                       css=#center_column > ul > li > div > div.left-block > div > a.product_img_link > img
    Click Element                    css=#center_column > ul > li > div > div.right-block > div.button-container > a.button.ajax_add_to_cart_button.btn.btn-default > span

Clicar no botão "Proceed to checkout"
    Wait Until Element Is Visible    css=#layer_cart > div.clearfix > div.layer_cart_product.col-xs-12.col-md-6
    Click Element                    css=#layer_cart > div.clearfix > div.layer_cart_cart.col-xs-12.col-md-6 > div.button-container > a > span

Verificar tela do carrinho
    Wait Until Element Is Visible    css=#order_step > li.step_current.first > span
    Title Should Be                  Order - My Store
    Element Text Should Be           css= #product_1_1_0_0 > td.cart_description > p > a    Faded Short Sleeve T-shirts
    Element Text Should Be           css=#total_price    $18.51

Clicar no botão de remoção de produtos (delete) no produto do carrinho
    Wait Until Element Is Enabled    css=#order_step > li.step_current.first > span
    Mouse Over                       css=#header > div:nth-child(3) > div > div > div:nth-child(3) > div > a > b        
    Click Element                    css=#header > div:nth-child(3) > div > div > div:nth-child(3) > div > div > div > div > dl > dt > span > a

O sistema deve exibir a mensagem "${MENSAGEM}"
    Wait Until Element Is Enabled        css=#center_column > p


Clicar no botão superior direito “Sign in”
    Click Element                   css=#header > div.nav > div > div > nav > div.header_user_info > a        


Inserir um e-mail válido
    ${EMAILFAKE}                    FakerLibrary.Email
    Wait Until Element Is Visible   css=#SubmitCreate > span
    Input Text                      css=#email_create            ${EMAILFAKE}

Clicar no botão "${BOTAO}"
    Click Element                   css=#SubmitCreate > span

Preencher os campos obrigatórios
    Wait Until Element Is Visible   css=#account-creation_form > div:nth-child(1) > h3
    # ${NOME}                         FakerLibrary.First Name
    # ${SOBRENOME}                    FakerLibrary.Last Name
    # ${ENDERECO}                     FakerLibrary.Street Address
    # ${CIDADE}                       FakerLibrary.City
    # ${ZIP}                          FakerLibrary.Postalcode
    # ${TELEFONE}                     FakerLibrary.Random Number
    Input Text                      css=#customer_firstname                ${PESSOA.nome}
    Input Text                      css=#customer_lastname                 ${PESSOA.sobrenome}
    Input Text                      css=#address1                          ${PESSOA.endereco}
    Input Text                      css=#passwd                            ${PESSOA.senha}
    Input Text                      css=#city                              ${PESSOA.cidade}
    Wait Until Element Is Visible   css=#id_state
    Select From List By Index       css=#id_state                          9
    Input Text                      css=#postcode                          ${PESSOA.ZIP}
    Input Text                      css=#phone_mobile                      ${PESSOA.telefone}
    
    
Clicar em "Register"para finalizar o cadastro
    Click Element                   css=#submitAccount > span
    Wait Until Element Is Visible   css=#center_column > p
    Element Text Should Be          css=#center_column > p        Welcome to your account. Here you can manage all of your personal information and orders.
    
Acessar ele
    Open Browser      https://opensource-demo.orangehrmlive.com/       ${BROWSER}
    
# Colocar os campos
#     Wait Until Element Is Visible    css=#txtUsername
#     Input Text                       css=#txtUsername        ${PESSOA.id}
#     Input Text                       css=#txtPassword        ${PESSOA.senha}
    # Page Should Contain Element      xpath=//*[@id="center_column"]/h1/span[contains(text(), "${ROUPAS[0]}")]
    # Page Should Contain Element      xpath=//*[@id="center_column"]/ul/li[1]/div/div[2]/h5/a[@title="${ROUPAS[1]}"]
    # Page Should Contain Element      xpath=//*[@id="center_column"]/ul/li[2]/div/div[2]/h5/a[@title="${ROUPAS[1]}"]
    # Page Should Contain Element      xpath=//*[@id="center_column"]/ul/li[3]/div/div[2]/h5/a[@title="${ROUPAS[2]}"]

E-mail custom
   [Arguments]                  ${NOME}    ${SOBRENOME}
   ${STRING_ALEATORIA}          Generate Random String
   ${EMAIL_CUSTOM}              Set Variable    ${NOME}${SOBRENOME}${STRING_ALEATORIA}@testrobot.com
   Log                          ${EMAIL_CUSTOM}
   [Return]                     ${EMAIL_CUSTOM}
   
Informar um e-mail válido
    Wait Until Element Is Visible       css=#txtUsername
    ${EMAIL}   E-mail custom            ${PESSOA.nome}          ${PESSOA.sobrenome}
    Input Text                          css=#txtUsername        ${EMAIL}
     