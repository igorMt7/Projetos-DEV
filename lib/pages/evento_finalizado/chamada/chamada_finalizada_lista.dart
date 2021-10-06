import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';
import 'package:partilhe/pages/evento_finalizado/chamada/store/chamada_finalizada_store.dart';

class ChamadaEventoFinalizado extends StatelessWidget {
  final int idEvento;
  final _store = GetIt.I<CadastrosStore>();
  final chamadaStore = ChamadaFinalizadaStore();

  ChamadaEventoFinalizado({@required this.idEvento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Chamada Finalizada"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: chamadaStore.iniciarChamada(idEvento),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return Observer(builder: (context) {
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: _store.cadastros.length,
                  itemBuilder: (context, index) {
                    final cadastroStore = _store.cadastros[index];
                    return GestureDetector(
                      child: Card(
                        color: cadastroStore.isChecked
                            ? Colors.lightGreen[200]
                            : Colors.white,
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
                                          image: cadastroStore.imagem != null
                                              ? FileImage(
                                                  File(cadastroStore.imagem))
                                              : AssetImage(
                                                  "images/cadastro.png")),
                                    ),
                                  );
                                }),
                                Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(cadastroStore.nome ?? "",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(cadastroStore.endereco ?? "",
                                              style: TextStyle(fontSize: 11)),
                                        ],
                                      )),
                                ),
                                Container(
                                  width: 60.0,
                                  height: 80.0,
                                  child: Visibility(
                                    visible: cadastroStore.isChecked,
                                    child: Icon(Icons.check),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      onTap: () {
                        cadastroStore.check();
                      },
                    );
                  },
                );
              });
            } else {
              return Container(child: Text('Carregando...'));
            }
          }),
    );
  }
}
