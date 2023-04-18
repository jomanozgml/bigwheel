import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chart.dart';
import 'counter.dart';
import 'dart:math';

final rotationAngleProvider = StateProvider.autoDispose((ref) => 0.0);
final oldAngleProvider = StateProvider.autoDispose((ref) => 0.0);
final columnCountProvider = StateProvider.autoDispose((ref) => 0);
// final colorProvider = StateProvider.autoDispose((ref) => Colors.teal);
double position = 0.0;
double difference = 0.0;

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double rotationAngle = ref.watch(rotationAngleProvider);
    final double oldAngle = ref.watch(oldAngleProvider);

    return Scaffold(
      backgroundColor: Color.lerp(Colors.teal, Colors.white, 0.9),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BIG WHEEL', style: TextStyle(color: Colors.white, fontSize: 14)),
        toolbarHeight: 20,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            ChartPage(position.round(), difference.round()),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                    child: const Text('Add to the Graph'),
                    onPressed: () {
                      ref.read(oldAngleProvider.notifier).state = rotationAngle;
                      ref.read(columnCountProvider.notifier).state++;
                      // ref.read(colorProvider.notifier).state = Colors.grey;
                    },
                  ),
            ),
            const Icon(Icons.arrow_downward_sharp, size: 30, color: Colors.black),
            GestureDetector(
              onPanUpdate: (details) {
                double dx = details.delta.dx ;
                double dy = details.delta.dy ;
                double angle = atan2(dy, dx);
                double rotationDirection = 1.0;
                // if (dx > 0 || dy < 0) { rotationDirection = -1.0; }
                ref.read(rotationAngleProvider.notifier).state += angle * rotationDirection *0.333;
                position = (rotationAngle/6.667 % 54);
                difference = ((rotationAngle - oldAngle)/6.667);
              },
              child: Transform.rotate(
                angle: rotationAngle * pi / 180,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
                  ),
                  child: Image.asset(
                    "assets/images/bigWheel.png",
                    width: 360,
                    height: 360,
                  ),
                )
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Position: '),
                Text((position.round() == 54 ? 0: position.round()).toString()),
                const SizedBox(width: 25),
                const Text('Difference: '),
                Text(((rotationAngle-oldAngle)/6.667).round().toString()),
              ],
            ),

            // const SizedBox(height: 15),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //       ),
            //       child: const Text('Add to the Graph'),
            //       onPressed: () {
            //         ref.read(oldAngleProvider.notifier).state = rotationAngle;
            //         ref.read(columnCountProvider.notifier).state++;
            //         // ref.read(colorProvider.notifier).state = Colors.grey;
            //       },
            //     ),
            //     const SizedBox(width: 15),
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //       ),
            //       child: const Text('Go to Counter Page'),
            //       onPressed: () {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //             builder: (context) => const CounterPage(),
            //           ),
            //         );
            //       },
            //     ),
            //   ],
            // ),
        ]),
      ),
    );
  }
}