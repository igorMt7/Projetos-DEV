import 'dart:io';

import 'package:partilhe/helpers/dataBase_helper.dart';
import 'package:partilhe/models/cadastro.dart';
import 'package:partilhe/pages/cadastro_page.dart';
import 'package:flutter/material.dart';

class ListaAssistidos extends StatefulWidget {
  @override
  _ListaAssistidos createState() => _ListaAssistidos();
}

class _ListaAssistidos extends State<ListaAssistidos> {
  DatabaseHelper db = DatabaseHelper();
  List<Cadastro> cadastros = <Cadastro>[];

  @override
  void initState() {
    super.initState();

    _exibeTodosCadastros();
  }

  void _exibeTodosCadastros() {
    db.getCadastros().then((lista) {
      setState(() {
        cadastros = lista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          _exibeCadastroPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).accentColor,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: cadastros.length,
        itemBuilder: (context, index) {
          return _listaCadastros(context, index);
        },
      ),
    );
  }

  _listaCadastros(BuildContext context, int index) {
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
                        image: cadastros[index].imagem != null
                            ? FileImage(File(cadastros[index].imagem))
                            : AssetImage("images/cadastro.png")),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(cadastros[index].nome ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        Text(cadastros[index].telefone ?? "",
                            style: TextStyle(fontSize: 17)),
                        Text(cadastros[index].endereco ?? "",
                            style: TextStyle(fontSize: 11)),
                      ],
                    )),
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    _confirmaExclusao(context, cadastros[index].id, index);
                  },
                )
              ],
            )),
      ),
      onTap: () {
        _exibeCadastroPage(cadastro: cadastros[index]);
      },
    );
  }

  void _exibeCadastroPage({Cadastro cadastro}) async {
    final cadastroRecebido = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadastroPage(cadastro: cadastro)),
    );

    if (cadastroRecebido != null) {
      if (cadastro != null) {
        await db.updateCadastro(cadastroRecebido);
      } else {
        await db.insertCadastro(cadastroRecebido);
      }
      _exibeTodosCadastros();
    }
  }

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
                setState(() {
                  cadastros.removeAt(index);
                  db.deleteCadastro(cadastroid);
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