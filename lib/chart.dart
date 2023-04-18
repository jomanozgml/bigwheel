import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home.dart';

List positions = [];
List differences = [];

class ChartPage extends ConsumerWidget {
  final int position;
  final int difference;
  const ChartPage(this.position, this.difference, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int columnCount = ref.watch(columnCountProvider);
    // final Color color = ref.watch(colorProvider);
    if (columnCount > positions.length){
      positions.add(position);
      if (difference.abs() > 27){
        differences.add(difference.abs()-53);
        } else {
          differences.add(difference);
        }
    }
    return Column(
      children: [
        Container(
          width: 400,
          height: 25,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                columnCount,
                (index) => Row(
                  children: [
                    Text(differences[index].toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Text(', '),
                  ],
                ),
              ),
            ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 400,
          height: 238,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 5,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 216,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text('54'), Text('41'), Text('27'), Text('14'), Text('0')],
                ),
              ),
              const VerticalDivider( width: 10, thickness: 5, color: Colors.black),
              Row(
                children: List.generate(
                  columnCount,
                  (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(positions[index].toString()),
                      Container(
                        width: 10,
                        height: positions[index] * 4,
                        // color: color,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                      ),
                    ],
                  ),
                ),
                // children: [
                  // Text(position.toString()),
                  // Container(
                  //   width: 10,
                  //   height: position * 4,
                  //   color: color,
                  //   margin: const EdgeInsets.symmetric(horizontal: 5),
                  // ),
                // ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

