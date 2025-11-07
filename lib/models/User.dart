class User {
  String? apelido;
  String? nome;
  String? sobrenome;
  String? email;
  String? senha;
  int? cidadeId;
  int? estadoId;

  User({this.apelido, this.nome, this.sobrenome, this.email, this.senha, this.estadoId, this.cidadeId});

  Map<String, dynamic> toJson() {
    return {
      "apelido": apelido,
      "nome": nome,
      "sobrenome": sobrenome,
      "email": email,
      "senha": senha,
      "estadoId": estadoId,
      "cidadeId": cidadeId
    };
  }
}
