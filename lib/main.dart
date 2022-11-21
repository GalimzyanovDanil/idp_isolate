import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_idp_isolate/model.dart';

const _path = 'assets/stations.json';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late final String dictionaryStr;

  Future<void> onUIThread() async {
    final length = await fetchData(dictionaryStr);
    setState(() {
      _counter = length;
    });
  }

  Future<void> onNewIsolate() async {
    final length = await compute(fetchData, dictionaryStr);
    setState(() {
      _counter = length;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    dictionaryStr = await rootBundle.loadString(_path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            const SizedBox(
              height: 150,
              width: 150,
              child: CircularProgressIndicator(),
            ),
            const Spacer(),
            Text('List length $_counter', style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 50),
            SafeArea(
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: onUIThread, child: const Text('On UI thread')),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _counter = 0;
                        });
                      },
                      child: const Text('Reset')),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: onNewIsolate,
                      child: const Text('On new isolate')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
