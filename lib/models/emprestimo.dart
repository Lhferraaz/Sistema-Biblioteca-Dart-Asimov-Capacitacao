class Emprestimo {
  String cliente;
  DateTime dataRetirada;
  DateTime dataPrazoFinal;
  DateTime? dataDevolucao;
  String status;

  Emprestimo({required this.cliente, required this.dataRetirada, this.status = 'Ativo'})
      : dataPrazoFinal = dataRetirada.add(Duration(days: 7));
}