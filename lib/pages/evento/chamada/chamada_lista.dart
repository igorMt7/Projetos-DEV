import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';

class Chamada extends StatelessWidget {
  final _store = GetIt.I<CadastrosStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      appBar: AppBar(
        title: Text("Lista de Chamada"),
        centerTitle: true,
      ),
      body: Observer(builder: (context) {
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
                        Container(
                          width: 60.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: cadastroStore.imagem != null
                                    ? FileImage(File(cadastroStore.imagem))
                                    : AssetImage("images/cadastro.png")),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                        Visibility(
                          visible: cadastroStore.isChecked,
                          child: Icon(Icons.check),
                        )
                      ],
                    )),
              ),
              onTap: () {
                cadastroStore.check();
              },
            );
          },
        );
      }),
    );
  }
}
