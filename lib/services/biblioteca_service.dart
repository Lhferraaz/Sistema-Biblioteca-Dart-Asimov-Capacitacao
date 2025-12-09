import 'dart:io';
import '../models/item.dart';
import '../models/livro.dart';
import '../models/revista.dart';

void listarItens(List<Item> biblioteca) {
  if (biblioteca.isEmpty) {
    print('Nenhum item cadastrado.\n');
    return;
  }

  for (var item in biblioteca) {
    print(item.exibirDetalhes());
    print('----------------------');
  }
}

void insereItem(List<Item> biblioteca) {
  print('Inserção de novo item:');

  stdout.write('Livro / Revista: ');
  String? tipo = stdin.readLineSync()?.trim();

  switch (tipo) {
    case 'Livro':
      stdout.write('Título: ');
      String? titulo = stdin.readLineSync();

      stdout.write('Ano de publicação: ');
      int anoPub = int.parse(stdin.readLineSync()!);

      stdout.write('Quantidade em estoque: ');
      int qtdEstoque = int.parse(stdin.readLineSync()!);

      stdout.write('Autor: ');
      String? autor = stdin.readLineSync();

      stdout.write('ISBN (13 dígitos, sem espaços): ');
      String? isbnInput = stdin.readLineSync();
      List<int> isbn = isbnInput!.split('').map(int.parse).toList();

      biblioteca.add(Livro(autor!, isbn, titulo!, anoPub, qtdEstoque));
      print('Livro inserido com sucesso.\n');
      break;

    case 'Revista':
      stdout.write('Título: ');
      String? tituloR = stdin.readLineSync();

      stdout.write('Ano de publicação: ');
      int ano = int.parse(stdin.readLineSync()!);

      stdout.write('Quantidade em estoque: ');
      int qtd = int.parse(stdin.readLineSync()!);

      stdout.write('Número de exibição: ');
      int num = int.parse(stdin.readLineSync()!);

      stdout.write('Mês de publicação: ');
      String? mes = stdin.readLineSync();

      biblioteca.add(Revista(num, mes!, tituloR!, ano, qtd));
      print('Revista inserida com sucesso.\n');
      break;

    default:
      print('Tipo inválido.');
  }
}

void emprestarItem(List<Item> biblioteca) {
  stdout.write('Digite o título do item a ser emprestado: ');
  String? titulo = stdin.readLineSync()!;

  Item? item;

  for (var i in biblioteca) {
    if (i.titulo == titulo) {
      item = i;
      break;
    }
  }

  if (item == null) {
    print('Item não encontrado.\n');
    return;
  }

  stdout.write('Digite o nome do cliente: ');
  String? nomeCliente = stdin.readLineSync()!;

  item.emprestar(nomeCliente);
}

void devolverItem(List<Item> biblioteca) {
  stdout.write('Título do item a ser devolvido: ');
  String? titulo = stdin.readLineSync()!;

  Item? item;

  for (var i in biblioteca) {
    if (i.titulo == titulo) {
      item = i;
      break;
    }
  }

  if (item == null) {
    print('Item não encontrado.\n');
    return;
  }

  stdout.write('Nome do cliente: ');
  String? nomeCliente = stdin.readLineSync()!;
  
  item.devolver(nomeCliente, null);
}

void removeItem(List<Item> biblioteca, String titulo) {
  if (titulo.isEmpty) {
    print('Título inválido.');
    return;
  }

  biblioteca.removeWhere((item) => item.titulo == titulo);
  print('Item removido com sucesso.\n');
}

void editarItem(List<Item> biblioteca, String titulo) {
  Item? item;

  for (var i in biblioteca) {
    if (i.titulo == titulo) {
      item = i;
      break;
    }

    if (item == null) {
      print('Item não encontrado.\n');
      return;
    }

    stdout.write('Qual atributo deseja editar (escreva exatamente como está na listagem)? ');
    String? atributo = stdin.readLineSync()?.trim();

    if (atributo == null) {
      print('Atributo inválido.');
      return;
    }

    if (atributo == 'Título') {
      stdout.write('Novo título: ');
      String? novoTitulo = stdin.readLineSync();
      item.setTitulo = novoTitulo!;
      print('Título atualizado com sucesso.\n');
    }

    if (atributo == 'Ano de publicação') {
      stdout.write('Novo ano de publicação: ');
      int novoAno = int.parse(stdin.readLineSync()!);
      item.setAno = novoAno;
      print('Ano de publicação atualizado com sucesso.\n');
    }

    if (atributo == 'Quantidade em estoque') {
      stdout.write('Nova quantidade em estoque: ');
      int novaQtd = int.parse(stdin.readLineSync()!);
      item.setQuantidade = novaQtd;
      print('Quantidade em estoque atualizada com sucesso.\n');
    }

    if (atributo == 'Autor' && item is Livro) {
      Item? item;

      for (var i in biblioteca) {
        if (i.titulo == titulo) {
          item = i;
          break;
        }
      }

      if (item == null || item is! Livro) {
        print('Livro não encontrado.\n');
        return;
      }

      stdout.write('Novo autor: ');
      String? novoAutor = stdin.readLineSync();
      item.setAutor = novoAutor!;
      print('Autor atualizado com sucesso.\n');
    }

    if (atributo == 'ISBN') {
      stdout.write('Novo ISBN (13 dígitos, sem espaços): ');
      String? novoIsbnInput = stdin.readLineSync();
      List<int> novoIsbn = novoIsbnInput!.split('').map(int.parse).toList();
      (item as Livro).setIsbn = novoIsbn;
      print('ISBN atualizado com sucesso.\n');
    }

    if (atributo == 'Número de exibição' && item is Revista) {
      stdout.write('Novo número de exibição: ');
      int novoNum = int.parse(stdin.readLineSync()!);
      item.setNumExibicao = novoNum;
      print('Número de exibição atualizado com sucesso.\n');
    }

    if (atributo == 'Mês de publicação' && item is Revista) {
      stdout.write('Novo mês de publicação: ');
      String? novoMes = stdin.readLineSync();
      item.setMes = novoMes!;
      print('Mês de publicação atualizado com sucesso.\n');
    }

    if (atributo != 'Título' &&
        atributo != 'Ano de publicação' &&
        atributo != 'Quantidade em estoque' &&
        !(atributo == 'Autor' && item is Livro) &&
        !(atributo == 'ISBN' && item is Livro) &&
        !(atributo == 'Número de exibição' && item is Revista) &&
        !(atributo == 'Mês de publicação' && item is Revista)) {
      print('Atributo inválido.');
    }
  }
}