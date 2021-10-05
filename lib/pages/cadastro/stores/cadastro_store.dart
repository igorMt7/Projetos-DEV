import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/helpers/value_objects/bool_value_object.dart';
import 'package:partilhe/models/cadastro.dart';
import 'package:partilhe/pages/cadastro/stores/cadastros_store.dart';
part 'cadastro_store.g.dart';

CadastroStore cadastroStoreFromModel(Cadastro model) => CadastroStore(
      nome: model.nome,
      endereco: model.endereco,
      telefone: model.telefone,
      veste: model.veste,
      email: model.email,
      imagem: model.imagem,
      cpf: model.cpf,
      dependentes: model.dependentes,
      empregoFixo: model.empregoFixo,
    );

class CadastroStore = _CadastroStoreBase with _$CadastroStore;

abstract class _CadastroStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();

  _CadastroStoreBase({
    this.nome,
    this.endereco,
    this.telefone,
    this.veste,
    this.email,
    this.imagem,
    this.cpf,
    this.dependentes,
    this.empregoFixo,
  });

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

  @observable
  String cpf;

  @observable
  String dependentes;

  @observable
  BoolValueObject empregoFixo;

  @observable
  bool isChecked = false;

  @action
  Future<bool> salvar() async {
    if (cpf.length < 11) return false;

    await _db.mergeCadastro(this.toModel());
    GetIt.I.get<CadastrosStore>().atualizarLista(this);
    return true;
  }

  @action
  check() {
    if (isChecked)
      isChecked = false;
    else
      isChecked = true;

    GetIt.I.get<CadastrosStore>().atualizarLista(this);
  }

  Cadastro toModel() => Cadastro(
        nome,
        endereco,
        telefone,
        veste,
        email,
        imagem,
        cpf,
        dependentes,
        empregoFixo,
      );
}
