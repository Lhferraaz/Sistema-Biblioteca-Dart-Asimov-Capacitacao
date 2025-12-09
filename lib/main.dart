// Autor: Luiz Henrique Ferraz Amaro
// Curso: Sistemas de Informação
// Instituição: Universidade Federal de Itajubá
// Descrição: Sistema de Biblioteca em Dart - AsiBiblioteca
// Data de início: 03/12/2025
// Capacitação Mobile Asimov Jr

// Imports
import 'services/biblioteca_service.dart';
import 'models/item.dart';
import 'dart:io';
import 'models/livro.dart';
import 'models/revista.dart';

void main() {
  // Inicialização da biblioteca com alguns itens
  List <Item> biblioteca = [];

  var livro1 = Livro('George Orwell', [9,7,8,8,5,0,3,0,0,9,9,7,3], '1984', 1949, 5);
  var revista1 = Revista(120, 'Março', 'Revista Científica', 2022, 3);
  var livro2 = Livro('J.K. Rowling', [9,7,8,8,5,6,4,3,6,5,0,7,0], 'Harry Potter e a Pedra Filosofal', 1997, 4);
  var revista2 = Revista(85, 'Julho', 'Revista de Tecnologia', 2021, 2);
  var livro3 = Livro('J.R.R. Tolkien', [9,7,8,8,5,6,4,3,6,5,0,9,4], 'O Senhor dos Anéis', 1954, 6);
  var revista3 = Revista(200, 'Dezembro', 'Revista de Literatura', 2023, 1);

  biblioteca.addAll([livro1, revista1, livro2, revista2, livro3, revista3]);

  // Loop principal do sistema
  while (true) {
    print('''
=== Sistema da AsiBiblioteca ===
1. Listar itens
2. Inserir item
3. Emprestar item
4. Devolver item
5. Sair
6. Remover Item
7. Editar Item
8. Buscar Item
''');
    // Leitura da opção do usuário
    stdout.write('Escolha: ');
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
      case '6':
        stdout.write('Digite o título do item a ser removido: ');
        String? tituloRemover = stdin.readLineSync();
        if (tituloRemover != null) {
          removeItem(biblioteca, tituloRemover);
        } else {
          print('Título inválido.');
        }
        break;
      case '7':
        stdout.write('Digite o título do item a ser editado: ');
        String? tituloEditar = stdin.readLineSync();
        if (tituloEditar != null) {
          editarItem(biblioteca, tituloEditar);
        } else {
          print('Título inválido.');
        }
        break;
      case '8':
        stdout.write('Digite o título do item a ser buscado: ');
        String? tituloBuscar = stdin.readLineSync();
        if (tituloBuscar != null) {
          buscaItem(biblioteca, tituloBuscar);
        } else {
          print('Título inválido.');
        }
        break;
      default:
      print('Opção inválida. Tente novamente.');
    }
  }
}