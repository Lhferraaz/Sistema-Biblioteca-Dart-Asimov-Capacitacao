// Sistema de biblioteca para gerenciamento de livros e revistas - Asimov
// Linguagem: Dart
// Autor: Luiz Henrique Ferraz Amaro
// Data: 03/12/2025

// Classe de Empréstimo
class Emprestimo{
  // Atributos
  int idEmp;
  DateTime dataRetirada;
  DateTime dataPrazoFinal;
  DateTime? dataDevolucao;
  String status;

  // Construtor + Validações
  Emprestimo({required this.idEmp, required this.dataRetirada, this.status = 'Ativo'}):
    // Livro deve ser devolvido após 7 dias
    dataPrazoFinal = dataRetirada.add(Duration(days: 7));
}

// Classe Item
class Item{
  // Atributos da Super
  String titulo;
  int anoPublicacao;
  int quantidadeEstoque;
  int id = 0;
  Map <int, Emprestimo> historicoEmprestimos = {}; // Mapa para guardar empréstimos no tipo: id - data

  // Construtor + validações
  Item(this.titulo, this.anoPublicacao, this.quantidadeEstoque):
    assert(quantidadeEstoque >= 0, 'Quantidade em estoque deve ser menor ou igul a 0'),
    assert(titulo.isNotEmpty, 'O Título não pode ser vazio'),
    assert(anoPublicacao > 0 && anoPublicacao < DateTime.now().year, 'Ano de publicação inválido');

  // Método de empréstimo de livros
  int emprestar(){
    // Validação com exception
    if (quantidadeEstoque <= 0){
      throw Exception('Empréstimo indisponível. Não há cópias em estoque');
    }

    // Decrementa a quantidade de cópias
    quantidadeEstoque--;

    // Variáveis para criação do empréstimo
    DateTime dataRetirada = DateTime.now();
    int idEmp = id;

    // Esse bloco de código possuí o seguinte funcionamento:
    // * Primeiro crio um novo objeto da classe Emprestimo.
    // * Com o objeto da classe Emprestimo criada, pego o idEmp e adiciono ele
    // como uma key no meu mapa de historico de empréstimos.
    // * Depois atribuo a essa key o valor novoEmprestimo, assim cada id corresponde
    // corretamente ao emprestimo atrelado a ele.
    // Isso facilita gerenciar cenários aonde mais de uma cópia do mesmo livro é
    // emprestada. Também incremento o id, para que cada um seja único.
    var novoEmprestimo = Emprestimo(idEmp: idEmp, dataRetirada: dataRetirada);
    id++;
    historicoEmprestimos[idEmp] = novoEmprestimo;
    return idEmp;
  }

  void devolver(int IdEmp){
    if (!historicoEmprestimos.containsKey(IdEmp)){
      print('Id inválido inserido');
      return;
    }

    var emprestimo = historicoEmprestimos[IdEmp];
    DateTime dataDevol = DateTime.now();

    if (dataDevol.isAfter(emprestimo.dataDevolucao)){

    }
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