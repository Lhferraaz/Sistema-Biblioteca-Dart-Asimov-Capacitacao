import '../utils/isbn.dart';
import 'item.dart';

class Livro extends Item {
  String autor;
  List<int> isbn;

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

  @override
  String exibirDetalhes() {
    String text = '''
Título: $titulo
Ano de publicação: $anoPublicacao
Autor: $autor
ISBN: ${isbn.join()}
    ''';

    return text;
  }

  @override
  void devolver(String nome, DateTime? simulacao) {
    if (!historicoEmprestimos.containsKey(nome)) {
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

    if (dataDevol.isAfter(emprestimo.dataPrazoFinal)) {
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