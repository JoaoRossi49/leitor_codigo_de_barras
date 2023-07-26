class Item {
  final String codigo;
  final String descicao;
  final String quantidade;
  final String valorUnitario;

  const Item({
    required this.codigo,
    required this.descicao,
    required this.quantidade,
    required this.valorUnitario,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      codigo: json['codigo'],
      descicao: json['descricao'],
      quantidade: json['quantidade'],
      valorUnitario: json['valorUnitario']);

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'descricao': descicao,
        'quantidade': quantidade,
        'valorUnitario': valorUnitario
      };
}
