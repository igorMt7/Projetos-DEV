import 'dart:io';

import 'package:partilhe/app.router.dart';
import 'package:partilhe/helpers/value_objects/datetime_value_object.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partilhe/pages/evento/stores/evento_store.dart';
import 'package:partilhe/routes/rotas.dart';

class EventoPage extends StatelessWidget {
  final EventoStore evento;
  EventoPage({this.evento});

  final _nomeFocus = FocusNode();
  final _responsavelFocus = FocusNode();
  final _descricaoFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(evento.nome == '' ? "Novo Evento" : evento.nome),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await evento.salvar();
            Navigator.pop(context, evento);
          },
          child: Icon(Icons.save),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 100.0,
                    height: 128.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: evento.imagem != null
                              ? FileImage(File(evento.imagem))
                              : AssetImage("images/evento.png")),
                    ),
                  ),
                  onTap: () {
                    ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((file) {
                      if (file == null) return;
                      evento.imagem = file.path;
                    });
                  },
                ),
                TextFormField(
                  initialValue: evento.nome,
                  focusNode: _nomeFocus,
                  decoration: InputDecoration(labelText: "Nome"),
                  onChanged: (text) => evento.nome = text,
                ),
                TextFormField(
                  initialValue: evento.responsavel,
                  focusNode: _responsavelFocus,
                  decoration: InputDecoration(labelText: "Nome do Responsável"),
                  onChanged: (text) => evento.responsavel = text,
                ),
                TextFormField(
                  initialValue: evento.descricao,
                  focusNode: _descricaoFocus,
                  decoration: InputDecoration(labelText: "Descrição"),
                  onChanged: (text) => evento.descricao = text,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: evento.data?.toDateTime ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                        fieldLabelText: 'Vencimento',
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.light(),
                            child: child,
                          );
                        },
                      ).then((value) {
                        if (value != null && evento.data?.toDateTime != value) {
                          evento.data = DateTimeValueObject.fromDate(value,
                              withoutTime: true);
                        }
                      });
                    },
                    child: Container(
                      width: screenSize.width * .5,
                      child: Card(
                        elevation: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_sharp,
                                    color: Colors.black87,
                                  ),
                                  Container(
                                    child: const Text('Data'),
                                    alignment: Alignment.centerLeft,
                                  ),
                                ],
                              ),
                              Text(evento.data?.toShortStringDateTime ??
                                  'Data não definida'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Visibility(
                  visible: evento.id != null && evento.id > 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          AppRouter.gotoPush(nomeRota: rotaChamada);
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          padding: EdgeInsets.all(8),
                          height: 45,
                          width: 220,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.task_alt,
                                  color: Colors.white, size: 24),
                              Text(
                                'Realizar Chamada',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  // void _exibeAviso(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: new Text("Problemas com o NOME:"),
  //         content: new Text("Informe um nome válido menor que 25 letras"),
  //         actions: <Widget>[
  //           new FloatingActionButton.extended(
  //             backgroundColor: Theme.of(context).primaryColor,
  //             foregroundColor: Theme.of(context).accentColor,
  //             label: new Text(
  //               "Fechar",
  //               style: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
