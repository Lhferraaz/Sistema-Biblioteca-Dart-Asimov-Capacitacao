import 'dart:io';
import 'package:sistema_biblioteca/models/item.dart';
import 'package:sistema_biblioteca/models/livro.dart';
import 'package:sistema_biblioteca/models/revista.dart';

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