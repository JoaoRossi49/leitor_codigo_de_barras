import 'package:flutter/material.dart';
import 'package:leitor_codigo_de_barras/models/Item.dart';
import 'package:leitor_codigo_de_barras/data/DatabaseHelper.dart';

class ItemForm extends StatelessWidget {
  const ItemForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    final Map<String, String> _formData = {};
    final Item item = ModalRoute.of(context)!.settings.arguments as Item;

    Future<List<Item>?>? conferir() async {
      return await DatabaseHelper.getItem(_formData['codigo']);
    }

    void _loadFormData(Item item) {
      Future<List<Item>?>? _conferencia = conferir();
      print(_conferencia);
      //if(_conferencia == null) {
      _formData['codigo'] = item.codigo;
      _formData['nomeProduto'] = item.descicao;
      _formData['quantidade'] = item.quantidade;
      _formData['valorUnitario'] = item.valorUnitario;
      //}
    }

    _loadFormData(item);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Cadastrar novo item"),
        backgroundColor: Color.fromARGB(255, 1, 113, 204),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                _form.currentState?.save();

                if (conferir() == null) {
                  await DatabaseHelper.addItem(
                    Item(
                        codigo: _formData['codigo'].toString(),
                        descicao: _formData['nomeProduto'].toString(),
                        quantidade: _formData['quantidade'].toString(),
                        valorUnitario: _formData['valorUnitario'].toString()),
                  );
                  Navigator.of(context).pop();
                } else {
                  await DatabaseHelper.updateItem(
                    Item(
                        codigo: _formData['codigo'].toString(),
                        descicao: _formData['nomeProduto'].toString(),
                        quantidade: _formData['quantidade'].toString(),
                        valorUnitario: _formData['valorUnitario'].toString()),
                  );
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Flex(
            direction: Axis.vertical,
            children: [
              SizedBox(height: 10),
              Container(
                child: Form(
                  key: _form,
                  child: Column(children: <Widget>[
                    TextFormField(
                        initialValue: _formData['codigo'],
                        decoration: const InputDecoration(
                            labelText: 'Código escaneado'),
                        onSaved: (value) => _formData['codigo'] = value!),
                    TextFormField(
                        initialValue: _formData['nomeProduto'],
                        decoration:
                            const InputDecoration(labelText: 'Nome do produto'),
                        onSaved: (value) => _formData['nomeProduto'] = value!),
                    TextFormField(
                        initialValue: _formData['quantidade'],
                        decoration: const InputDecoration(
                            labelText: 'Quantidade em estoque'),
                        onSaved: (value) => _formData['quantidade'] = value!),
                    TextFormField(
                        initialValue: _formData['valorUnitario'],
                        decoration:
                            const InputDecoration(labelText: 'Valor unitário'),
                        onSaved: (value) => _formData['valorUnitario'] = value!)
                  ]),
                ),
              ),
            ],
          )),
    );
  }
}
