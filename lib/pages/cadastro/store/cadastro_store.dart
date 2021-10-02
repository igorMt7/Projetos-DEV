import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/cadastro.dart';
part 'cadastro_store.g.dart';

CadastroStore cadastroStoreFromModel(Cadastro model) => CadastroStore(
      nome: model.nome,
      endereco: model.endereco,
      telefone: model.telefone,
      veste: model.veste,
      email: model.email,
      imagem: model.imagem,
    );

class CadastroStore = _CadastroStoreBase with _$CadastroStore;

abstract class _CadastroStoreBase with Store {
  DatabaseHelper db = DatabaseHelper();

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
  Future salvar() async {
    final response = await db.insertCadastro(this.toModel());
  }

  toModel() => Cadastro(nome, endereco, telefone, veste, email, imagem);

  novo() => CadastroStore(
        nome: '',
        email: '',
        endereco: '',
        imagem: null,
        telefone: '',
        veste: '',
      );
}
