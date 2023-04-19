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
          width: double.infinity,
          height: 25,
          color: Colors.white12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                columnCount,
                (index) => Row(
                  children: [
                    Text(differences[index].toString(), style: textStyle),
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
                color: Colors.white,
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
                  children: const [Text('54', style: textStyle), Text('41', style: textStyle,),
                    Text('27', style:textStyle), Text('14', style: textStyle), Text('0', style: textStyle)],
                ),
              ),
              const VerticalDivider( width: 10, thickness: 5, color: Colors.white),
              Row(
                children: List.generate(
                  columnCount,
                  (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(positions[index].toString(), style: textStyle),
                      Container(
                        width: 10,
                        height: positions[index] * 4,
                        // color: color,
                        color: Colors.lightBlueAccent,
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

