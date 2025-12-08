// Autor: Luiz Henrique Ferraz Amaro
// Data de criação: 03 / 12 / 2025
// Descrição: Sistema de Biblioteca em Dart - Validação de ISBN e gerenciamento de empréstimos
// Capacitação da Asimov - Módulo Dart

// Função para verificar a validade do ISBN-13
bool verificaIsbn(List<int> isbn) {
  // Verifica se o comprimento do ISBN é 13
  if (isbn.length != 13) return false;

  int soma = 0;

  // Cálculo do dígito verificador
  for (int i = 0; i < 12; i++) {
    if (i.isEven) {
      soma += isbn[i];
    } else {
      soma += isbn[i] * 3;
    }
  }

  // Cálculo do dígito verificador esperado
  int digitoVerificador = (10 - (soma % 10)) % 10;

  // Verifica se o dígito verificador calculado corresponde ao fornecido
  if (digitoVerificador == isbn[12]) {
    return true;
  }

  return false;
}

// Classe para representar um empréstimo
class Emprestimo {
  // Atributos
  String cliente;
  DateTime dataRetirada;
  DateTime dataPrazoFinal;
  DateTime? dataDevolucao;
  String status;

  // Construtor
  Emprestimo({required this.cliente, required this.dataRetirada, this.status = 'Ativo'})
      : dataPrazoFinal = dataRetirada.add(Duration(days: 7)) {
        // Validações
        if (cliente.isEmpty) {
          throw Exception('Cliente não pode estar vazio!');
        }
      }

  // Setters 
  set setCliente(String v) {
    if (v.isEmpty) throw Exception('Cliente inválido');
    cliente = v;
  }
  
  set setStatus(String v) {
    if (v.isEmpty) throw Exception('Status inválido');
    status = v;
  }

  set setDataDevolucao(DateTime? v) {
    dataDevolucao = v;
  }
}

// Classe abstrata para representar um item na biblioteca
abstract class Item {
  // Atributos
  String titulo;
  int anoPublicacao;
  int quantidadeEstoque;
  Map<String, Emprestimo> historicoEmprestimos = {};

  // Construtor
  Item(this.titulo, this.anoPublicacao, this.quantidadeEstoque)
      // Validações
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

  // Setters
  set setTitulo(String v) {
    if (v.isEmpty) throw Exception('Título inválido');
    titulo = v;
  }

  set setAnoPublicacao(int v) {
    if (v <= 0 || v > DateTime.now().year) throw Exception('Ano inválido');
    anoPublicacao = v;
  }

  set setQuantidadeEstoque(int v) {
    if (v < 0) throw Exception('Quantidade inválida');
    quantidadeEstoque = v;
  }

  set setId(int v) {
    if (v < 0) throw Exception('Id inválido');
    id = v;
  }

  set setHistorico(Map<String, Emprestimo> v) {
    historicoEmprestimos = v;
  }
  // Função de empréstimo
  void emprestar(String nome) {
    // Quantidade em estoque deve ser maior que 0
    if (quantidadeEstoque <= 0) {
      throw Exception('Empréstimo indisponível. Não há cópias em estoque');
    }

    // Nome do cliente não pode estar vazio
    if (nome.isEmpty) {
      throw Exception('Nome não pode estar vazio');
    }

    // Realiza o empréstimo
    quantidadeEstoque--;

    // Registra o empréstimo no histórico
    DateTime dataRetirada = DateTime.now();

    // Cria um novo objeto de empréstimo
    var novoEmprestimo = Emprestimo(cliente: nome, dataRetirada: dataRetirada);
    historicoEmprestimos[nome] = novoEmprestimo;
    print('\nEmpréstimo do item $titulo realizado com sucesso\n');
  }
  // Métodos abstratos
  String exibirDetalhes();
  void devolver(String nome, DateTime? simulacao);
}

// Classe para representar um livro
class Livro extends Item {
  // Atributos
  String autor;
  List<int> isbn;

  // Construtor
  Livro(this.autor, this.isbn, super.titulo, super.anoPublicacao, super.quantidadeEstoque)
      // Validações
      : assert(autor.isNotEmpty, 'Autor não pode ser vazio') {
    if (!verificaIsbn(isbn)) {
      throw Exception('ISBN inválido inserido!');
    }

    if (autor.isEmpty) {
      throw Exception('Autor não pode ser vazio! - Se for desconhecido, informe.');
    }
  }

  // Setters
  set setAutor(String v) {
    if (v.isEmpty) throw Exception('Autor inválido');
    autor = v;
  }

  set setIsbn(List<int> v) {
    if (!verificaIsbn(v)) throw Exception('ISBN inválido');
    isbn = v;
  }

