class Produto {
  final int? id;
  final String nome;
  final String descricao;
  final double preco;
  final DateTime? dataAtualizado;

  Produto({
    this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    this.dataAtualizado,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
  double parsePreco(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v.replaceAll(',', '.')) ?? 0.0;
    return 0.0;
  }

  return Produto(
    id: json['id'] is int ? json['id'] : (json['id'] != null ? int.parse('${json['id']}') : null),
    nome: json['nome'] ?? '',
    descricao: json['descricao'] ?? '',
    preco: parsePreco(json['preco']),   // 🔥 agora funciona com string ou número
    dataAtualizado: json['data_atualizado'] != null
        ? DateTime.tryParse(json['data_atualizado'])
        : null,
  );
}


  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'data_atualizado': dataAtualizado?.toIso8601String(),
    };
  }
}
