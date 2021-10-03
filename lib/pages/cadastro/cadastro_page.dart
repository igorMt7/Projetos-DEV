import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partilhe/pages/cadastro/stores/cadastro_store.dart';

class CadastroPage extends StatelessWidget {
  final CadastroStore cadastro;

  CadastroPage({this.cadastro});

  final _nomeFocus = FocusNode();
  final _enderecoFocus = FocusNode();
  final _telefoneFocus = FocusNode();
  final _vesteFocus = FocusNode();
  final _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(cadastro.nome == '' ? "Novo Cadastro" : cadastro.nome),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // if (!VerificaNuloVazio.ehNuloOuVazio(cadastro.nome) &&
            //     cadastro.nome.length < 25) {
            await cadastro.salvar();
            Navigator.pop(context);
            // } else {
            //   _exibeAviso();
            //   FocusScope.of(context).requestFocus(_nomeFocus);
            // }
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
                          image: cadastro.imagem != null
                              ? FileImage(File(cadastro.imagem))
                              : AssetImage("images/cadastro.png")),
                    ),
                  ),
                  onTap: () {
                    ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((file) {
                      if (file == null) return;
                      cadastro.imagem = file.path;
                    });
                  },
                ),
                TextFormField(
                  initialValue: cadastro.nome,
                  focusNode: _nomeFocus,
                  maxLength: 24,
                  decoration: InputDecoration(labelText: "Nome"),
                  onChanged: (value) => cadastro.nome = value,
                ),
                TextFormField(
                  initialValue: cadastro.endereco,
                  focusNode: _enderecoFocus,
                  decoration: InputDecoration(labelText: "Endereço"),
                  onChanged: (value) => cadastro.endereco = value,
                ),
                TextFormField(
                  initialValue: cadastro.telefone,
                  focusNode: _telefoneFocus,
                  decoration: InputDecoration(labelText: "Telefone/WhatsApp"),
                  onChanged: (value) => cadastro.telefone = value,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  initialValue: cadastro.veste,
                  focusNode: _vesteFocus,
                  decoration:
                      InputDecoration(labelText: "Número ou tamanho da roupa:"),
                  onChanged: (value) => cadastro.veste = value,
                ),
                TextFormField(
                  initialValue: cadastro.email,
                  focusNode: _emailFocus,
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (value) => cadastro.email = value,
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            )));
  }

  // void _exibeAviso() {
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
