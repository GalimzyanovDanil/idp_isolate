import 'package:flutter/material.dart';
import 'package:flutter_idp_isolate/data_source/local_station_data_source.dart';
import 'package:flutter_idp_isolate/data_source/remote_station_data_source.dart';
import 'package:flutter_idp_isolate/repository/implements/local_station_repository.dart';
import 'package:flutter_idp_isolate/repository/implements/remote_station_repository.dart';

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
  late final RemoteStationRepository remote;
  late final LocalStationRepository local;

  @override
  void initState() {
    final remoteSource = RemoteStationDataSource();
    remote = RemoteStationRepository(remoteSource);

    final localSource = LocalStationDataSource();
    local = LocalStationRepository(localSource);
    super.initState();
  }

  int _counter = 0;

  Future<void> onUIThreadRemote() async {
    final list = await remote.getAllOnMainIsolate();

    setState(() {
      _counter = list.length;
    });
  }

  Future<void> onNewIsolateRemote() async {
    final list = await remote.getAllOnNewIsolate();

    setState(() {
      _counter = list.length;
    });
  }

  Future<void> onUIThreadLocal() async {
    final list = await local.getAllOnMainIsolate();

    setState(() {
      _counter = list.length;
    });
  }

  Future<void> onNewIsolateLocal() async {
    final list = await local.getAllOnNewIsolate();

    setState(() {
      _counter = list.length;
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
              child: Column(
                children: [
                  const Text('Remote data fetch',
                      style: TextStyle(fontSize: 30)),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: onUIThreadRemote,
                        child: const Text('On UI thread'),
                      ),
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
                          onPressed: onNewIsolateRemote,
                          child: const Text('On new isolate')),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text('Local data fetch',
                      style: TextStyle(fontSize: 30)),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: onUIThreadLocal,
                        child: const Text('On UI thread'),
                      ),
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
                          onPressed: onNewIsolateLocal,
                          child: const Text('On new isolate')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
