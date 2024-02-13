import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFC Reader/Writer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = 'Waiting for NFC tag...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Reader/Writer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _message,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanNFC,
        tooltip: 'Scan NFC',
        child: Icon(Icons.nfc),
      ),
    );
  }

  void _scanNFC() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      setState(() {
        _message = 'NFC Tag Found:\nType: ${tag.type}\nID: ${tag.id}';
      });
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    }
  }
}
