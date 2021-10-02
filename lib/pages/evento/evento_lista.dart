import 'dart:io';

import 'package:partilhe/helpers/database/database_helper.dart';

import 'package:partilhe/models/evento.dart';

import 'package:partilhe/pages/evento/evento_page.dart';
import 'package:flutter/material.dart';

class ListaEventos extends StatefulWidget {
  @override
  _ListaEventos createState() => _ListaEventos();
}

class _ListaEventos extends State<ListaEventos> {
  DatabaseHelper db = DatabaseHelper();
  List<Evento> eventos = <Evento>[];

  @override
  void initState() {
    super.initState();

    _exibeTodosEventos();
  }

  void _exibeTodosEventos() {
    db.getEventos().then((lista) {
      setState(() {
        eventos = lista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          _exibeEventoPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).accentColor,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          return _listaEventos(context, index);
        },
      ),
    );
  }

  _listaEventos(BuildContext context, int index) {
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
                        image: eventos[index].imagem != null
                            ? FileImage(File(eventos[index].imagem))
                            : AssetImage("images/evento.png")),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(eventos[index].nome ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        Text(eventos[index].data?.toShortStringDateTime ?? "",
                            style: const TextStyle(fontSize: 17)),
                        Text(eventos[index].responsavel ?? "",
                            style: const TextStyle(fontSize: 11)),
                      ],
                    )),
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {
                    _confirmaExclusao(context, eventos[index].id, index);
                  },
                )
              ],
            )),
      ),
      onTap: () {
        _exibeEventoPage(evento: eventos[index]);
      },
    );
  }

  void _exibeEventoPage({Evento evento}) async {
    final eventoRecebido = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventoPage(evento: evento)),
    );

    if (eventoRecebido != null) {
      if (evento != null) {
        await db.updateEvento(eventoRecebido);
      } else {
        await db.insertEvento(eventoRecebido);
      }
      _exibeTodosEventos();
    }
  }

  void _confirmaExclusao(BuildContext context, int eventoid, index) {
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
              onPressed: () {
                setState(() {
                  eventos.removeAt(index);
                  db.deleteEvento(eventoid);
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