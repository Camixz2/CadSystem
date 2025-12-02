import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/api_service.dart';

class ProdutoProvider with ChangeNotifier {
  final ApiService api = ApiService();
  List<Produto> produtos = [];
  bool loading = false;
  String? error;

  Future<void> loadProdutos() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      produtos = await api.fetchProdutos();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> addProduto(Produto p) async {
    try {
      await api.createProduto(p);
      await loadProdutos();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateProduto(int id, Produto p) async {
    try {
      await api.updateProduto(id, p);
      await loadProdutos();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteProduto(int id) async {
    try {
      await api.deleteProduto(id);
      await loadProdutos();
      return true;
    } catch (_) {
      return false;
    }
  }
}
