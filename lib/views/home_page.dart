import 'dart:async';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:leitor_codigo_de_barras/models/Item.dart';
import 'dart:math';
import 'package:leitor_codigo_de_barras/views/item_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode = 'Aguardando..';
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.BARCODE);
      //Faz o Beep!
      FlutterBeep.beep();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Builder(builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [Text('Código escaneado: $_scanBarcode')],
                  ),
                  Flex(direction: Axis.horizontal, children: [
                    IconButton(
                        onPressed: () async {
                          await scanBarcodeNormal();
                          Random random = Random();
                          var id = Random().nextInt(999) +
                              DateTime.now().microsecond;
                          Navigator.of(context).pushNamed('/item_form',
                              arguments: Item(codigo: _scanBarcode, id: id));
                        },
                        icon: const Icon(
                          Icons.barcode_reader,
                          color: Color.fromARGB(255, 1, 113, 204),
                        ),
                        iconSize: 100)
                  ])
                ]),
          );
        })),
        routes: {
          '/item_form': (context) => const ItemForm(),
        });
  }
}
