import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/produto.dart';
import '../../providers/produto_provider.dart';

class ProdutoFormPage extends StatefulWidget {
  final Produto? produto;
  const ProdutoFormPage({super.key, this.produto});

  @override
  State<ProdutoFormPage> createState() => _ProdutoFormPageState();
}

class _ProdutoFormPageState extends State<ProdutoFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomeCtrl;
  late TextEditingController descCtrl;
  late TextEditingController precoCtrl;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    nomeCtrl = TextEditingController(text: widget.produto?.nome ?? '');
    descCtrl = TextEditingController(text: widget.produto?.descricao ?? '');

    // CORREÇÃO DO ERRO
    String precoText = '';
    if (widget.produto?.preco != null) {
      try {
        precoText = widget.produto!.preco.toStringAsFixed(2);
      } catch (e) {
        precoText = widget.produto!.preco.toString();
      }
    }

    precoCtrl = TextEditingController(text: precoText);
  }

  @override
  void dispose() {
    nomeCtrl.dispose();
    descCtrl.dispose();
    precoCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => saving = true);

    final prov = Provider.of<ProdutoProvider>(context, listen: false);

    final precoParsed = double.tryParse(precoCtrl.text.replaceAll(',', '.')) ?? 0.0;

    final produto = Produto(
      id: widget.produto?.id,
      nome: nomeCtrl.text.trim(),
      descricao: descCtrl.text.trim(),
      preco: precoParsed,
      dataAtualizado: DateTime.now(),
    );

    bool ok;
    if (widget.produto == null) {
      ok = await prov.addProduto(produto);
    } else {
      ok = await prov.updateProduto(produto.id!, produto);
    }

    setState(() => saving = false);

    final msg = ok ? 'Salvo com sucesso' : 'Erro ao salvar';

    if (ok) Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.produto != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar Produto' : 'Novo Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomeCtrl,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Obrigatório' : null,
              ),
              TextFormField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextFormField(
                controller: precoCtrl,
                decoration:
                    const InputDecoration(labelText: 'Preço (ex: 1200.50)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Obrigatório';
                  final n = double.tryParse(v.replaceAll(',', '.'));
                  if (n == null || n < 0) return 'Preço inválido';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              saving
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _save, child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
