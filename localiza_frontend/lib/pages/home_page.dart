import 'package:flutter/material.dart';
import 'clientes/clientes_list_page.dart';
import 'produtos/produtos_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CadSystem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.people),
              label: const Text('Clientes'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ClientesListPage()),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Produtos'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProdutosListPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
