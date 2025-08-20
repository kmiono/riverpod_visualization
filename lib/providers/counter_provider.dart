import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/counter_state.dart';

class CounterNotifier extends StateNotifier<CounterState> {
  CounterNotifier()
    : super(
        CounterState(
          value: 0,
          timestamp: DateTime.now(),
          action: 'initialized',
        ),
      );

  void increment() {
    state = CounterState(
      value: state.value + 1,
      timestamp: DateTime.now(),
      action: 'increment',
    );
  }

  void decrement() {
    state = CounterState(
      value: state.value - 1,
      timestamp: DateTime.now(),
      action: 'decrement',
    );
  }

  void reset() {
    state = CounterState(value: 0, timestamp: DateTime.now(), action: 'reset');
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, CounterState>((
  ref,
) {
  return CounterNotifier();
});

final isEvenProvider = Provider<bool>((ref) {
  final counter = ref.watch(counterProvider);
  return counter.value % 2 == 0;
});
