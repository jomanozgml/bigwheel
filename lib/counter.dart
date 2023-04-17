import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider.autoDispose((ref) => 0);
class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counter = ref.watch(counterProvider);
    
    ref.listen(counterProvider, (previous, next) {
      if (next >= 9){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Warning'),
            content: const Text('Counter dangerously high. Consider resetting it.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Counter'),
          actions: [
          IconButton(onPressed: (){
            ref.invalidate(counterProvider);
            // ref.read(counterProvider.notifier).state = 0;
          }, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Center(
        child: Text(counter.toString(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}