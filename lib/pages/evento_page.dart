import 'dart:io';

import 'package:partilhe/helpers/value_objects/bool_value_object.dart';
import 'package:partilhe/helpers/value_objects/datetime_value_object.dart';
import 'package:partilhe/models/evento.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partilhe/pages/chamada_lista.dart';

class EventoPage extends StatefulWidget {
  final Evento evento;
  EventoPage({this.evento});

  @override
  _EventoPageState createState() => _EventoPageState();
}

class _EventoPageState extends State<EventoPage> {
  final _nomeController = TextEditingController();
  final _responsavelController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _nomeFocus = FocusNode();
  final _responsavelFocus = FocusNode();
  final _descricaoFocus = FocusNode();

  bool editado = false;
  Evento _editaEvento;

  @override
  void initState() {
    super.initState();

    if (widget.evento == null) {
      _editaEvento = Evento(
        nome: '',
        responsavel: '',
        descricao: '',
        data: DateTimeValueObject.now(),
        imagem: null,
        ativo: BoolValueObject.fromBool(true),
      );
    } else {
      _editaEvento = Evento.fromMap(widget.evento.toMap());

      _nomeController.text = _editaEvento.nome;
      _responsavelController.text = _editaEvento.responsavel;
      _descricaoController.text = _editaEvento.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title:
              Text(_editaEvento.nome == '' ? "Novo Evento" : _editaEvento.nome),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editaEvento.nome != null &&
                _editaEvento.nome.isNotEmpty &&
                _editaEvento.nome.length < 25) {
              Navigator.pop(context, _editaEvento);
            } else {
              _exibeAviso();
              FocusScope.of(context).requestFocus(_nomeFocus);
            }
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
                          image: _editaEvento.imagem != null
                              ? FileImage(File(_editaEvento.imagem))
                              : AssetImage("images/evento.png")),
                    ),
                  ),
                  onTap: () {
                    ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((file) {
                      if (file == null) return;
                      setState(() {
                        _editaEvento.imagem = file.path;
                      });
                    });
                  },
                ),
                TextField(
                  controller: _nomeController,
                  focusNode: _nomeFocus,
                  decoration: InputDecoration(labelText: "Nome"),
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _editaEvento.nome = text;
                    });
                  },
                ),
                TextField(
                  controller: _responsavelController,
                  focusNode: _responsavelFocus,
                  decoration: InputDecoration(labelText: "Nome do Responsável"),
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _editaEvento.responsavel = text;
                    });
                  },
                ),
                TextField(
                  controller: _descricaoController,
                  focusNode: _descricaoFocus,
                  decoration: InputDecoration(labelText: "Descrição"),
                  onChanged: (text) {
                    editado = true;
                    setState(
                      () {
                        _editaEvento.descricao = text;
                      },
                    );
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate:
                            _editaEvento.data?.toDateTime ?? DateTime.now(),
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
                        if (value != null &&
                            _editaEvento.data?.toDateTime != value) {
                          setState(() {
                            _editaEvento.data = DateTimeValueObject.fromDate(
                                value,
                                withoutTime: true);
                          });
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
                              Text(_editaEvento.data?.toShortStringDateTime ??
                                  'Data não definida'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Chamada()));
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
                            Icon(Icons.task_alt, color: Colors.white, size: 24),
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
              ],
            )));
  }

  void _exibeAviso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Problemas com o NOME:"),
          content: new Text("Informe um nome válido menor que 25 letras"),
          actions: <Widget>[
            new FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).accentColor,
              label: new Text(
                "Fechar",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
