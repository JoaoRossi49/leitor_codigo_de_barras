class Item {
  final int id;
  final String codigo;

  const Item({
    required this.id,
    required this.codigo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
    };
  }
}
