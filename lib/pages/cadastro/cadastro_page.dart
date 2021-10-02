import 'dart:io';

import 'package:partilhe/helpers/verifica_nulo_vazio.dart';
import 'package:partilhe/models/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partilhe/pages/cadastro/store/cadastro_store.dart';

class CadastroPage extends StatefulWidget {
  final CadastroStore cadastro;

  CadastroPage({this.cadastro});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // final _nomeController = TextEditingController();
  // final _enderecoController = TextEditingController();
  // final _telefoneController = TextEditingController();
  // final _vesteController = TextEditingController();
  // final _emailController = TextEditingController();
  final _nomeFocus = FocusNode();
  final _enderecoFocus = FocusNode();
  final _telefoneFocus = FocusNode();
  final _vesteFocus = FocusNode();
  final _emailFocus = FocusNode();

  // Cadastro _editaCadastro;

  @override
  void initState() {
    super.initState();

    // if (widget.cadastro == null) {
    //   _editaCadastro = Cadastro('', '', '', '', '', null);
    // } else {
    //   _editaCadastro = Cadastro.fromMap(widget.cadastro.toModel().toMap());

    //   // _nomeController.text = _editaCadastro.nome;
    //   // _enderecoController.text = _editaCadastro.endereco;
    //   // _telefoneController.text = _editaCadastro.telefone;
    //   // _vesteController.text = _editaCadastro.veste;
    //   // _emailController.text = _editaCadastro.email;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.cadastro.nome == ''
              ? "Novo Cadastro"
              : widget.cadastro.nome),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!VerificaNuloVazio.ehNuloOuVazio(widget.cadastro.nome) &&
                widget.cadastro.nome.length < 25) {
              await widget.cadastro.salvar();
              Navigator.pop(context);
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
                          image: widget.cadastro.imagem != null
                              ? FileImage(File(widget.cadastro.imagem))
                              : AssetImage("images/cadastro.png")),
                    ),
                  ),
                  onTap: () {
                    ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((file) {
                      if (file == null) return;
                      widget.cadastro.imagem = file.path;
                    });
                  },
                ),
                TextFormField(
                  initialValue: widget.cadastro.nome,
                  focusNode: _nomeFocus,
                  decoration: InputDecoration(labelText: "Nome"),
                  onChanged: (value) => widget.cadastro.nome = value,
                ),
                TextFormField(
                  initialValue: widget.cadastro.endereco,
                  focusNode: _enderecoFocus,
                  decoration: InputDecoration(labelText: "Endereço"),
                  onChanged: (value) => widget.cadastro.endereco = value,
                ),
                TextFormField(
                  initialValue: widget.cadastro.telefone,
                  focusNode: _telefoneFocus,
                  decoration: InputDecoration(labelText: "Telefone/WhatsApp"),
                  onChanged: (value) => widget.cadastro.telefone = value,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  initialValue: widget.cadastro.veste,
                  focusNode: _vesteFocus,
                  decoration:
                      InputDecoration(labelText: "Número ou tamanho da roupa:"),
                  onChanged: (value) => widget.cadastro.veste = value,
                ),
                TextFormField(
                  initialValue: widget.cadastro.email,
                  focusNode: _emailFocus,
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (value) => widget.cadastro.email = value,
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
