// Sistema de biblioteca para gerenciamento de livros e revistas - Asimov
// Linguagem: Dart
// Autor: Luiz Henrique Ferraz Amaro
// Data: 03/12/2025

class Emprestimo{
  String idEmp;
  DateTime dataRetirada;
  DateTime? dataDevolucao;
  String status;

  Emprestimo({required this.idEmp, required this.dataRetirada, this.status = 'Ativo'}):
    dataDevolucao = dataRetirada.add(Duration(days: 7));
}



class Item{
  String titulo;
  int anoPublicacao;
  int quantidadeEstoque;
  List

  Item(this.titulo, this.anoPublicacao, this.quantidadeEstoque):
    assert(quantidadeEstoque >= 0, 'Quantidade em estoque deve ser menor ou igul a 0'),
    assert(titulo.isNotEmpty, 'O Título não pode ser vazio'),
    assert(anoPublicacao > 0 && anoPublicacao < DateTime.now().year, 'Ano de publicação inválido');
  
  void emprestar(){
    if (quantidadeEstoque <= 0){
      print('Não foi possível realizar o empréstimo. Quantidade em estoque indisponível');
      return;
    }

    
  }

  void devolver(){
    // Implementar
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

class Livro extends Item{
  String autor;
  int isbn;

  Livro(this.autor, this.isbn, super.titulo, super.anoPublicacao, super.quantidadeEstoque):
    assert(autor.isNotEmpty, 'Autor não pode ser vazio');

  

}