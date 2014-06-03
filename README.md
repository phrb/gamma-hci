# Gamma Games IHC

Estamos usando Qt5 e QtCreator para desenvolver este projeto,
visite [QtProject](https://qt-project.org/) para os procedimentos de 
instalação dessas dependências.

## Estrutura dos diretórios

A pasta principal do projeto é a `GammaGames`. A pasta `api`
contém o código para o menu principal da aplicação e a classe
**GammaGame**, que é a base para implementação de novos jogos.

A pasta `games` contém os jogos já implementados, que testaremos
no protótipo.

Para executar a aplicação, inicie o QtCreator e abra o projeto
**GammaGames**. Depois, clique em `Run`, ou aperte `Ctrl+R`.

## A Interface

O menu inicial percorrerá os jogos disponíveis,
que podem ser selecionados com a barra de espaço.

Para interação com os jogos, pensamos num controle 
especial, com apenas um botão, e a barra de espaço 
simulará este controle.

Após 10 segundos sem interação, a aplicação volta para
a interface. Este valor de **timeout** é configurável
pelo desenvolvedor de novos jogos.

###
