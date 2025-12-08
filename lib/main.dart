import 'services/biblioteca_service.dart';
import 'models/item.dart';
import 'dart:io';

void main() {
  List <Item> biblioteca = [];

  while (true) {
    print('''
=== Sistema da AsiBiblioteca ===
1. Listar itens
2. Inserir item
3. Emprestar item
4. Devolver item
5. Sair
''');

    stdout.write('Escola: ');
    String? opc = stdin.readLineSync();

    switch(opc) {
      case '1':
        listarItens(biblioteca);
        break;
      case '2':
        insereItem(biblioteca);
        break;
      case '3':
        emprestarItem(biblioteca);
        break;
      case '4':
        devolverItem(biblioteca);
        break;
      case '5':
        print('Encerrando....');
        return;
      default:
      print('Opção inválida. Tente novamente.');
    }
  }
}