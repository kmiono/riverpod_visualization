import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/counter_provider.dart';

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final isEven = ref.watch(isEvenProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Counter Demo', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16),
            Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              isEven ? 'Even' : 'Odd',
              style: TextStyle(
                color: isEven ? Colors.green : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      ref.read(counterProvider.notifier).decrement(),
                  child: Icon(Icons.remove),
                ),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(counterProvider.notifier).increment(),
                  child: Icon(Icons.add),
                ),
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider.notifier).reset(),
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Last action: ${counter.action}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
