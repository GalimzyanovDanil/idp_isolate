import 'package:flutter/material.dart';
import 'package:flutter_idp_isolate/core/isolate_base.dart';

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

  late final IsolateManager isolateManager;

  @override
  void initState() {
    super.initState();

    isolateManager = IsolateManager();
    // mm();
  }

  void _incrementCounter() {
    setState(() {
      isolateManager.doIt(() => 5 + 5);
    });
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
            const SizedBox(
              height: 150,
              width: 150,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 50),
            const Text(
              'You have pushed the button this many times:',
            ),
            FutureBuilder<dynamic>(
                future: isolateManager.result,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
            TextButton(
                onPressed: () {
                  setState(() {
                    isolateManager.doIt(() => 50 + 50);
                  });
                },
                child: const Text('100')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
