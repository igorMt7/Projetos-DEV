import 'dart:io';

import 'package:partilhe/models/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadastroPage extends StatefulWidget {
  final Cadastro cadastro;
  CadastroPage({this.cadastro});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _vesteController = TextEditingController();
  final _emailController = TextEditingController();
  final _nomeFocus = FocusNode();
  final _enderecoFocus = FocusNode();
  final _telefoneFocus = FocusNode();
  final _vesteFocus = FocusNode();
  final _emailFocus = FocusNode();

  bool editado = false;
  Cadastro _editaCadastro;

  @override
  void initState() {
    super.initState();

    if (widget.cadastro == null) {
      _editaCadastro = Cadastro('', '', '', '', '', null);
    } else {
      _editaCadastro = Cadastro.fromMap(widget.cadastro.toMap());

      _nomeController.text = _editaCadastro.nome;
      _enderecoController.text = _editaCadastro.endereco;
      _telefoneController.text = _editaCadastro.telefone;
      _vesteController.text = _editaCadastro.veste;
      _emailController.text = _editaCadastro.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(_editaCadastro.nome == ''
              ? "Novo Cadastro"
              : _editaCadastro.nome),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editaCadastro.nome != null &&
                _editaCadastro.nome.isNotEmpty &&
                _editaCadastro.nome.length < 25) {
              Navigator.pop(context, _editaCadastro);
            } else {
              _exibeAviso();
              FocusScope.of(context).requestFocus(_nomeFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).accentColor,
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
                          image: _editaCadastro.imagem != null
                              ? FileImage(File(_editaCadastro.imagem))
                              : AssetImage("images/cadastro.png")),
                    ),
                  ),
                  onTap: () {
                    ImagePicker.pickImage(source: ImageSource.gallery)
                        .then((file) {
                      if (file == null) return;
                      setState(() {
                        _editaCadastro.imagem = file.path;
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
                      _editaCadastro.nome = text;
                    });
                  },
                ),
                TextField(
                  controller: _enderecoController,
                  focusNode: _enderecoFocus,
                  decoration: InputDecoration(labelText: "Endereço"),
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _editaCadastro.endereco = text;
                    });
                  },
                ),
                TextField(
                  controller: _telefoneController,
                  focusNode: _telefoneFocus,
                  decoration: InputDecoration(labelText: "Telefone/WhatsApp"),
                  onChanged: (text) {
                    editado = true;
                    setState(
                      () {
                        _editaCadastro.telefone = text;
                      },
                    );
                  },
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _vesteController,
                  focusNode: _vesteFocus,
                  decoration:
                      InputDecoration(labelText: "Número ou tamanho da roupa:"),
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _editaCadastro.veste = text;
                    });
                  },
                ),
                TextField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (text) {
                    editado = true;
                    _editaCadastro.email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
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