  // Função que exibe os detalhes do livro
  String exibirDetalhes() {
    String text = '''
Título: $titulo
Ano de publicação: $anoPublicacao
Autor: $autor
ISBN: ${isbn.join()}
    ''';

    return text;
  }

  // Função de devolução - Possui uma variável de debug "simulacao" para validar
  // cenários de atrasos.
  void devolver(String nome, DateTime? simulacao) {
    // O Mapa deve conter o nome informado
    if (!historicoEmprestimos.containsKey(nome)) {
      print('Id inválido inserido');
      return;
    }

    // Recupera o empréstimo do cliente
    var emprestimo = historicoEmprestimos[nome]!;

    // Exibe as informações do item devolvido
    print('Devolução do item:  $titulo: ');
    print('Detalhes da obra: \n');
    print(exibirDetalhes());
    
    print('-----------------------\n');

    // Data de devolução, se simulacao for nula, usa a data atual
    DateTime dataDevol = simulacao ?? DateTime.now();

    print('Informações sobre pagamento: \n');

    // Verifica se a devolução está atrasada
    if (dataDevol.isAfter(emprestimo.dataPrazoFinal)) {
      // Calcula a diferença em dias
      Duration diferenca = emprestimo.dataPrazoFinal.difference(dataDevol);

      // Calcula os dias de atraso
      int dias = diferenca.inDays.abs();

      print('A data de devolução superou o prazo original em $dias dias');
      // Calcula a multa
      double multa = dias * 2.5;
      print('Valor da multa por atraso: $multa');
      // Calcula o total devido
      double total = multa + 15;
      print('Valor total devido: $total\n');
      print('-----------------------\n');
      return;
    }

    // Devolução dentro do prazo
    print('O prazo de devolução está em dia.');
    // Valor fixo para devolução dentro do prazo
    int total = 15;
    print('Valor total devido: $total\n');
    print('-----------------------\n');

    // Atualiza o estoque e remove o empréstimo do histórico
    quantidadeEstoque++;
    historicoEmprestimos.remove(nome);

    return;
  }
}

// Classe para representar uma revista
class Revista extends Item {
  // Atributos
  int numExibicao;
  String mesPublicacao;

  // Construtor
  Revista(this.numExibicao, this.mesPublicacao, super.titulo, super.anoPublicacao, super.quantidadeEstoque)
      // Validações
      : assert(numExibicao > 0, 'Número de exibição deve ser maior que 0') {
    if (numExibicao <= 0) {
      throw Exception('Número de exibição inválido inserido!');
    }

    if (mesPublicacao.isEmpty) {
      throw Exception('Mês de publicação não pode estar vazio!');
    }
  }

  // Setters
  set setNumExibicao(int v) {
    if (v <= 0) throw Exception('Número inválido');
    numExibicao = v;
  }

  set setMesPublicacao(String v) {
    if (v.isEmpty) throw Exception('Mês inválido');
    mesPublicacao = v;
  }

  // Função que exibe os detalhes da revista
  String exibirDetalhes() {
    String text = '''
Título: $titulo
Ano de publicação: $anoPublicacao
N° de exibição: $numExibicao
Mês de publicação: $mesPublicacao
    ''';

    return text;
  }

  // Função de devolução - Possui uma variável de debug "simulacao" para validar
  // cenários de atrasos.
  // Funciona de forma semelhante à devolução do livro, mas com valores diferentes
  void devolver(String nome, DateTime? simulacao) {
    if (!historicoEmprestimos.containsKey(nome)) {
      print('Id inválido inserido');
      return;
    }

    var emprestimo = historicoEmprestimos[nome]!;

    print('\nDevolução do item: $titulo: ');
    print('Detalhes da revista: \n');
    print(exibirDetalhes());

    print('-----------------------\n');

    DateTime dataDevol = simulacao ?? DateTime.now();

    if (dataDevol.isAfter(emprestimo.dataPrazoFinal)) {
      Duration diferenca = emprestimo.dataRetirada.difference(dataDevol);

      int dias = diferenca.inDays.abs();

      print('A data de devolução superou o prazo original em $dias dias');
      double multa = dias * 1;
      print('Valor da multa por atraso: $multa');
      double total = multa + 5;
      print('Valor total devido: $total');
      return;
    }

    print('O prazo de devolução está em dia.');
    int total = 5;
    print('Valor total devido: $total\n');
    print('-----------------------\n');

    quantidadeEstoque++;
    historicoEmprestimos.remove(nome);

    return;
  }
}

void main() {
  var isbnLivro1 = [9, 7, 8, 8, 5, 0, 3, 0, 0, 9, 9, 7, 3];
  var livro1 = Livro('Luiz', isbnLivro1, 'Entrega Asimov', 2025, 5);

  print(livro1.exibirDetalhes());
  print(verificaIsbn(isbnLivro1));
}
