import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partilhe/pages/produto/stores/produto_store.dart';

class ProdutoPage extends StatelessWidget {
  final ProdutoStore produto;

  ProdutoPage({this.produto});

  final _nomeFocus = FocusNode();
  final _descricaoFocus = FocusNode();
  final _quantidadeFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(produto.nome == '' ? "Novo Produto" : produto.nome),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await produto.salvar();
            Navigator.of(context).pop();
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
                          image: produto.imagem != null
                              ? FileImage(File(produto.imagem))
                              : AssetImage("images/produto.png")),
                    ),
                  ),
                  onTap: () {
                    ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((file) {
                      if (file == null) return;
                      produto.imagem = file.path;
                    });
                  },
                ),
                TextFormField(
                  initialValue: produto.nome,
                  maxLength: 24,
                  focusNode: _nomeFocus,
                  decoration: InputDecoration(labelText: "Nome do Produto"),
                  onChanged: (text) => produto.nome = text,
                ),
                TextFormField(
                  initialValue: produto.descricao,
                  focusNode: _descricaoFocus,
                  decoration: InputDecoration(labelText: "Descrição"),
                  onChanged: (text) => produto.descricao = text,
                ),
                TextFormField(
                  initialValue: produto.quantidade,
                  focusNode: _quantidadeFocus,
                  decoration: InputDecoration(labelText: "Quantidade atual"),
                  onChanged: (text) => produto.quantidade = text,
                  keyboardType: TextInputType.number,
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
