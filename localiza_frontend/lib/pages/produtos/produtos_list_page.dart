import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/produto_provider.dart';
import '../../widgets/common_widgets.dart';
import 'produto_form_page.dart';

class ProdutosListPage extends StatefulWidget {
  const ProdutosListPage({super.key});
  @override
  State<ProdutosListPage> createState() => _ProdutosListPageState();
}

class _ProdutosListPageState extends State<ProdutosListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProdutoProvider>(context, listen: false).loadProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProdutoProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: prov.loading
          ? loadingWidget()
          : prov.error != null
              ? errorWidget(prov.error!)
              : prov.produtos.isEmpty
                  ? emptyWidget('Nenhum produto cadastrado')
                  : ListView.builder(
                      itemCount: prov.produtos.length,
                      itemBuilder: (context, i) {
                        final p = prov.produtos[i];
                        return Card(
                          child: ListTile(
                            title: Text(p.nome),
                            subtitle: Text('${p.descricao}\nR\$ ${p.preco.toStringAsFixed(2)}'),
                            isThreeLine: true,
                            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProdutoFormPage(produto: p),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  final ok = await showDialog<bool>(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Text('Confirmar'),
                                            content:
                                                const Text('Remover este produto?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => Navigator.pop(context, false),
                                                  child: const Text('Não')),
                                              TextButton(
                                                  onPressed: () => Navigator.pop(context, true),
                                                  child: const Text('Sim')),
                                            ],
                                          ));
                                  if (ok == true) {
                                    final success = await prov.deleteProduto(p.id!);
                                    final snack = success
                                        ? 'Produto removido'
                                        : 'Erro ao remover';
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(snack)));
                                  }
                                },
                              ),
                            ]),
                          ),
                        );
                      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProdutoFormPage()),
        ),
      ),
    );
  }
}
