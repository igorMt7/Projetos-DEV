import 'dart:io';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/pages/evento/stores/evento_store.dart';
import 'package:partilhe/pages/evento_finalizado/widgets/botao_chamada.dart';

class EventoFinalizadoPage extends StatelessWidget {
  final EventoStore evento;
  EventoFinalizadoPage({this.evento});

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
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Observer(builder: (context) {
                    return Container(
                      width: 100.0,
                      height: 128.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: evento.imagem != null
                                ? FileImage(File(evento.imagem))
                                : AssetImage("images/evento.png")),
                      ),
                    );
                  }),
                  onTap: () {},
                ),
                TextFormField(
                  enabled: false,
                  initialValue: evento.nome,
                  focusNode: _nomeFocus,
                  decoration: InputDecoration(labelText: "Nome"),
                  onChanged: (text) => evento.nome = text,
                ),
                TextFormField(
                  enabled: false,
                  initialValue: evento.responsavel,
                  focusNode: _responsavelFocus,
                  decoration: InputDecoration(labelText: "Nome do Responsável"),
                  onChanged: (text) => evento.responsavel = text,
                ),
                TextFormField(
                  enabled: false,
                  initialValue: evento.descricao,
                  focusNode: _descricaoFocus,
                  decoration: InputDecoration(labelText: "Descrição"),
                  onChanged: (text) => evento.descricao = text,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {},
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
                BotaoChamada(evento),
              ],
            )));
  }
}
