// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:isolate';

class IsolateManager {
  // Применить шаблон проектиррования "Шаблонный метод" или "Декроатор"
  // при необходимости создания нового изолята.
 
  IsolateManager() {
    _init();
  }
  bool _isSpawn = false;
  late final SendPort sendPort;
  var resultCompleter = Completer<Object>();
  final receivePort = ReceivePort('main');
  final completer = Completer<bool>();

  Future<void> doIt(Function fun) async {
    resultCompleter = Completer<Object>();
    if (!_isSpawn) await completer.future;
    sendPort.send(fun);
  }

  Future<Object> get result => resultCompleter.future;

  Future<void> _init() async {
    final portSub = receivePort.listen((message) {
      if (message is SendPort) {
        sendPort = message;
        completer.complete(true);
        return;
      }

      resultCompleter.complete(message);
      return;
    });

    final spawnIsolate =
        await Isolate.spawn(initAnotherIsolate, receivePort.sendPort);

    // Как решить проблему с зарждкой между ихолятами?
    completer.future.then((value) => _isSpawn = value);
  }
}

void initAnotherIsolate(SendPort port) {
  final receivePort = ReceivePort('spawn');

  port.send(receivePort.sendPort);

  receivePort.listen((message) {
    if (message is Function) {
      final result = message.call();
      port.send(result);
    }
  });
}
