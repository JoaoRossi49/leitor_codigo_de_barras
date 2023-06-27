import 'dart:async';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      print(barcodeScanRes);
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
        home: Scaffold(
            appBar: AppBar(
                title: const Text('Leitor de código de barras'),
                backgroundColor: Colors.blueGrey),
            body: Builder(builder: (BuildContext context) {
              return Container(
                alignment: Alignment.center,
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Código escaneado:\n $_scanBarcode\n',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 140,
                      ),
                      IconButton(
                          onPressed: () {
                            scanBarcodeNormal();
                          },
                          icon: const Icon(
                            Icons.barcode_reader,
                            color: Color.fromARGB(255, 1, 113, 204),
                          ),
                          iconSize: 100),
                      SizedBox(height: 50)
                    ]),
              );
            })));
  }
}
