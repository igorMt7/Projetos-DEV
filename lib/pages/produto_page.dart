import 'dart:io';

import 'package:partilhe/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProdutoPage extends StatefulWidget {
  final Produto produto;
  ProdutoPage({this.produto});

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _quantidadeController = TextEditingController();

  final _nomeFocus = FocusNode();
  final _descricaoFocus = FocusNode();
  final _quantidadeFocus = FocusNode();

  bool editado = false;
  Produto _editaProduto;

  @override
  void initState() {
    super.initState();

    if (widget.produto == null) {
      _editaProduto = Produto('', '', '', null);
    } else {
      _editaProduto = Produto.fromMap(widget.produto.toMap());

      _nomeController.text = _editaProduto.nome;
      _descricaoController.text = _editaProduto.descricao;
      _quantidadeController.text = _editaProduto.quantidade;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
              _editaProduto.nome == '' ? "Novo Produto" : _editaProduto.nome),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editaProduto.nome != null &&
                _editaProduto.nome.isNotEmpty &&
                _editaProduto.nome.length < 25) {
              Navigator.pop(context, _editaProduto);
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
                          image: _editaProduto.imagem != null
                              ? FileImage(File(_editaProduto.imagem))
                              : AssetImage("images/produto.png")),
                    ),
                  ),
                  onTap: () {
                    ImagePicker.pickImage(source: ImageSource.gallery)
                        .then((file) {
                      if (file == null) return;
                      setState(() {
                        _editaProduto.imagem = file.path;
                      });
                    });
                  },
                ),
                TextField(
                  controller: _nomeController,
                  focusNode: _nomeFocus,
                  decoration: InputDecoration(labelText: "Nome do Produto"),
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _editaProduto.nome = text;
                    });
                  },
                ),
                TextField(
                  controller: _descricaoController,
                  focusNode: _descricaoFocus,
                  decoration: InputDecoration(labelText: "Descrição"),
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _editaProduto.descricao = text;
                    });
                  },
                ),
                TextField(
                  controller: _quantidadeController,
                  focusNode: _quantidadeFocus,
                  decoration: InputDecoration(labelText: "Quantidade atual"),
                  onChanged: (text) {
                    editado = true;
                    setState(
                      () {
                        _editaProduto.quantidade = text;
                      },
                    );
                  },
                  keyboardType: TextInputType.number,
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
