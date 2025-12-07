// Sistema de biblioteca para gerenciamento de livros e revistas - Asimov
// Linguagem: Dart
// Autor: Luiz Henrique Ferraz Amaro
// Data: 03/12/2025

class Item{
  String titulo;
  int anoPublicacao;
  int quantidadeEstoque;

  Item(this.titulo, this.anoPublicacao, this.quantidadeEstoque);

  void emprestar(){
    assert(quantidadeEstoque > 0, 'Estoque insuficiente para empréstimo.');

    quantidadeEstoque--;
    print('Empréstimo realizado: $titulo');
  }

  void devolver(){
    quantidadeEstoque++;
    print('Devolução realizada: $titulo');
  }

  String exibirDetalhes(){
    String text = '''
Título: $titulo
Ano de Publicação: $anoPublicacao
Quantidade em Estoque: $quantidadeEstoque
''';

  return text;
  }
}