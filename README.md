Desenvolver o aplicativo Jogo da Memória usando flutter, que consiste em uma única tela com um campo de entrada de dados (TextField) para inserir o apelido do jogador, dois CheckBox para escolher o tipo do conteúdo para memorizar, botão para iniciar o jogo e um tabuleiro com 20 cards (pode ser 5x4 ou 4x5). Ao iniciar o jogo, o app deve mostrar 20 itens para memorizar, podendo ser de dois tipos: números e/ou imagens. 

Ao abrir o app, o usuário deve informar o apelido e escolher o tipo de conteúdo para memorizar através de dois CheckBox, podendo marcar ambos ou somente um. Após o preenchimento do jogador, ele deve clicar no botão de Iniciar para começar o jogo que apresentará 20 itens para memorizar, ou seja, 10 itens com um par cada. Os itens devem ser escondidos e ao ser clicado será mostrado o conteúdo (imagem ou número). Se dois pares de itens foram encontrados, então os itens ficam desabilitados. Caso os pares de itens sejam diferentes, então ambos voltam a ficar escondidos. O objetivo do jogo é encontrar todos os pares de itens com menor número de tentativas.

Escolhas do tipo de conteúdo para memorizar:
- Número: Deve-se apresentar 20 cards com pares de números de 0 à 9.
- Imagens: Deve-se apresentar 20 cards com 10 pares de imagens. Podem ser utilizados quaisquer tipo de imagens que deverão ser salvas na pasta images.
- Ambos: Deve-se apresentar 20 cards com metade dos pares sendo números e a outra metade imagens.

Também, deve-se incluir a informação de quantas tentativas o jogador precisou para completar o jogo e um botão para reiniciar o jogo embaralhando as imagens ou números, conforme marcado pelos CheckBoxes do jogador.
A construção do layout do app é livre.

Deve-se entregar o arquivo compactado contendo o projeto flutter com arquivos indicados a seguir e um print da tela rodando ele com algum simulador (android, web ou desktop).

Arquivos na pasta do projeto flutter:
- Pasta lib;
- Pastas com images;
- Arquivo pubspec.yaml.
