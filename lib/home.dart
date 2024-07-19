import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'chart.dart';
import 'counter.dart';
import 'dart:math';

/// To run the program in prod environment, type in terminal
/// flutter run -d chrome --dart-define=FLAVOR=prod
/// For dev environment, flutter run -d chrome --dart-define=FLAVOR=dev
/// or simply 'flutter run' since default flavor is dev

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: HomePage()));
}

final rotationAngleProvider = StateProvider((ref) => 0.0);
final oldAngleProvider = StateProvider((ref) => 0.0);
final columnCountProvider = StateProvider((ref) => 0);
FirebaseFirestore firestore = FirebaseFirestore.instance;
DocumentReference spindataDocument = firestore.collection('logs').doc('spindata');
int position = 0;
int difference = 0;
bool isFirstSave = true;
bool isDataRetrieved = false;
const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 14);
List<int> positionList = [];
List<int> differenceList = [];

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double rotationAngle = ref.watch(rotationAngleProvider);
    final double oldAngle = ref.watch(oldAngleProvider);

    if(!isDataRetrieved){
      isDataRetrieved = true;
    // ignore: avoid_print
    print('Getting Data from Firestore');

    spindataDocument.get().then(
        (DocumentSnapshot doc){
          final data = doc.data() as Map<String, dynamic>;
          final positionData = data['position'];
          final differenceData = data['difference'];
          for (var item in positionData) {
            positionList.add(item['value']);
          }
          for (var item in differenceData) {
            differenceList.add(item['value']);
          }
          // // ignore: avoid_print
          //   print(positionList);
          //   // ignore: avoid_print
          //   print(differenceList);
          },
          // ignore: avoid_print
          onError: (error) => print('Error: $error'),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BIG WHEEL',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        toolbarHeight: 22,
        actions: <Widget>[
          IconButton(onPressed: () { Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const CounterPage()));
                    },
                    icon: const Icon(Icons.double_arrow_outlined, size: 12)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ChartPage(position, difference),
              const SizedBox(height: 10),
              Table(
                border: TableBorder.all(color: Colors.white),
                children: const [
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Pos', style: textStyle))),
                      TableCell(child: Center(child: Text('2', style: textStyle))),
                      TableCell(child: Center(child: Text('3', style: textStyle))),
                      TableCell(child: Center(child: Text('4', style: textStyle))),
                      TableCell(child: Center(child: Text('5', style: textStyle))),
                      TableCell(child: Center(child: Text('6', style: textStyle))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Diff', style: textStyle))),
                      TableCell(child: Center(child: Text('7', style: textStyle))),
                      TableCell(child: Center(child: Text('8', style: textStyle))),
                      TableCell(child: Center(child: Text('9', style: textStyle))),
                      TableCell(child: Center(child: Text('10', style: textStyle))),
                      TableCell(child: Center(child: Text('11', style: textStyle))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Num', style: textStyle))),
                      TableCell(child: Center(child: Text('12', style: textStyle))),
                      TableCell(child: Center(child: Text('13', style: textStyle))),
                      TableCell(child: Center(child: Text('14', style: textStyle))),
                      TableCell(child: Center(child: Text('15', style: textStyle))),
                      TableCell(child: Center(child: Text('16', style: textStyle))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Icon(Icons.arrow_downward_sharp, size: 30, color: Colors.white),
              GestureDetector(
                onPanUpdate: (details) {
                  double dx = details.delta.dx ;
                  double dy = details.delta.dy ;
                  double angle = atan2(dy, dx);
                  ref.read(rotationAngleProvider.notifier).state += angle *0.333;
                  int tempPosition = (rotationAngle/6.667 % 54).round().toInt();
                  position = tempPosition == 54 ? 0: tempPosition;
                  difference = ((rotationAngle-oldAngle)/6.667).round().toInt();
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
                  Text(position.toString(), style: textStyle),
                  const SizedBox(width: 25),
                  const Text('Difference: ', style: textStyle),
                  Text(difference.toString(), style: textStyle),
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
                        // positionList.add(position);
                        // differenceList.add(difference);
                        int nextPosition = findNextPosition();
                        if(nextPosition != -1){
                          // ignore: avoid_print
                          print('Next Position: $nextPosition');
                        }
                        int nextDifference = findNextDifference();
                        if(nextDifference != -99){
                          // ignore: avoid_print
                          print('Next Difference: $nextDifference');
                        }
                        // try {
                        //   if (!isFirstSave) {
                        //     spindataDocument.update({
                        //       'position': FieldValue.arrayUnion([{'timestamp': DateTime.now().toIso8601String(), 'value': position}]),
                        //       'difference': FieldValue.arrayUnion([{'timestamp': DateTime.now().toIso8601String(), 'value': difference}])
                        //     });
                        //   } else {
                        //     isFirstSave = false;
                        //   }
                        // } catch (e) {
                        //   // ignore: avoid_print
                        //   print('Error: $e');
                        // }
                      },
                    ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Slider(
                  value: rotationAngle < 0 ? 360 + rotationAngle : rotationAngle > 360 ? rotationAngle - 360 : rotationAngle,
                  min: 0,
                  max: 360,
                  divisions: 360,
                  onChanged: (value) {
                    ref.read(rotationAngleProvider.notifier).state = value;
                    int tempPosition = (rotationAngle/6.667 % 54).round().toInt();
                    position = tempPosition == 54 ? 0: tempPosition;
                    difference = ((rotationAngle-oldAngle)/6.667).round().toInt();
                  },
                ),
              ),
          ]),
        ),
      ),
    );
  }

  int findNextPosition(){
    for(int len = 4; len >= 2; len--){
      if(positions.length >= len){
        List<dynamic> latestPositions = positions.sublist(positions.length - len);
        for(int i = 0; i <= positionList.length - len; i++){
          List<dynamic> subList = positionList.sublist(i, i + len);
          if(listEquals(latestPositions, subList)){
            return positionList[i + len + 1];
          }
        }
      }
    }
    return -1;
  }

  int findNextDifference(){
    for(int len = 4; len >= 2; len--){
      if(differences.length >= len){
        List<dynamic> latestDifferences = differences.sublist(differences.length - len);
        for(int i = 0; i <= differenceList.length - len; i++){
          List<dynamic> subList = differenceList.sublist(i, i + len);
          if(listEquals(latestDifferences, subList)){
            return differenceList[i + len + 1];
          }
        }
      }
    }
    return -99;
  }

  bool listEquals(List<dynamic> list1, List<dynamic> list2){
    if(list1.length != list2.length){
      return false;
    }
    for(int i = 0; i < list1.length; i++){
      if((list1[i] - list2[i]).abs() > 3){
        return false;
      }
    }
    return true;
  }
}
