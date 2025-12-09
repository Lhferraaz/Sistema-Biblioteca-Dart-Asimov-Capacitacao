// Imports
import 'item.dart';

// Classe Revista
class Revista extends Item {
  // Atributos
  int numExibicao;
  String mesPublicacao;

  // Construtor + Validações
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

  // Método para exibir detalhes da revista
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

  // Método para devolver a revista
  @override
  void devolver(String nome, DateTime? simulacao) {
    // Verifica se o empréstimo existe
    if (!historicoEmprestimos.containsKey(nome)) {
      print('Id inválido inserido');
      return;
    }
    
    // Obtém o empréstimo correspondente
    var emprestimo = historicoEmprestimos[nome]!;

    print('\nDevolução do item: $titulo: ');
    print('Detalhes da revista: \n');
    print(exibirDetalhes());

    print('-----------------------\n');

    // Obtém a data de devolução (simulada ou atual)
    DateTime dataDevol = simulacao ?? DateTime.now();

    // if que verifica se a devolução está atrasada
    if (dataDevol.isAfter(emprestimo.dataPrazoFinal)) {
      // Calcula a diferença em dias
      Duration diferenca = emprestimo.dataRetirada.difference(dataDevol);

      // Calcula os dias de atraso (valor abs para não ficar negativo)
      int dias = diferenca.inDays.abs();

      // Calcula a multa com base nos dias de atraso
      print('A data de devolução superou o prazo original em $dias dias');
      double multa = dias * 2.5;
      print('Valor da multa por atraso: $multa');
      double total = multa + 15;
      print('Valor total devido: $total');
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