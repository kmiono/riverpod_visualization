import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/state_history_provider.dart';

class StateVisualizer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(stateHistoryNotifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'State Changes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    ref.read(stateHistoryNotifier.notifier).clearHistory();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 300,
              child: history.isEmpty
                  ? Center(child: Text('No state changes yet'))
                  : ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        final change = history[index];
                        return Card(
                          color: Colors.grey[50],
                          child: ListTile(
                            title: Text(change.providerName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Old: ${_formatState(change.oldState)}'),
                                Text('New: ${_formatState(change.newState)}'),
                                Text(
                                  'Time: ${change.timestamp.toLocal().toString().split('.')[0]}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatState(dynamic state) {
    if (state == null) return 'null';
    if (state is List) return 'List(${state.length})';
    if (state is Map) return 'List(${state.length})';
    return state.toString().length > 50
        ? '${state.toString().substring(0, 50)}...'
        : state.toString();
  }
}
