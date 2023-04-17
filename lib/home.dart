import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chart.dart';
import 'counter.dart';
import 'dart:math';
// import 'package:firebase_storage/firebase_storage.dart';

// final storageRef = FirebaseStorage.instance.ref();
// final imageRef = storageRef.child('assets/images/bigWheel.png');

final rotationAngleProvider = StateProvider.autoDispose((ref) => 0.0);
final oldAngleProvider = StateProvider.autoDispose((ref) => 0.0);
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
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const Icon(Icons.arrow_downward_sharp, size: 30, color: Colors.teal),
            GestureDetector(
              onPanUpdate: (details) {
                double dx = details.delta.dx ;
                double dy = details.delta.dy ;
                double angle = atan2(dy, dx);
                double rotationDirection = 1.0;
                // if (dx > 0 || dy < 0) { rotationDirection = -1.0; }
                ref.read(rotationAngleProvider.notifier).state += angle * rotationDirection;
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
                    // imageRef.fullPath,
                    "assets/images/bigWheel.png",
                    width: 250,
                    height: 250,
                  ),
                )
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Position: '),
                Text(position.toStringAsFixed(0)),
                const SizedBox(width: 25),
                const Text('Difference: '),
                Text(((rotationAngle - oldAngle)/6.667).toStringAsFixed(0)),
              ],
            ),

            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                  child: const Text('Add to the Graph'),
                  onPressed: () {
                    ref.read(oldAngleProvider.notifier).state = rotationAngle;

                  },
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                  child: const Text('Go to Counter Page'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CounterPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            ChartPage(position.toInt()),
        ]),
      ),
    );
  }
}