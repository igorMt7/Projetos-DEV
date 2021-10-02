import 'dart:io';

import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/pages/produto_page.dart';

class ListaProdutos extends StatefulWidget {
  @override
  _ListaProdutos createState() => _ListaProdutos();
}

class _ListaProdutos extends State<ListaProdutos> {
  DatabaseHelper db = DatabaseHelper();
  List<Produto> produtos = <Produto>[];

  @override
  void initState() {
    super.initState();

    _exibeTodosProdutos();
  }

  void _exibeTodosProdutos() {
    db.getProdutos().then((lista) {
      setState(() {
        produtos = lista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibeProdutoPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).accentColor,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return _listaProdutos(context, index);
        },
      ),
    );
  }

  _listaProdutos(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: produtos[index].imagem != null
                            ? FileImage(File(produtos[index].imagem))
                            : AssetImage("images/produto.png")),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(produtos[index].nome ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        Text(produtos[index].quantidade ?? "",
                            style: TextStyle(fontSize: 17)),
                        Text(produtos[index].descricao ?? "",
                            style: TextStyle(fontSize: 11)),
                      ],
                    )),
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    _confirmaExclusao(context, produtos[index].id, index);
                  },
                )
              ],
            )),
      ),
      onTap: () {
        _exibeProdutoPage(produto: produtos[index]);
      },
    );
  }

  void _exibeProdutoPage({Produto produto}) async {
    final produtoRecebido = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProdutoPage(produto: produto)),
    );

    if (produtoRecebido != null) {
      if (produto != null) {
        await db.updateProduto(produtoRecebido);
      } else {
        await db.insertProduto(produtoRecebido);
      }
      _exibeTodosProdutos();
    }
  }

  void _confirmaExclusao(BuildContext context, int produtoid, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Produto"),
          content: Text("Confirma a exclusão do Produto?"),
          actions: <Widget>[
            FloatingActionButton.extended(
              backgroundColor: Theme.of(context).accentColor,
              foregroundColor: Colors.black,
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              label: Text("SIM", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                setState(() {
                  produtos.removeAt(index);
                  db.deleteProduto(produtoid);
                });
                Navigator.of(context).pop();
              },
            ),
            FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).accentColor,
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              label: Text("NÃO", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ], //widget
        );
      },
    );
  }
}

/* ,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
 */