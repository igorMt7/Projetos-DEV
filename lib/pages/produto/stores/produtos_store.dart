import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:partilhe/app.router.dart';
import 'package:partilhe/helpers/database/database_helper.dart';
import 'package:partilhe/models/produto.dart';
import 'package:partilhe/pages/produto/stores/produto_store.dart';
import 'package:partilhe/routes/rotas.dart';
part 'produtos_store.g.dart';

class ProdutosStore = _ProdutosStoreBase with _$ProdutosStore;

abstract class _ProdutosStoreBase with Store {
  final _db = GetIt.I<DatabaseHelper>();

  _ProdutosStoreBase() {
    iniciar();
  }

  @observable
  ObservableList<ProdutoStore> produtos = ObservableList<ProdutoStore>();

  @action
  Future<List<Produto>> iniciar() async {
    final response = await _db.getProdutos();
    if (response != null) {
      response.forEach((e) {
        produtos.add(produtoStoreFromModel(e));
      });
      return response;
    }
    return null;
  }

  @action
  atualizarLista(ProdutoStore produto) {
    int index = produtos.indexWhere((e) => e.id == produto.id);
    if (index < 0) {
      index = 0;
    } else {
      produtos.removeAt(index);
    }

    produtos.insert(index, produto);
  }

  @action
  Future deletar(int id) async {
    if (id != null || id > 0) {
      final response = await _db.deleteProduto(id);
      if (response == 1) produtos.removeWhere((e) => e.id == id);
    }
  }

  @action
  novo() {
    AppRouter.gotoParams(
      nomeRota: rotaProduto,
      parametros: ProdutoStore(
        id: null,
        nome: '',
        descricao: '',
        quantidade: '',
        imagem: null,
      ),
    );
  }
}
