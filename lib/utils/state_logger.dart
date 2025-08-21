import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/state_history_provider.dart';

class StateLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (provider == stateHistoryNotifier) return;

    final change = StateChange(
      providerName: provider.name ?? provider.runtimeType.toString(),
      oldState: previousValue,
      newState: newValue,
      timestamp: DateTime.now(),
    );

    container.read(stateHistoryNotifier.notifier).addChange(change);

    print('Provider updated: ${provider.name ?? provider.runtimeType}');
    print('Previous: $previousValue');
    print('New: $newValue');
    print('---');
  }
}
