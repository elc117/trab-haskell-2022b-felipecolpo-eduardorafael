# Trabalho Comparativo de Haskell: Eduardo Gehrke e Felipe Colpo

 Esse repositório contém duas aplicações voltadas para a mesma tarefa, criar um conjunto de hexágonos com formas aleatórias em um padrão de colméia, usando a marcação svg. 

 Para iniciar o projeto, foi desenvolvido a ideia de criar hexagonos que iriam se alastrar por toda imagem atráves das coordenadas (x,y) aleatórias de sua origem.


 A primeira parte foi desenvolver uma aplicação em uma linguagem multiparadigma e com suporte a programação imperativa, com isso, foi escolhido rust como sendo essa linguagem.
#
## Execução 

Para o exemplo em rust, é necessário baixar o compilador rustc e o geranciador de pacotes cargo, e por fim, executar o comando ``cargo run`` na pasta rust_main ou rodar o arquivo executavel script.sh na pasta rust_main.

 Para executar o exemplo em haskell é necessário acessar o link ``https://replit.com/@EduardoGehrke1/trabalho-haskell#Main.hs`` e clicar em RUN. Já para executar a aplicação que se encontra nesse repositório basta executar o comando ``ghci Main.hs`` ou rodar o arquivo executavel script.sh.

#
## Análise Comparativa

 Em rust foi mais fácil de desenvolver a parte iterações e loops, além de permitir a escolha aleatória do primeiro poligono. Contudo, como rust foi o ponto de desenvolvimento primário, todas as dificuldades de elaborar o programa surgiram nessa fase, já que toda a lógica foi criada nessa etapa.  


 Haskell, a parte de fazer loops foi muito complicado, já que não era possível fazer de não recursiva igual as demais linguagens vistas antes. No caso da aplicação em haskell, o primeiro hexágono é definido de maneira constante, sendo sua primeira posição no canto superior esquerdo. 

A diferença entre as duas aplicações, consite em que em rust foi possível explorar com maior liberdade as possibilidades de aleatoriedade que o sistema svg permitia. Porém, em haskell devido a imutabilidade das funções, os recursos de aleatoriedade não foram 100% explorados. 

## Créditos
    https://replit.com/@AndreaSchwertne/2022haskell-svg-systemrandom#Main.hs
    [Chat GPT](https://chat.openai.com)
    https://rust-br.github.io/rust-book-pt-br/
    https://weareoutman.github.io/rounded-polygon/
    https://www.educative.io/answers/how-to-convert-int-to-float-and-vice-versa-in-haskell
    https://www.youtube.com/watch?v=-WKeret-0iw&ab_channel=MarcosCastro

