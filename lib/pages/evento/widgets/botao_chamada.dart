import 'package:flutter/material.dart';
import 'package:partilhe/app.router.dart';
import 'package:partilhe/pages/evento/stores/evento_store.dart';
import 'package:partilhe/routes/rotas.dart';

class BotaoChamada extends StatelessWidget {
  final EventoStore evento;

  const BotaoChamada(this.evento);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: evento.id != null && evento.id > 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          child: InkWell(
            onTap: () {
              AppRouter.gotoParams(
                nomeRota: rotaChamada,
                parametros: evento.id,
              );
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
    );
  }
}
