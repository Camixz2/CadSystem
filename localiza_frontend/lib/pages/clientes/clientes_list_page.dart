import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cliente_provider.dart';
import '../../widgets/common_widgets.dart';
import 'cliente_form_page.dart';

class ClientesListPage extends StatefulWidget {
  const ClientesListPage({super.key});
  @override
  State<ClientesListPage> createState() => _ClientesListPageState();
}

class _ClientesListPageState extends State<ClientesListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClienteProvider>(context, listen: false).loadClientes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ClienteProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body: prov.loading
          ? loadingWidget()
          : prov.error != null
              ? errorWidget(prov.error!)
              : prov.clientes.isEmpty
                  ? emptyWidget('Nenhum cliente cadastrado')
                  : ListView.builder(
                      itemCount: prov.clientes.length,
                      itemBuilder: (context, i) {
                        final c = prov.clientes[i];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  c.foto != null ? NetworkImage(c.foto!) : null,
                              child: c.foto == null ? const Icon(Icons.person) : null,
                            ),
                            title: Text('${c.nome} ${c.sobrenome}'),
                            subtitle: Text('${c.email}\nIdade: ${c.idade}'),
                            isThreeLine: true,
                            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ClienteFormPage(cliente: c),
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
                                                const Text('Remover este cliente?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, false),
                                                  child: const Text('Não')),
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, true),
                                                  child: const Text('Sim')),
                                            ],
                                          ));
                                  if (ok == true) {
                                    final success = await prov.deleteCliente(c.id!);
                                    final snack = success
                                        ? 'Cliente removido'
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
          MaterialPageRoute(builder: (_) => const ClienteFormPage()),
        ),
      ),
    );
  }
}
