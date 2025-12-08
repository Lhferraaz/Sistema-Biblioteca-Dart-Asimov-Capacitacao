// Sistema de biblioteca para gerenciamento de livros e revistas - Asimov
// Linguagem: Dart
// Autor: Luiz Henrique Ferraz Amaro
// Data: 03/12/2025

// Classe de Empréstimo
class Emprestimo {
  // Atributos
  String cliente;
  DateTime dataRetirada;
  DateTime dataPrazoFinal;
  DateTime? dataDevolucao;
  String status;

  // Construtor + Validações
  Emprestimo({required this.cliente, required this.dataRetirada, this.status = 'Ativo'}):
    dataPrazoFinal = dataRetirada.add(Duration(days: 7));
}

// Classe Item
abstract class Item {
  // Atributos da Super
  String titulo;
  int anoPublicacao;
  int quantidadeEstoque;
  int id = 0;
  Map <String, Emprestimo> historicoEmprestimos = {}; // Mapa para guardar empréstimos no tipo: id - data

  // Construtor + validações
  Item(this.titulo, this.anoPublicacao, this.quantidadeEstoque):
    assert(quantidadeEstoque >= 0, 'Quantidade em estoque deve ser menor ou igul a 0'),
    assert(titulo.isNotEmpty, 'O Título não pode ser vazio'),
    assert(anoPublicacao > 0 && anoPublicacao <= DateTime.now().year, 'Ano de publicação inválido');

  // Método de empréstimo de livros
  void emprestar(String nome) {
    // Validação com exception
    if (quantidadeEstoque <= 0) {
      throw Exception('Empréstimo indisponível. Não há cópias em estoque');
    }

    if (nome.isEmpty){
      throw Exception('Nome não pode estar vazio');
    }

    // Decrementa a quantidade de cópias
    quantidadeEstoque--;

    // Variáveis para criação do empréstimo
    DateTime dataRetirada = DateTime.now();

    // Esse bloco de código possuí o seguinte funcionamento:
    // * Primeiro crio um novo objeto da classe Emprestimo.
    // * Com o objeto da classe Emprestimo criada, pego o nome e adiciono ele
    // como uma key no meu mapa de historico de empréstimos.
    // * Depois atribuo a essa key o valor novoEmprestimo, assim cada nome corresponde
    // corretamente ao emprestimo atrelado a ele.
    // Isso facilita gerenciar cenários aonde mais de uma cópia do mesmo livro é
    // emprestada. Também incremento o id, para que cada um seja único.
    var novoEmprestimo = Emprestimo(cliente: nome, dataRetirada: dataRetirada);
    id++;
    historicoEmprestimos[nome] = novoEmprestimo;
    print('\nEmpréstimo do item $titulo realizado com sucesso\n');
  }

  
  String exibirDetalhes();

  // Função de devolução, possuí uma variável que pode ser nula de simulacao 
  // para que eu possa inserir uma data de teste.
  // Método abstrato pois na listagem das informações, cada classe filha tem
  // infos diferentes
  void devolver(String nome, DateTime? simulacao);
}

class Livro extends Item {
  String autor;
  int isbn;

  Livro(this.autor, this.isbn, super.titulo, super.anoPublicacao, super.quantidadeEstoque):
    assert(autor.isNotEmpty, 'Autor não pode ser vazio');

  String exibirDetalhes(){
    String text = '''
Título: $titulo
Ano de publicação: $anoPublicacao
Autor: $autor
ISBN: $isbn
    ''';

    return text;
  }

  void devolver(String nome, DateTime? simulacao) { 
    if (!historicoEmprestimos.containsKey(nome)){
      print('Id inválido inserido');
      return;
    }

    var emprestimo = historicoEmprestimos[nome]!;
    
    print('Devolução do item:  $titulo: ');
    print('Detalhes da obra: \n');
    print(exibirDetalhes());

    print('-----------------------\n');
    
    DateTime dataDevol = simulacao ?? DateTime.now();

    print('Informações sobre pagamento: \n');

    if (dataDevol.isAfter(emprestimo.dataPrazoFinal)){
      Duration diferenca = emprestimo.dataPrazoFinal.difference(dataDevol);

      int dias = diferenca.inDays.abs();

      print('A data de devolução superou o prazo original em $dias dias');
      double multa = dias * 2.5;
      print('Valor da multa por atraso: $multa');
      double total = multa + 15;
      print('Valor total devido: $total\n');
      print('-----------------------\n');
      return;
    }

    print('O prazo de devolução está em dia.');
    int total = 15;
    print('Valor total devido: $total\n');
    print('-----------------------\n');

    quantidadeEstoque++;
    historicoEmprestimos.remove(nome);

    return;
  }
}

class Revista extends Item {
  int numExibicao;
  String mesPublicacao;

  Revista(this.numExibicao, this.mesPublicacao, super.titulo, super.anoPublicacao, super.quantidadeEstoque);

  String exibirDetalhes(){
    String text = '''
Título: $titulo
Ano de publicação: $anoPublicacao
N° de exibição: $numExibicao
Mês de publicação: $mesPublicacao
    ''';

    return text;
  }

  void devolver(String nome, DateTime? simulacao) { 
    if (!historicoEmprestimos.containsKey(nome)){
      print('Id inválido inserido');
      return;
    }

    var emprestimo = historicoEmprestimos[nome]!;

    print('\nDevolução do item: $titulo: ');
    print('Detalhes da revista: \n');
    print(exibirDetalhes());

    print('-----------------------\n');
    
    DateTime dataDevol = simulacao ?? DateTime.now();

    if (dataDevol.isAfter(emprestimo.dataPrazoFinal)){
      Duration diferenca = emprestimo.dataRetirada.difference(dataDevol);

      int dias = diferenca.inDays.abs();

      print('A data de devolução superou o prazo original em $dias dias');
      double multa = dias * 2.5;
      print('Valor da multa por atraso: $multa');
      double total = multa + 15;
      print('Valor total devido: $total');
      return;
    }

    print('O prazo de devolução está em dia.');
    int total = 15;
    print('Valor total devido: $total\n');
    print('-----------------------\n');

    quantidadeEstoque++;
    historicoEmprestimos.remove(nome);

    return;
  }
}

void main() {
  var livro1 = Livro('Luiz', 123123, 'Entrega Asimov', 2025 , 5);
  livro1.emprestar('Luiz Henrique Ferraz Amaro');
  DateTime simulacao = DateTime.now().add(Duration(days: 10));
  livro1.devolver('Luiz Henrique Ferraz Amaro', simulacao);

  var revista1 = Revista(1, 'Setembro', 'Revista Veja', 2024, 2);
  revista1.emprestar('Luiz Henrique Ferraz Amaro');
  revista1.devolver('Luiz Henrique Ferraz Amaro', null);
}