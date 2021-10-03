import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/cadastro.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';
part 'cadastro_store.g.dart';

CadastroStore cadastroStoreFromModel(Cadastro model) => CadastroStore(
      id: model.id,
      nome: model.nome,
      endereco: model.endereco,
      telefone: model.telefone,
      veste: model.veste,
      email: model.email,
      imagem: model.imagem,
    );

class CadastroStore = _CadastroStoreBase with _$CadastroStore;

abstract class _CadastroStoreBase with Store {
  DatabaseHelper _db = DatabaseHelper();

  _CadastroStoreBase({
    this.id,
    this.nome,
    this.endereco,
    this.telefone,
    this.veste,
    this.email,
    this.imagem,
  });

  @observable
  int id;

  @observable
  String nome;

  @observable
  String endereco;

  @observable
  String telefone;

  @observable
  String veste;

  @observable
  String email;

  @observable
  String imagem;

  @action
  Future<void> salvar() async {
    if (id != null && id > 0) {
      await _db.updateCadastro(this.toModel());
    } else {
      final id = await _db.insertCadastro(this.toModel());
      this.id = id;
    }
    GetIt.I.get<CadastrosStore>().atualizarLista(this);
  }

  Cadastro toModel() =>
      Cadastro(nome, endereco, telefone, veste, email, imagem);
}
