import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/produto.dart';
import 'package:partilhe/pages/produto/stores/produtos_store.dart';
part 'produto_store.g.dart';

ProdutoStore produtoStoreFromModel(Produto model) => ProdutoStore(
      id: model.id,
      nome: model.nome,
      descricao: model.descricao,
      quantidade: model.quantidade,
      imagem: model.imagem,
    );

class ProdutoStore = _ProdutoStoreBase with _$ProdutoStore;

abstract class _ProdutoStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();

  _ProdutoStoreBase({
    this.id,
    this.nome,
    this.descricao,
    this.quantidade,
    this.imagem,
  });

  @observable
  int id;

  @observable
  String nome;

  @observable
  String descricao;

  @observable
  String quantidade;

  @observable
  String imagem;

  @action
  Future<void> salvar() async {
    if (id != null && id > 0) {
      await _db.updateProduto(this.toModel());
    } else {
      final id = await _db.insertProduto(this.toModel());
      this.id = id;
    }
    GetIt.I.get<ProdutosStore>().atualizarLista(this);
  }

  Produto toModel() => Produto(nome, descricao, quantidade, imagem);
}
