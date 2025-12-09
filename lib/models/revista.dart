import 'item.dart';

class Revista extends Item {
  int numExibicao;
  String mesPublicacao;

  Revista(this.numExibicao, this.mesPublicacao, super.titulo, super.anoPublicacao, super.quantidadeEstoque)
      : assert(numExibicao > 0, 'Número de exibição deve ser maior que 0') {
    if (numExibicao <= 0) {
      throw Exception('Número de exibição inválido inserido!');
    }
    if (mesPublicacao.isEmpty) {
      throw Exception('Mês de publicação não pode estar vazio!');
    }
  }

  // SETTERS
  set setNumExibicao(int novoNum) {
    if (novoNum <= 0) throw Exception('Número inválido');
    numExibicao = novoNum;
  }

  set setMes(String novoMes) {
    if (novoMes.isEmpty) throw Exception('Mês inválido');
    mesPublicacao = novoMes;
  }

  @override
  String exibirDetalhes() {
    String text = '''
Tipo: Revista
Título: $titulo
Ano de publicação: $anoPublicacao
N° de exibição: $numExibicao
Mês de publicação: $mesPublicacao
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

    print('\nDevolução do item: $titulo: ');
    print('Detalhes da revista: \n');
    print(exibirDetalhes());

    print('-----------------------\n');

    DateTime dataDevol = simulacao ?? DateTime.now();

    if (dataDevol.isAfter(emprestimo.dataPrazoFinal)) {
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