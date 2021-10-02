import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/cadastro.dart';
import 'package:partilhe/pages/cadastro/store/cadastro_store.dart';
part 'cadastros_store.g.dart';

class CadastrosStore = _CadastrosStoreBase with _$CadastrosStore;

abstract class _CadastrosStoreBase with Store {
  DatabaseHelper db = DatabaseHelper();

  @observable
  ObservableList<CadastroStore> cadastros = ObservableList<CadastroStore>();

  @action
  Future<List<Cadastro>> iniciar() async {
    final response = await db.getCadastros();
    if (response != null) {
      response.forEach((e) {
        cadastros.add(cadastroStoreFromModel(e));
      });
      return response;
    }
    return null;
  }

  @action
  salvar() {}
}
