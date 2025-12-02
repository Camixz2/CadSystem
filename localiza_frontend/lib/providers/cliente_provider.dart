import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../services/api_service.dart';


class ClienteProvider with ChangeNotifier {
  final ApiService api = ApiService();
  List<Cliente> clientes = [];
  bool loading = false;
  String? error;

  Future<void> loadClientes() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      clientes = await api.fetchClientes();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> addCliente(Cliente c) async {
    try {
      await api.createCliente(c);
      await loadClientes();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateCliente(int id, Cliente c) async {
    try {
      await api.updateCliente(id, c);
      await loadClientes();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteCliente(int id) async {
    try {
      await api.deleteCliente(id);
      await loadClientes();
      return true;
    } catch (_) {
      return false;
    }
  }
}
