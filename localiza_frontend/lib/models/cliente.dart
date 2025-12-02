class Cliente {
  final int? id;
  final String nome;
  final String sobrenome;
  final String email;
  final int idade;
  final String? foto;

  Cliente({
    this.id,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.idade,
    this.foto,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] is int ? json['id'] : (json['id'] != null ? int.parse('${json['id']}') : null),
      nome: json['nome'] ?? '',
      sobrenome: json['sobrenome'] ?? '',
      email: json['email'] ?? '',
      idade: json['idade'] != null ? (json['idade'] as num).toInt() : 0,
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'idade': idade,
      'foto': foto,
    };
  }
}
