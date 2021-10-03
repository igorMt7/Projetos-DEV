import 'package:get_it/get_it.dart';
import 'package:partilhe/pages/cadastro/store/cadastros_store.dart';

class DependencyInjection {
  final GetIt locator;

  DependencyInjection(this.locator) {
    locator.registerLazySingleton(() => CadastrosStore());
  }
}
