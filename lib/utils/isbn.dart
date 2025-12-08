bool verificaIsbn(List<int> isbn) {
  if (isbn.length != 13) return false;

  int soma = 0;

  for (int i = 0; i < 12; i++) {
    soma += (i.isEven) ? isbn[i] : isbn[i] * 3;
  }

  int digitoVerificador = (10 - (soma % 10)) % 10;

  return digitoVerificador == isbn[12];
}