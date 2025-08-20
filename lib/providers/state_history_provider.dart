import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateChange {
  final String providerName;
  final dynamic oldState;
  final dynamic newState;
  final DateTime timestamp;

  StateChange({
    required this.providerName,
    required this.oldState,
    required this.newState,
    required this.timestamp,
  });
}

class StateHistoryNotifier extends StateNotifier<List<StateChange>> {
  StateHistoryNotifier() : super([]);

  void addChange(StateChange change) {
    state = [change, ...state];
    // 最新の50件のみ保持
    if (state.length > 50) {
      state = state.take(50).toList();
    }
  }

  void clearHistory() {
    state = [];
  }
}

final stateHistoryNotifier =
    StateNotifierProvider<StateHistoryNotifier, List<StateChange>>((ref) {
      return StateHistoryNotifier();
    });
