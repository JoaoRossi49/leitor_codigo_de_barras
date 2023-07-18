import 'package:flutter/material.dart';
import 'package:leitor_codigo_de_barras/models/Item.dart';

class ItemForm extends StatelessWidget {
  const ItemForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    final Map<String, String> _formData = {};
    final Item item = ModalRoute.of(context)!.settings.arguments as Item;

    void _loadFormData(Item item) {
      if (item != null) {
        _formData['id'] = item.id.toString();
        _formData['codigo'] = item.codigo.toString();
      }
    }

    _loadFormData(item);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar novo item"),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(children: <Widget>[
            TextFormField(
              initialValue: _formData['codigo'],
              decoration: const InputDecoration(labelText: 'Código escaneado'),
            )
          ]),
        ),
      ),
    );
  }
}
