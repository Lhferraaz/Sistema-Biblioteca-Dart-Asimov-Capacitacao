// Imports
import 'dart:io';
import '../models/item.dart';
import '../models/livro.dart';
import '../models/revista.dart';

// Função para listar todos os itens na biblioteca
void listarItens(List<Item> biblioteca) {
  // Verifica se a biblioteca está vazia
  if (biblioteca.isEmpty) {
    print('Nenhum item cadastrado.\n');
    return;
  }

  // Exibe os detalhes de cada item
  for (var item in biblioteca) {
    print(item.exibirDetalhes());
    print('----------------------');
  }
}

// Função para inserir um novo item na biblioteca
void insereItem(List<Item> biblioteca) {
  print('Inserção de novo item:');

  // Solicita o tipo de item ao usuário
  stdout.write('Livro / Revista: ');
  String? tipo = stdin.readLineSync()?.trim();

  // Processa a inserção com base no tipo
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

// Função para emprestar um item
void emprestarItem(List<Item> biblioteca) {
  // Solicita o título do item a ser emprestado
  stdout.write('Digite o título do item a ser emprestado: ');
  String? titulo = stdin.readLineSync()!;

  Item? item;

  // Procura o item na biblioteca
  for (var i in biblioteca) {
    if (i.titulo == titulo) {
      item = i;
      break;
    }
  }

  // Verifica se o item foi encontrado
  if (item == null) {
    print('Item não encontrado.\n');
    return;
  }

  // Solicita o nome do cliente
  stdout.write('Digite o nome do cliente: ');
  String? nomeCliente = stdin.readLineSync()!;

  // Realiza o empréstimo
  item.emprestar(nomeCliente);
}

// Função para devolver um item
void devolverItem(List<Item> biblioteca) {
  // Solicita o título do item a ser devolvido
  stdout.write('Título do item a ser devolvido: ');
  String? titulo = stdin.readLineSync()!;

  Item? item;

  // Procura o item na biblioteca
  for (var i in biblioteca) {
    if (i.titulo == titulo) {
      item = i;
      break;
    }
  }

  // Verifica se o item foi encontrado
  if (item == null) {
    print('Item não encontrado.\n');
    return;
  }

  // Solicita o nome do cliente
  stdout.write('Nome do cliente: ');
  String? nomeCliente = stdin.readLineSync()!;

  // Realiza a devolução
  item.devolver(nomeCliente, null);
}

// Função para remover um item da biblioteca
void removeItem(List<Item> biblioteca, String titulo) {
  // Verifica se o título é válido
  if (titulo.isEmpty) {
    print('Título inválido.');
    return;
  }

  // Remove o item da biblioteca
  biblioteca.removeWhere((item) => item.titulo == titulo);
  print('Item removido com sucesso.\n');
}

void editarItem(List<Item> biblioteca, String titulo) {
  Item? item;

  // Procura o item na biblioteca
  for (var i in biblioteca) {
    if (i.titulo == titulo) {
      item = i;
      break;
    }
  }

  // Verifica se o item foi encontrado
  if (item == null) {
    print('Item não encontrado.\n');
    return;
  }

  // Solicita o atributo a ser editado
  stdout.write('Qual atributo deseja editar (escreva exatamente como está na listagem)? ');
  String? atributo = stdin.readLineSync()?.trim();


  // Edita de acordo com o atributo escolhido
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

  // Verifica se o item é um Livro ou Revista para editar atributos específicos
  // Essa lógica se repete para cada atributo específico
  if (atributo == 'Autor' && item is Livro) {
    stdout.write('Novo autor: ');
    String? novoAutor = stdin.readLineSync();
    item.setAutor = novoAutor!;
    print('Autor atualizado com sucesso.\n');
  }

  if (atributo == 'ISBN' && item is Livro) {
    stdout.write('Novo ISBN (13 dígitos, sem espaços): ');
    String? novoIsbnInput = stdin.readLineSync();
    List<int> novoIsbn = novoIsbnInput!.split('').map(int.parse).toList();
    item.setIsbn = novoIsbn;
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

  // Validação de atributo inválido
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

// Função para buscar um item pelo título
void buscaItem(List<Item> biblioteca, String titulo) {
  Item? item;
  
  // Procura o item na biblioteca
  for (var i in biblioteca) {
    if (i.titulo == titulo) {
      item = i;
      break;
    }
  }

  // Verifica se o item foi encontrado
  if (item == null) {
    print('Item não encontrado.\n');
    return;
  }

  // Exibe os detalhes do item encontrado
  print('Detalhes do item encontrado:\n');
  print(item.exibirDetalhes());
}