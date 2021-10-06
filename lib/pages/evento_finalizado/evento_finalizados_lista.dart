import 'dart:io';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:partilhe/app.router.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/pages/evento_finalizado/stores/eventos_finalizados_store.dart';
import 'package:partilhe/routes/rotas.dart';

class ListaEventosFinalizados extends StatelessWidget {
  final db = GetIt.I<DatabaseHelper>();

  @override
  Widget build(BuildContext context) {
    final _store = GetIt.I<EventosFinalizadosStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos Finalizados"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
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

  _listaEventos(
      BuildContext context, int index, EventosFinalizadosStore store) {
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
                          image: store.eventos[index].imagem != null
                              ? FileImage(File(store.eventos[index].imagem))
                              : AssetImage("images/evento.png")),
                    ),
                  );
                }),
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
              ],
            )),
      ),
      onTap: () {
        AppRouter.gotoParams(
          nomeRota: rotaEventoFinalizado,
          parametros: store.eventos[index],
        );
      },
    );
  }
}
