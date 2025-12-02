import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cliente.dart';
import '../../providers/cliente_provider.dart';

class ClienteFormPage extends StatefulWidget {
  final Cliente? cliente;
  const ClienteFormPage({super.key, this.cliente});

  @override
  State<ClienteFormPage> createState() => _ClienteFormPageState();
}

class _ClienteFormPageState extends State<ClienteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomeCtrl;
  late TextEditingController sobrenomeCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController idadeCtrl;
  late TextEditingController fotoCtrl;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    nomeCtrl = TextEditingController(text: widget.cliente?.nome ?? '');
    sobrenomeCtrl = TextEditingController(text: widget.cliente?.sobrenome ?? '');
    emailCtrl = TextEditingController(text: widget.cliente?.email ?? '');
    idadeCtrl = TextEditingController(text: widget.cliente?.idade.toString() ?? '');
    fotoCtrl = TextEditingController(text: widget.cliente?.foto ?? '');
  }

  @override
  void dispose() {
    nomeCtrl.dispose();
    sobrenomeCtrl.dispose();
    emailCtrl.dispose();
    idadeCtrl.dispose();
    fotoCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => saving = true);
    final prov = Provider.of<ClienteProvider>(context, listen: false);
    final cliente = Cliente(
      id: widget.cliente?.id,
      nome: nomeCtrl.text.trim(),
      sobrenome: sobrenomeCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      idade: int.tryParse(idadeCtrl.text.trim()) ?? 0,
      foto: fotoCtrl.text.trim().isEmpty ? null : fotoCtrl.text.trim(),
    );
    bool ok;
    if (widget.cliente == null) {
      ok = await prov.addCliente(cliente);
    } else {
      ok = await prov.updateCliente(cliente.id!, cliente);
    }
    setState(() => saving = false);
    final msg = ok ? 'Salvo com sucesso' : 'Erro ao salvar';
    if (ok) Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.cliente != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar Cliente' : 'Novo Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              controller: nomeCtrl,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Obrigatório' : null,
            ),
            TextFormField(
              controller: sobrenomeCtrl,
              decoration: const InputDecoration(labelText: 'Sobrenome'),
            ),
            TextFormField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Obrigatório';
                final re = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                return re.hasMatch(v.trim()) ? null : 'Email inválido';
              },
            ),
            TextFormField(
              controller: idadeCtrl,
              decoration: const InputDecoration(labelText: 'Idade'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Obrigatório';
                final n = int.tryParse(v);
                if (n == null || n < 0) return 'Idade inválida';
                return null;
              },
            ),
            TextFormField(
              controller: fotoCtrl,
              decoration: const InputDecoration(labelText: 'Foto (URL)'),
            ),
            const SizedBox(height: 20),
            saving
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _save,
                    child: const Text('Salvar'),
                  )
          ]),
        ),
      ),
    );
  }
}
