import 'package:flutter/material.dart';
import 'package:partilhe/app.router.dart';
import 'package:partilhe/pages/evento/stores/evento_store.dart';

class BotaoFinalizarEvento extends StatelessWidget {
  final EventoStore evento;

  const BotaoFinalizarEvento(this.evento);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: evento.id != null && evento.id > 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return SimpleDialog(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: const Text('Confirmar ação'),
                      children: [
                        const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Deseja realmente finalizar o evento?\nA operação não poderá ser revertida!'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Não')),
                            OutlinedButton(
                                onPressed: () async {
                                  await evento.finalizar(evento.id);
                                  AppRouter.gotoPop();
                                  AppRouter.gotoPop();
                                },
                                child: const Text('Sim')),
                          ],
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.green[600],
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
                    'Finalizar Evento',
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
    );
  }
}
