import 'emprestimo.dart'; // Importa a classe Emprestimo

// Classe abstrata para representar um item genérico na biblioteca
abstract class Item {
  // Atributos comuns a todos os itens
  String titulo;
  int anoPublicacao;
  int quantidadeEstoque;

  // Mapa para armazenar o histórico de empréstimos, associando o nome do cliente ao empréstimo correspondente
  Map<String, Emprestimo> historicoEmprestimos = {};

  // Construtor + Validações
  Item(this.titulo, this.anoPublicacao, this.quantidadeEstoque)
      : assert(quantidadeEstoque >= 0, 'Quantidade em estoque deve ser menor ou igul a 0'),
        assert(titulo.isNotEmpty, 'O Título não pode ser vazio'),
        assert(anoPublicacao > 0 && anoPublicacao <= DateTime.now().year, 'Ano de publicação inválido') {
    if (quantidadeEstoque <= 0) {
      throw Exception('A quantidade não pode ser menor que 0!');
    }
    if (titulo.isEmpty || titulo.length >= 100) {
      throw Exception('O Título não pode estar vazio ou exceder 100 caracteres!');
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

  // Método para emprestar o item
  void emprestar(String nome) {
    // Validação de disponibilidade e nome
    if (quantidadeEstoque <= 0) {
      throw Exception('Empréstimo indisponível. Não há cópias em estoque');
    }
    // Validação do nome do cliente
    if (nome.isEmpty) {
      throw Exception('Nome não pode estar vazio');
    }

    // Decrementa a quantidade em estoque e cria um novo empréstimo
    quantidadeEstoque--;
    DateTime dataRetirada = DateTime.now();

    var novoEmprestimo = Emprestimo(cliente: nome, dataRetirada: dataRetirada);
    // Adiciona o empréstimo ao histórico
    historicoEmprestimos[nome] = novoEmprestimo;

    print('\nEmpréstimo do item $titulo realizado com sucesso\n');
  }

  // Métodos abstratos para serem implementados nas subclasses
  String exibirDetalhes();
  void devolver(String nome, DateTime? simulacao);
}