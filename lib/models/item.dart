import 'emprestimo.dart';

abstract class Item {
  String titulo;
  int anoPublicacao;
  int quantidadeEstoque;
  int id = 0;

  Map<String, Emprestimo> historicoEmprestimos = {};

  Item(this.titulo, this.anoPublicacao, this.quantidadeEstoque)
      : assert(quantidadeEstoque >= 0, 'Quantidade em estoque deve ser menor ou igul a 0'),
        assert(titulo.isNotEmpty, 'O Título não pode ser vazio'),
        assert(anoPublicacao > 0 && anoPublicacao <= DateTime.now().year, 'Ano de publicação inválido') {
    if (quantidadeEstoque <= 0) {
      throw Exception('A quantidade não pode ser menor que 0!');
    }
    if (titulo.isEmpty) {
      throw Exception('O Título não pode estar vazio!');
    }
    if (anoPublicacao <= 0 || anoPublicacao > DateTime.now().year) {
      throw Exception('Ano de publicação inválido!');
    }
  }

  // SETTERS
  set setTitulo(String novoTitulo) {
    if (novoTitulo.isEmpty) throw Exception('Título não pode ser vazio');
    titulo = novoTitulo;
  }

  set setAno(int ano) {
    if (ano <= 0 || ano > DateTime.now().year) {
      throw Exception('Ano inválido');
    }
    anoPublicacao = ano;
  }

  set setQuantidade(int qtd) {
    if (qtd < 0) throw Exception('Quantidade inválida');
    quantidadeEstoque = qtd;
  }

  void emprestar(String nome) {
    if (quantidadeEstoque <= 0) {
      throw Exception('Empréstimo indisponível. Não há cópias em estoque');
    }
    if (nome.isEmpty) {
      throw Exception('Nome não pode estar vazio');
    }

    quantidadeEstoque--;
    DateTime dataRetirada = DateTime.now();

    var novoEmprestimo = Emprestimo(cliente: nome, dataRetirada: dataRetirada);
    id++;
    historicoEmprestimos[nome] = novoEmprestimo;

    print('\nEmpréstimo do item $titulo realizado com sucesso\n');
  }

  String exibirDetalhes();
  void devolver(String nome, DateTime? simulacao);
}