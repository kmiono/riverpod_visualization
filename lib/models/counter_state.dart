class CounterState {
  final int value;
  final DateTime timestamp;
  final String action;

  const CounterState({
    required this.value,
    required this.timestamp,
    required this.action,
  });

  CounterState copyWith({int? value, DateTime? timestamp, String? action}) {
    return CounterState(
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
      action: action ?? this.action,
    );
  }
}
