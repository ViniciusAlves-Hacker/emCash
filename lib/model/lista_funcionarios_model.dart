class ListaFuncionariosModel {
  String? id;
  String? nome;
  Null? cpf;
  String? cnpj;
  String? celular;
  String? email;

  ListaFuncionariosModel(
      {this.id, this.nome, this.cpf, this.cnpj, this.celular, this.email});

  ListaFuncionariosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cpf = json['cpf'];
    cnpj = json['cnpj'];
    celular = json['celular'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['cnpj'] = this.cnpj;
    data['celular'] = this.celular;
    data['email'] = this.email;
    return data;
  }
}