import 'dart:io';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:partilhe/app.router.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/pages/evento/stores/eventos_store.dart';
import 'package:partilhe/routes/rotas.dart';

class ListaEventos extends StatelessWidget {
  final db = GetIt.I<DatabaseHelper>();

  @override
  Widget build(BuildContext context) {
    final _store = GetIt.I<EventosStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos"),
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
          itemCount: _store.eventos.length,
          itemBuilder: (context, index) {
            return _listaEventos(context, index, _store);
          },
        );
      }),
    );
  }

  _listaEventos(BuildContext context, int index, EventosStore store) {
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
                        image: store.eventos[index].imagem != null
                            ? FileImage(File(store.eventos[index].imagem))
                            : AssetImage("images/evento.png")),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(store.eventos[index].nome ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          Text(
                              store.eventos[index].data
                                      ?.toShortStringDateTime ??
                                  "",
                              style: const TextStyle(fontSize: 17)),
                          Text(store.eventos[index].responsavel ?? "",
                              style: const TextStyle(fontSize: 11)),
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
                          context, store.eventos[index].id, store);
                    },
                  ),
                )
              ],
            )),
      ),
      onTap: () {
        AppRouter.gotoParams(
          nomeRota: rotaEvento,
          parametros: store.eventos[index],
        );
      },
    );
  }

  void _confirmaExclusao(BuildContext context, int id, EventosStore store) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Evento"),
          content: Text("Confirma a exclusão do Evento?"),
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
 
/* ,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
 */