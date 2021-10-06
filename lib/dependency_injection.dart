import 'package:get_it/get_it.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';
import 'package:partilhe/pages/evento/chamada/stores/chamada_store.dart';
import 'package:partilhe/pages/evento/stores/eventos_store.dart';
import 'package:partilhe/pages/evento_finalizado/stores/eventos_finalizados_store.dart';
import 'package:partilhe/pages/produto/stores/produtos_store.dart';

class DependencyInjection {
  final GetIt locator;

  DependencyInjection(this.locator) {
    locator.registerLazySingleton(() => DatabaseHelper());

    locator.registerLazySingleton(() => CadastrosStore());
    locator.registerLazySingleton(() => ProdutosStore());
    locator.registerLazySingleton(() => EventosStore());
    locator.registerLazySingleton(() => ChamadaStore());
    locator.registerLazySingleton(() => EventosFinalizadosStore());
  }
}
