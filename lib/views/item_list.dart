import 'package:flutter/material.dart';
import 'package:leitor_codigo_de_barras/components/item_tile.dart';
import 'package:leitor_codigo_de_barras/models/Item.dart';
import 'package:leitor_codigo_de_barras/data/DatabaseHelper.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key});

  @override
  _ItemListState createState() => _ItemListState();
}

Future<List<Item>?> items() async {
  return DatabaseHelper.getAllItem();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Item List App',
      home: ItemListScreen(),
      // Add more routes if needed
    );
  }
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({Key? key});

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  Future<List<Item>?> items() async {
    return DatabaseHelper.getAllItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 113, 204),
        title: Text('Produtos cadastrados'),
      ),
      body: FutureBuilder<List<Item>?>(
        future: items(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data'),
            );
          } else {
            final List<Item> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemTile(
                  item: items[index],
                  onTap: () async {
                    print('tapou');
                  },
                  onLongPress: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                'Tem certeza que gostaria de deletar esse item?'),
                            actions: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () async {
                                  await DatabaseHelper.deleteItem(
                                      snapshot.data![index]);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('No'),
                              ),
                            ],
                          );
                        });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
