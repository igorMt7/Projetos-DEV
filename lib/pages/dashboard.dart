import 'package:partilhe/app.router.dart';
import 'package:flutter/material.dart';
import 'package:partilhe/routes/rotas.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text('Boas Vindas!'),
      ), */
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            /* decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).accentColor,
            ), */
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset('images/partilhe3.png'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      AppRouter.gotoPush(nomeRota: rotaListaCadastros);
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(8),
                      height: 60,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            'Cadastros',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      AppRouter.gotoPush(nomeRota: rotaListaEventos);
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(8),
                      height: 60,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.event,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            'Eventos',
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      AppRouter.gotoPush(nomeRota: rotaListaProdutos);
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(8),
                      height: 60,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            'Produtos',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      AppRouter.gotoPush(nomeRota: rotaListaCadastros);
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(8),
                      height: 60,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.auto_stories_sharp,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            'Relatórios',
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
          ),

          /*     ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onSurface: Colors.green,
              elevation: 20,
              shadowColor: Colors.red,
            ),
            child: Text('RaisedButton Ativo'),
            onPressed: () {},
          ),
          SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onSurface: Colors.green,
              elevation: 20,
              shadowColor: Colors.red,
            ),
            child: Text('RaisedButton Inativo'),
            onPressed: null,
          ), */
          Container(
            /* decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).accentColor,
            ), */
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset('images/partilhebottom.png'),
            ),
          ),
          /*  SizedBox(height: 10), */
        ],
      ),
    );
  }
}
