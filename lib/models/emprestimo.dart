// Classe para representar um empréstimo de um item da biblioteca
class Emprestimo {
  // Atributos do empréstimo
  String cliente;
  DateTime dataRetirada;
  DateTime dataPrazoFinal;
  DateTime? dataDevolucao;
  String status;

  // Construtor + inicialização do prazo final
  Emprestimo({required this.cliente, required this.dataRetirada, this.status = 'Ativo'})
      : dataPrazoFinal = dataRetirada.add(Duration(days: 7));
}