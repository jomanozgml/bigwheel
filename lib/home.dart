import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chart.dart';
// import 'counter.dart';
import 'dart:math';

final rotationAngleProvider = StateProvider.autoDispose((ref) => 0.0);
final oldAngleProvider = StateProvider.autoDispose((ref) => 0.0);
final columnCountProvider = StateProvider.autoDispose((ref) => 0);
double position = 0.0;
double difference = 0.0;
const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 14);

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double rotationAngle = ref.watch(rotationAngleProvider);
    final double oldAngle = ref.watch(oldAngleProvider);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BIG WHEEL',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        toolbarHeight: 20,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            ChartPage(position.round() == 54 ? 0: position.round(), difference.round()),
            const SizedBox(height: 15),
            const Icon(Icons.arrow_downward_sharp, size: 30, color: Colors.white),
            GestureDetector(
              onPanUpdate: (details) {
                double dx = details.delta.dx ;
                double dy = details.delta.dy ;
                double angle = atan2(dy, dx);
                ref.read(rotationAngleProvider.notifier).state += angle *0.333;
                position = (rotationAngle/6.667 % 54);
                difference = ((rotationAngle - oldAngle)/6.667);
              },
              child: Transform.rotate(
                angle: rotationAngle * pi / 180,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.white12, blurRadius: 2)],
                  ),
                  child: Image.asset(
                    "assets/images/bigWheel.png",
                    width: 360,
                    height: 360,
                  ),
                )
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Position: ', style: textStyle),
                Text((position.round() == 54 ? 0: position.round()).toString(), style: textStyle),
                const SizedBox(width: 25),
                const Text('Difference: ', style: textStyle),
                Text(((rotationAngle-oldAngle)/6.667).round().toString(), style: textStyle),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                    child: const Text('Add to the Graph', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      ref.read(oldAngleProvider.notifier).state = rotationAngle;
                      ref.read(columnCountProvider.notifier).state++;
                    },
                  ),
            ),
            const SizedBox(height: 10),
            Slider(
              value: rotationAngle < 0 ? 360 + rotationAngle : rotationAngle > 360 ? rotationAngle - 360 : rotationAngle,
              min: 0,
              max: 360,
              divisions: 360,

              onChanged: (value) {
                ref.read(rotationAngleProvider.notifier).state = value;
                position = (rotationAngle/6.667 % 54);
                difference = ((rotationAngle - oldAngle)/6.667);
              },
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