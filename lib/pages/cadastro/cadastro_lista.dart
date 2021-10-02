import 'dart:io';

import 'package:partilhe/app.router.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/pages/cadastro/store/cadastro_store.dart';
import 'package:partilhe/pages/cadastro/store/cadastros_store.dart';
import 'package:partilhe/routes/rotas.dart';

class ListaAssistidos extends StatelessWidget {
  const ListaAssistidos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _store = CadastrosStore();
    MediaQuery.of(context).size.height;
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
          AppRouter.gotoParams(
            nomeRota: rotaCadastro,
            parametros: CadastroStore().novo(),
          );
          // _exibeCadastroPage(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        // ignore: deprecated_member_use
        foregroundColor: Theme.of(context).accentColor,
      ),
      body: FutureBuilder(
        future: _store.iniciar(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _store.cadastros.length,
              itemBuilder: (context, index) {
                return _listaCadastros(context, index, _store);
              },
            );
          } else if (snapshot.hasError) {
            return Text('erro');
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _listaCadastros(BuildContext context, int index, CadastrosStore store) {
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
                        image: store.cadastros[index].imagem != null
                            ? FileImage(File(store.cadastros[index].imagem))
                            : AssetImage("images/cadastro.png")),
                  ),
                ),
                Padding(
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
                        Wrap(
                          children: [
                            Text(store.cadastros[index].endereco ?? "",
                                style: TextStyle(fontSize: 11))
                          ],
                        ),
                      ],
                    )),
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    _confirmaExclusao(
                        context, store.cadastros[index].id, index);
                  },
                )
              ],
            )),
      ),
      onTap: () {
        AppRouter.gotoParams(
          nomeRota: rotaCadastro,
          parametros: [store.cadastros[index]],
        );
        // _exibeCadastroPage(context, cadastro: store.cadastros[index]);
      },
    );
  }

  // void _exibeCadastroPage(BuildContext context,
  //     {CadastroStore cadastro}) async {
  //   final cadastroRecebido = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => CadastroPage(cadastro: cadastro)),
  //   );

  //   if (cadastroRecebido != null) {
  //     if (cadastro != null) {
  //       // await db.updateCadastro(cadastroRecebido);
  //     } else {
  //       // await db.insertCadastro(cadastroRecebido);
  //     }
  //     // _exibeTodosCadastros();
  //   }
  // }

  void _confirmaExclusao(BuildContext context, int cadastroid, index) {
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
              onPressed: () {
                // setState(() {
                //   store.cadastros.removeAt(index);
                //   db.deleteCadastro(cadastroid);
                // });
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