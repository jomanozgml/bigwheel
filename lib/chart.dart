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
          padding: const EdgeInsets.all(5),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
              children: List.generate(
                columnCount,
                (index) => Text('${differences[index]}, ', style: textStyle),
              ),
            ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 238,
          margin: const EdgeInsets.symmetric(horizontal: 15),
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
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

