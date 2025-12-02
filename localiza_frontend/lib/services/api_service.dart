import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/cliente.dart';
import '../models/produto.dart';

class ApiService {
  final String baseUrl = AppConstants.baseUrl;

  // ---------- CLIENTES ----------
  Future<List<Cliente>> fetchClientes() async {
    final res = await http.get(Uri.parse('$baseUrl/clientes'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Cliente.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar clientes: ${res.statusCode}');
    }
  }

  Future<Cliente> fetchCliente(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/clientes/$id'));
    if (res.statusCode == 200) {
      return Cliente.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Erro ao buscar cliente');
    }
  }

  Future<void> createCliente(Cliente c) async {
    final res = await http.post(
      Uri.parse('$baseUrl/clientes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(c.toJson()),
    );
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('Erro ao criar cliente: ${res.statusCode} ${res.body}');
    }
  }

  Future<void> updateCliente(int id, Cliente c) async {
    final res = await http.put(
      Uri.parse('$baseUrl/clientes/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(c.toJson()),
    );
    if (res.statusCode != 200) {
      throw Exception('Erro ao atualizar cliente: ${res.statusCode}');
    }
  }

  Future<void> deleteCliente(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/clientes/$id'));
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Erro ao deletar cliente: ${res.statusCode}');
    }
  }

  // ---------- PRODUTOS ----------
  Future<List<Produto>> fetchProdutos() async {
    final res = await http.get(Uri.parse('$baseUrl/produtos'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Produto.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar produtos');
    }
  }

  Future<Produto> fetchProduto(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/produtos/$id'));
    if (res.statusCode == 200) {
      return Produto.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Erro ao buscar produto');
    }
  }

  Future<void> createProduto(Produto p) async {
    final res = await http.post(
      Uri.parse('$baseUrl/produtos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(p.toJson()),
    );
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('Erro ao criar produto: ${res.statusCode}');
    }
  }

  Future<void> updateProduto(int id, Produto p) async {
    final res = await http.put(
      Uri.parse('$baseUrl/produtos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(p.toJson()),
    );
    if (res.statusCode != 200) {
      throw Exception('Erro ao atualizar produto: ${res.statusCode}');
    }
  }

  Future<void> deleteProduto(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/produtos/$id'));
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Erro ao deletar produto: ${res.statusCode}');
    }
  }
}
