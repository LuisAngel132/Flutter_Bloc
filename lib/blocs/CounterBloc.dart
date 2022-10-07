import 'dart:async';

class CounterBase {}

class IncrementCounter extends CounterBase {}

class ClearCounter extends CounterBase {}

class CounterBlock {
  int _count = 0;
  StreamController<CounterBase> _input = StreamController();
  StreamController<int> _output = StreamController();
  Stream<int> get counterStream => _output.stream;
  StreamSink<CounterBase> get sendEvent => _input.sink;
  CounterBlock() {
    _input.stream.listen(onEvent);
  }
  void dispose() {
    _input.close();
    _output.close();
  }

  void onEvent(CounterBase event) {
    if (event is IncrementCounter) {
      _count++;
    } else {
      _count = 0;
    }
    _output.add(_count);
  }
}
