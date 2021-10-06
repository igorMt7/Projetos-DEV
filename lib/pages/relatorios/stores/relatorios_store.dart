import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
part 'relatorios_store.g.dart';

class RelatoriosStore = _RelatoriosStoreBase with _$RelatoriosStore;

abstract class _RelatoriosStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();

  Future maiorFrequencia() async {}
}
