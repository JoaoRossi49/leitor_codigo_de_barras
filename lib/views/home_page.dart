import 'dart:async';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:leitor_codigo_de_barras/models/Item.dart';
import 'package:leitor_codigo_de_barras/views/item_form.dart';
import 'package:leitor_codigo_de_barras/views/item_list.dart';
import 'package:leitor_codigo_de_barras/data/DatabaseHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode = '';
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes == '-1') {
        _scanBarcode = '';
      } else {
        FlutterBeep.beep();
        _scanBarcode = barcodeScanRes;
      }
    });
  }

  Future<List<Item>?>? conferir() async {
    return await DatabaseHelper.getItem(_scanBarcode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Builder(builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/barra_techLogo.png'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        Navigator.of(context)
                                            .pushNamed('/item_form',
                                                arguments: Item(
                                                  codigo: '',
                                                  descicao: '',
                                                  quantidade: '',
                                                  valorUnitario: '',
                                                ));
                                      },
                                      icon: const Icon(Icons.keyboard),
                                      color: const Color.fromARGB(
                                          255, 1, 113, 204),
                                      iconSize: 100,
                                    ),
                                    const Text("Digitar código")
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await scanBarcodeNormal();
                                          if (conferir() == null) {
                                            Navigator.of(context)
                                                .pushNamed('/item_form',
                                                    arguments: Item(
                                                      codigo: _scanBarcode,
                                                      descicao: '',
                                                      quantidade: '',
                                                      valorUnitario: '',
                                                    ));
                                          } else {
                                            List<Item> _conferencia =
                                                conferir() as List<Item>;
                                            Navigator.of(context).pushNamed(
                                                '/item_form',
                                                arguments: _conferencia[0]);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.barcode_reader,
                                          color:
                                              Color.fromARGB(255, 1, 113, 204),
                                        ),
                                        iconSize: 100),
                                    const Text("Escanear código")
                                  ],
                                ),
                                Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        Navigator.of(context)
                                            .pushNamed('/item_list');
                                      },
                                      icon: const Icon(Icons.list),
                                      color: const Color.fromARGB(
                                          255, 1, 113, 204),
                                      iconSize: 100,
                                    ),
                                    const Text("Items cadastrados")
                                  ],
                                ),
                              ]),
                        ]),
                  ),
                ],
              ),
            );
          }),
        ),
        routes: {
          '/item_form': (context) => const ItemForm(),
          '/item_list': (context) => const ItemList()
        });
  }
}
