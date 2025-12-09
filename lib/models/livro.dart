// Imports
import '../utils/isbn.dart';
import 'item.dart';

// Classe Livro
class Livro extends Item {
  // Atributos
  String autor;
  List<int> isbn;

  // Construtor + Validações
  Livro(this.autor, this.isbn, super.titulo, super.anoPublicacao, super.quantidadeEstoque)
      : assert(autor.isNotEmpty, 'Autor não pode ser vazio') {
    if (!verificaIsbn(isbn)) {
      throw Exception('ISBN inválido inserido!');
    }
    if (autor.isEmpty) {
      throw Exception('Autor não pode ser vazio! - Se for desconhecido, informe.');
    }
  }

  // SETTERS
  set setAutor(String novoAutor) {
    if (novoAutor.isEmpty) throw Exception('Autor inválido');
    autor = novoAutor;
  }

  set setIsbn(List<int> novoIsbn) {
    if (!verificaIsbn(novoIsbn)) throw Exception('ISBN inválido');
    isbn = novoIsbn;
  }

  // Método para exibir detalhes do livro
  @override
  String exibirDetalhes() {
    String text = '''
Tipo: Livro
Título: $titulo
Ano de publicação: $anoPublicacao
Autor: $autor
ISBN: ${isbn.join()} 
    ''';

    //isbn.join() transforma a lista de inteiros em uma string contínua

    return text;
  }

  // Método para devolver o livro
  @override
  void devolver(String nome, DateTime? simulacao) {
    // Verifica se o empréstimo existe
    if (!historicoEmprestimos.containsKey(nome)) {
      print('Id inválido inserido');
      return;
    }

    // Obtém o empréstimo correspondente
    var emprestimo = historicoEmprestimos[nome]!;

    print('Devolução do item:  $titulo: ');
    print('Detalhes da obra: \n');
    print(exibirDetalhes());

    print('-----------------------\n');

    // Obtém a data de devolução (simulada ou atual)
    DateTime dataDevol = emprestimo.dataPrazoFinal.add(Duration(days: 5)); // Simulação de atraso

    print('Informações sobre pagamento: \n');
    
    // if que Verifica se a devolução está atrasada
    if (dataDevol.isAfter(emprestimo.dataPrazoFinal)) {
      // Calcula a diferença em dias
      Duration diferenca = emprestimo.dataPrazoFinal.difference(dataDevol);

      // Calcula os dias de atraso (valor abs para não ficar negativo)
      int dias = diferenca.inDays.abs();

      // Calcula a multa com base nos dias de atraso
      print('A data de devolução superou o prazo original em $dias dias');
      double multa = dias * 2.5;
      print('Valor da multa por atraso: $multa');
      double total = multa + 15;
      print('Valor total devido: $total\n');
      print('-----------------------\n');
      return;
    }

    // Se não houve atraso
    print('O prazo de devolução está em dia.');
    int total = 15; // Taxa fixa
    print('Valor total devido: $total\n');
    print('-----------------------\n');

    // Atualiza o estoque e remove o empréstimo do histórico
    quantidadeEstoque++;
    historicoEmprestimos.remove(nome);

    return;
  }
}