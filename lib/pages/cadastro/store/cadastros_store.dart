import 'package:mobx/mobx.dart';
import 'package:partilhe/app.router.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/cadastro.dart';
import 'package:partilhe/pages/cadastro/store/cadastro_store.dart';
import 'package:partilhe/routes/rotas.dart';
part 'cadastros_store.g.dart';

class CadastrosStore = _CadastrosStoreBase with _$CadastrosStore;

abstract class _CadastrosStoreBase with Store {
  DatabaseHelper _db = DatabaseHelper();

  _CadastrosStoreBase() {
    iniciar();
  }

  @observable
  ObservableList<CadastroStore> cadastros = ObservableList<CadastroStore>();

  @action
  Future<List<Cadastro>> iniciar() async {
    final response = await _db.getCadastros();
    if (response != null) {
      response.forEach((e) {
        cadastros.add(cadastroStoreFromModel(e));
      });
      return response;
    }
    return null;
  }

  @action
  atualizarLista(CadastroStore cadastro) {
    int index = cadastros.indexWhere((e) => e.id == cadastro.id);
    if (index < 0) {
      index = 0;
    } else {
      cadastros.removeAt(index);
    }

    cadastros.insert(index, cadastro);
  }

  @action
  Future deletar(int id) async {
    if (id != null || id > 0) {
      final response = await _db.deleteCadastro(id);
      if (response == 1) cadastros.removeWhere((e) => e.id == id);
    }
  }

  @action
  novo() {
    AppRouter.gotoParams(
      nomeRota: rotaCadastro,
      parametros: CadastroStore(
        id: null,
        nome: '',
        email: '',
        endereco: '',
        imagem: null,
        telefone: '',
        veste: '',
      ),
    );
  }
}
