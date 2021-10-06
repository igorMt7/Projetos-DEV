import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:partilhe/pages/cadastro/cadastro_lista.dart';
import 'package:partilhe/pages/cadastro/cadastro_page.dart';
import 'package:partilhe/pages/dashboard.dart';
import 'package:partilhe/pages/evento/chamada/chamada_lista.dart';
import 'package:partilhe/pages/evento/evento_lista.dart';
import 'package:partilhe/pages/evento/evento_page.dart';
import 'package:partilhe/pages/evento_finalizado/chamada/chamada_finalizada_lista.dart';
import 'package:partilhe/pages/evento_finalizado/evento_finalizado_page.dart';
import 'package:partilhe/pages/evento_finalizado/evento_finalizados_lista.dart';
import 'package:partilhe/pages/produto/produto_lista.dart';
import 'package:partilhe/pages/produto/produto_page.dart';
import 'package:partilhe/routes/rotas.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> chaveDeNavegacao =
      new GlobalKey<NavigatorState>();

  static gotoPush({@required String nomeRota}) {
    switch (nomeRota) {
      case rotaDashboard:
        chaveDeNavegacao.currentState
            .pushNamedAndRemoveUntil(nomeRota, (Route<dynamic> route) => false);
        break;
      case rotaListaCadastros:
        chaveDeNavegacao.currentState.pushNamed(nomeRota);
        break;
      case rotaCadastro:
        chaveDeNavegacao.currentState.pushNamed(nomeRota);
        break;
      case rotaListaEventos:
        chaveDeNavegacao.currentState.pushNamed(nomeRota);
        break;
      case rotaEvento:
        chaveDeNavegacao.currentState.pushNamed(nomeRota);
        break;
      case rotaListaProdutos:
        chaveDeNavegacao.currentState.pushNamed(nomeRota);
        break;
      case rotaProduto:
        chaveDeNavegacao.currentState.pushNamed(nomeRota);
        break;
      case rotaChamada:
        chaveDeNavegacao.currentState.pushNamed(nomeRota);
        break;
      default:
        chaveDeNavegacao.currentState.pushNamed(nomeRota);
        break;
    }
  }

  static gotoPop() {
    chaveDeNavegacao.currentState.pop();
  }

  static gotoPopAndPush({@required String nomeRota}) {
    chaveDeNavegacao.currentState.popAndPushNamed(nomeRota);
  }

  static gotoParams({@required String nomeRota, @required dynamic parametros}) {
    chaveDeNavegacao.currentState.pushNamed(nomeRota, arguments: parametros);
  }

  static Route<dynamic> gerarRotas(RouteSettings configuracoes) {
    switch (configuracoes.name) {
      case rotaDashboard:
        return MaterialPageRoute(
          builder: (_) => Dashboard(),
        );
      case rotaListaProdutos:
        return MaterialPageRoute(
          builder: (_) => ListaProdutos(),
        );
      case rotaProduto:
        return MaterialPageRoute(
          builder: (_) => ProdutoPage(produto: configuracoes.arguments),
        );
      case rotaListaCadastros:
        return MaterialPageRoute(
          builder: (_) => ListaAssistidos(),
        );
      case rotaCadastro:
        return MaterialPageRoute(
          builder: (_) => CadastroPage(cadastro: configuracoes.arguments),
        );
      case rotaListaEventos:
        return MaterialPageRoute(
          builder: (_) => ListaEventos(),
        );
      case rotaEvento:
        return MaterialPageRoute(
          builder: (_) => EventoPage(evento: configuracoes.arguments),
        );
      case rotaChamada:
        return MaterialPageRoute(
          builder: (_) => Chamada(idEvento: configuracoes.arguments),
        );
      case rotaEventosFinalizados:
        return MaterialPageRoute(
          builder: (_) => ListaEventosFinalizados(),
        );
      case rotaEventoFinalizado:
        return MaterialPageRoute(
          builder: (_) => EventoFinalizadoPage(evento: configuracoes.arguments),
        );
      case rotaChamadaFinalizada:
        return MaterialPageRoute(
          builder: (_) =>
              ChamadaEventoFinalizado(idEvento: configuracoes.arguments),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => _routeringError(configuracoes));
    }
  }

  static Scaffold _routeringError(RouteSettings settings) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No route defined for ${settings.name}'),
          TextButton(
              onPressed: () {
                AppRouter.gotoPush(nomeRota: rotaDashboard);
              },
              child: const Text('Voltar'))
        ],
      ),
    );
  }
}
