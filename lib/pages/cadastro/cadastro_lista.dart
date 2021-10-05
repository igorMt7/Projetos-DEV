import 'dart:io';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:partilhe/app.router.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';
import 'package:partilhe/routes/rotas.dart';

class ListaAssistidos extends StatelessWidget {
  const ListaAssistidos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _store = GetIt.I<CadastrosStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastros"),
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
          itemCount: _store.cadastros.length,
          itemBuilder: (context, index) {
            return _listaCadastros(context, index, _store);
          },
        );
      }),
    );
  }

  _listaCadastros(BuildContext context, int index, CadastrosStore store) {
    return GestureDetector(
      child: Card(
        child: Container(
          width: double.maxFinite - 10,
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Observer(builder: (context) {
                    return Container(
                      width: 60.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: store.cadastros[index].imagem != null
                                ? FileImage(File(store.cadastros[index].imagem))
                                : AssetImage("images/cadastro.png")),
                      ),
                    );
                  }),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(store.cadastros[index].nome ?? "",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          Text(store.cadastros[index].telefone ?? "",
                              style: TextStyle(fontSize: 17)),
                          Text(store.cadastros[index].endereco ?? "",
                              style: TextStyle(fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 60.0,
                    height: 80.0,
                    child: IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: () {
                        _confirmaExclusao(
                            context, store.cadastros[index].id, store);
                      },
                    ),
                  )
                ],
              )),
        ),
      ),
      onTap: () {
        AppRouter.gotoParams(
          nomeRota: rotaCadastro,
          parametros: store.cadastros[index],
        );
      },
    );
  }

  void _confirmaExclusao(BuildContext context, int id, CadastrosStore store) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Cadastro"),
          content: Text("Confirma a exclusão do Cadastro?"),
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
