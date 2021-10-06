import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/app.router.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/helpers/value_objects/bool_value_object.dart';
import 'package:partilhe/models/cadastro.dart';
import 'package:partilhe/pages/cadastro/stores/cadastro_store.dart';
import 'package:partilhe/routes/rotas.dart';
part 'cadastros_store.g.dart';

class CadastrosStore = _CadastrosStoreBase with _$CadastrosStore;

abstract class _CadastrosStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();

  _CadastrosStoreBase() {
    iniciar();
  }

  @observable
  ObservableList<CadastroStore> cadastros = ObservableList<CadastroStore>();

  @action
  Future<List<Cadastro>> iniciar() async {
    cadastros = ObservableList<CadastroStore>();

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
    int index = cadastros.indexWhere((e) => e.cpf == cadastro.cpf);
    if (index < 0) {
      index = 0;
    } else {
      cadastros.removeAt(index);
    }

    cadastros.insert(index, cadastro);
  }

  @action
  Future deletar(String cpf) async {
    if (cpf != null) {
      final response = await _db.deleteCadastro(cpf);
      if (response == 1) cadastros.removeWhere((e) => e.cpf == cpf);
    }
  }

  @action
  novo() {
    AppRouter.gotoParams(
      nomeRota: rotaCadastro,
      parametros: CadastroStore(
        nome: '',
        email: '',
        endereco: '',
        imagem: null,
        telefone: '',
        veste: '',
        cpf: '',
        dependentes: '',
        empregoFixo: BoolValueObject.fromBool(false),
      ),
    );
  }
}
