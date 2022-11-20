import 'package:worker_manager/worker_manager.dart';

void mm() {
  final b = Executor().execute<int, dynamic, dynamic, dynamic, int, dynamic>(
    arg1: 1,
    fun1: (int a, TypeSendPort<dynamic> b) {
      return a * 2;
    },
  );

  b.then((value) => print(value));
}
