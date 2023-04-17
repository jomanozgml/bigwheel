import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartPage extends ConsumerWidget {
  // const ChartPage(double position, {Key? key}) : super(key: key);
  final int position;

  // ignore: prefer_const_constructors_in_immutables
  ChartPage(this.position, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 400,
      height: 234,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text('54'), Text('41'), Text('27'), Text('14'), Text('0')],
          ),
          const VerticalDivider(
            width: 10,
            thickness: 5,
            color: Colors.black),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(position.toString()),
              Container(
                width: 10,
                height: position * 4,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

