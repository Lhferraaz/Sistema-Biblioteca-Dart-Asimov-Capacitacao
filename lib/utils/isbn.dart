// Função para verificar a validade de um ISBN-13
bool verificaIsbn(List<int> isbn) {
  // Um ISBN-13 válido deve ter exatamente 13 dígitos
  if (isbn.length != 13) return false;

  int soma = 0;

  // Cálculo do dígito verificador
  for (int i = 0; i < 12; i++) {
    // Multiplica os dígitos alternadamente por 1 e 3
    soma += (i.isEven) ? isbn[i] : isbn[i] * 3;
  }

  // Calcula o dígito verificador esperado
  int digitoVerificador = (10 - (soma % 10)) % 10;

  return digitoVerificador == isbn[12];
}