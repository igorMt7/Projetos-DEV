import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partilhe/helpers/value_objects/bool_value_object.dart';
import 'package:partilhe/pages/cadastro/stores/cadastro_store.dart';

class CadastroPage extends StatelessWidget {
  final CadastroStore cadastro;

  CadastroPage({this.cadastro});

  @override
  Widget build(BuildContext context) {
    final _sizes = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(cadastro.nome == '' ? "Novo Cadastro" : cadastro.nome),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final response = await cadastro.salvar();
            if (!response) {
              final snackBar = SnackBar(
                content: const Text('É necessário informar o CPF!'),
                backgroundColor: Colors.red.withOpacity(.7),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              Navigator.pop(context);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                child: Observer(builder: (_) {
                  return Container(
                    width: 100.0,
                    height: 128.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: cadastro.imagem != null
                              ? FileImage(File(cadastro.imagem))
                              : AssetImage("images/cadastro.png")),
                    ),
                  );
                }),
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
                maxLength: 24,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (value) => cadastro.nome = value,
              ),
              TextFormField(
                initialValue: cadastro.cpf,
                maxLength: 11,
                decoration: InputDecoration(labelText: "CPF"),
                onChanged: (value) => cadastro.cpf = value,
              ),
              TextFormField(
                initialValue: cadastro.endereco,
                decoration: InputDecoration(labelText: "Endereço"),
                onChanged: (value) => cadastro.endereco = value,
              ),
              TextFormField(
                initialValue: cadastro.telefone,
                decoration: InputDecoration(labelText: "Telefone/WhatsApp"),
                onChanged: (value) => cadastro.telefone = value,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                initialValue: cadastro.dependentes,
                decoration: InputDecoration(labelText: "Número de dependentes"),
                onChanged: (value) => cadastro.dependentes = value,
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text('Emprego fixo?'),
                    ),
                    Observer(builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: _sizes.width * .35,
                            child: CheckboxListTile(
                                title: const Text('Não'),
                                activeColor: Theme.of(context).primaryColor,
                                value: cadastro.empregoFixo.toBool == false,
                                onChanged: (value) {
                                  if (!cadastro.empregoFixo.toBool) return;
                                  cadastro.empregoFixo =
                                      BoolValueObject.fromBool(!value);
                                }),
                          ),
                          Container(
                            width: _sizes.width * .35,
                            child: CheckboxListTile(
                                title: const Text('Sim'),
                                activeColor: Theme.of(context).primaryColor,
                                value: cadastro.empregoFixo.toBool == true,
                                onChanged: (value) {
                                  if (cadastro.empregoFixo.toBool) return;
                                  cadastro.empregoFixo =
                                      BoolValueObject.fromBool(value);
                                }),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              TextFormField(
                initialValue: cadastro.veste,
                decoration:
                    InputDecoration(labelText: "Número ou tamanho da roupa"),
                onChanged: (value) => cadastro.veste = value,
              ),
              TextFormField(
                initialValue: cadastro.email,
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (value) => cadastro.email = value,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ));
  }
}
