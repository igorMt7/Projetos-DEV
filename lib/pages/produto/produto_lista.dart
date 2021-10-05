import 'dart:io';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:partilhe/app.router.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/pages/produto/stores/produtos_store.dart';
import 'package:partilhe/routes/rotas.dart';

class ListaProdutos extends StatelessWidget {
  const ListaProdutos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _store = GetIt.I<ProdutosStore>();
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
          _store.novo();
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).accentColor,
      ),
      body: Observer(builder: (context) {
        return ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: _store.produtos.length,
          itemBuilder: (context, index) {
            return _listaProdutos(context, index, _store);
          },
        );
      }),
    );
  }

  _listaProdutos(BuildContext context, int index, ProdutosStore store) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Observer(builder: (context) {
                  return Container(
                    width: 60.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: store.produtos[index].imagem != null
                              ? FileImage(File(store.produtos[index].imagem))
                              : AssetImage("images/produto.png")),
                    ),
                  );
                }),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(store.produtos[index].nome ?? "",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          Text(store.produtos[index].quantidade ?? "",
                              style: TextStyle(fontSize: 17)),
                          Text(store.produtos[index].descricao ?? "",
                              style: TextStyle(fontSize: 11)),
                        ],
                      )),
                ),
                Container(
                  width: 60.0,
                  height: 80.0,
                  child: IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      _confirmaExclusao(
                          context, store.produtos[index].id, store);
                    },
                  ),
                )
              ],
            )),
      ),
      onTap: () {
        AppRouter.gotoParams(
          nomeRota: rotaProduto,
          parametros: store.produtos[index],
        );
      },
    );
  }

  void _confirmaExclusao(BuildContext context, int id, ProdutosStore store) {
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
              onPressed: () async {
                await store.deletar(id);
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
          ],
        );
      },
    );
  }
}
