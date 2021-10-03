import 'package:get_it/get_it.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';
import 'package:partilhe/pages/produto/stores/produtos_store.dart';

class DependencyInjection {
  final GetIt locator;

  DependencyInjection(this.locator) {
    locator.registerLazySingleton(() => CadastrosStore());
    locator.registerLazySingleton(() => ProdutosStore());
  }
}
