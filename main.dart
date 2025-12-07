// Sistema de biblioteca para gerenciamento de livros e revistas - Asimov
// Linguagem: Dart
// Autor: Luiz Henrique Ferraz Amaro
// Data: 03/12/2025

// Classe de Empréstimo
class Emprestimo{
  // Declaração dos atributos
  int idEmp;
  DateTime dataRetirada; // Tipo DateTime
  DateTime? dataDevolucao; // Tipo DateTime
  String status;

  // Construtor + Validações
  Emprestimo({required this.idEmp, required this.dataRetirada, this.status = 'Ativo'}):
    // Defino a data de devolução para 7 dias após a retirada
    dataDevolucao = dataRetirada.add(Duration(days: 7));
}

// Classe Item
class Item{
  // Declaração dos atributos da super
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

    // Crio o novo objeto do tipo Empréstimo
    var novoEmprestimo = Emprestimo(idEmp: idEmp, dataRetirada: dataRetirada);
    id++;
    // Atrelo ao idEmp o próprio novoEmprestimo
    historicoEmprestimos[idEmp] = novoEmprestimo;

    // Retorno id para devolução
    return idEmp;
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