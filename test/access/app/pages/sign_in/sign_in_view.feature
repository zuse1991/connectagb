Feature: Sign In View
    Scenario: Are correct displayed
        Given the sign in screen is open 
        Then I see {'E-mail'} text
        And I see {'Senha'} text
        And I see {'Criar agora'} text

    Scenario: Wrong user or password provided
        Given the sign in screen is open
        Then I see {'E-mail'} text
        And I enter {'andrei.zuse@gmail.com'} into {0} input field
        And I enter {'invalida'} into {1} input field 
        And I tap {'Entrar'} text
        When time passes
        Then I see {'Usuário ou senha inválidos'} text

    Scenario: Create account screen open
    Given the sign in screen is open
        Then I tap {'Criar agora'} text
        When time passes
        Then I see {'Criar conta'} text
