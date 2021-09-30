import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partilhe/helpers/dataBase_helper.dart';
import 'package:partilhe/models/cadastro.dart';

class Chamada extends StatefulWidget {
  @override
  _ChamadaState createState() => _ChamadaState();
}

class _ChamadaState extends State<Chamada> {
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

  Color getColor(Set<MaterialState> states) {
    Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.green;
  }

  bool ischeck = false;

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
        color: ischeck == true ? Colors.lightGreen[200] : Colors.white,
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
                        SizedBox(
                          height: 10,
                        ),
                        Text(cadastros[index].endereco ?? "",
                            style: TextStyle(fontSize: 11)),
                      ],
                    )),
                Column(
                  children: [
                    Visibility(
                      visible: ischeck,
                      child: Icon(Icons.check),
                    ),
                  ],
                )
              ],
            )),
      ),
      onTap: () {
        setState(() {
          if (ischeck == true) {
            ischeck = false;
          } else {
            ischeck = true;
          }
        });
      },
    );
  }
}
