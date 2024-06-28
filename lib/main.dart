// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, prefer_const_constructors_in_immutables, must_be_immutable, use_super_parameters

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Arm Bandit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 62, 183, 58)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Multi-Arm Bandit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int tempCounter = 0;
  String dropdownValue = 'Slot Machine A';
  int _payout = 0;
  bool _slotMachineA = false;
  bool _slotMachineB = false;
  bool _slotMachineC = false;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _pullBad() {
    setState(
      () {
        var rng = Random();
        var rngTemp = rng.nextInt(100);
        if (rngTemp < 70) {
          //70% chance of 0 payout
          _payout = 0;
        } else {
          //30% chance of 1-99 payout
          _payout = rng.nextInt(100) + 1;
        }
      },
    );
  }

  void _pullGood() {
    setState(
      () {
        var rng = Random();
        var rngTemp = rng.nextInt(100);
        if (rngTemp < 60) {
          //60% chance of 0 payout
          _payout = 0;
        } else if (rngTemp < 80) {
          //20% chance of 1-99 payout
          _payout = rng.nextInt(100) + 1;
        } else {
          _payout = rng.nextInt(100) * 10 + rng.nextInt(10) + 100;
          //20% chance of 100-999 payout
        }
      },
    );
  }

  void _assignSlot() {
    var rng = Random();
    var rngTemp = rng.nextInt(100);
    if (rngTemp < 33) {
      _slotMachineA = true;
    } else if (rngTemp < 66) {
      _slotMachineB = true;
    } else {
      _slotMachineC = true;
    }
  }

  void reset() {
    setState(
      () {
        _payout = 0;
        _counter = 0;
        _slotMachineA = true;
        _slotMachineB = false;
        _slotMachineC = false;
        _assignSlot();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('slotMachineA =' '$_slotMachineA');
    debugPrint('slotMachineB =' '$_slotMachineB');
    debugPrint('slotMachineC =' '$_slotMachineC');
    //_assignSlot();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(
                  20.0), // Adjust this value to your desired padding
              child: Text(
                'One of these slot machines is the best. Click the buttons to play each machine and see which one is the best.',
              ),
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.headlineSmall!,
              child: Table(
                children: [
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Center(
                          child: Image.asset(
                              'assets/images/slotmachine.png'), // Replace with your image path
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Center(
                          child: Image.asset(
                              'assets/images/slotmachine.png'), // Replace with your image path
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Center(
                          child: Image.asset(
                              'assets/images/slotmachine.png'), // Replace with your image path
                        ),
                      ),
                    ],
                  ),
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Slot Machine A',
                            style: TextStyle(
                              fontSize:
                                  12, // Adjust this value to your desired font size
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Slot Machine B',
                            style: TextStyle(
                              fontSize:
                                  12, // Adjust this value to your desired font size
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Slot Machine C',
                            style: TextStyle(
                              fontSize:
                                  12, // Adjust this value to your desired font size
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            _incrementCounter();
                            if (_slotMachineA == false) {
                              _pullGood();
                              debugPrint('pullGood');
                            } else {
                              _pullBad();
                              debugPrint('pullBad');
                            }
                          },
                          tooltip: 'Try this slot machine',
                          child: const Icon(Icons.add),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            _incrementCounter();
                            if (_slotMachineB == true) {
                              debugPrint('pullGood');
                              _pullGood();
                            } else {
                              debugPrint('pullBad');
                              _pullBad();
                            }
                          },
                          tooltip: 'Try this slot machine',
                          child: const Icon(Icons.add),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            _incrementCounter();
                            if (_slotMachineC == true) {
                              debugPrint('pullGood');
                              _pullGood();
                            } else {
                              debugPrint('pullBad');
                              _pullBad();
                            }
                          },
                          tooltip: 'Try this slot machine',
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                  10.0), // Adjust this value to your desired padding
              child: Text(
                'Payout: \$$_payout',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                  10.0), // Adjust this value to your desired padding
              child: Text(
                'Pulls: $_counter',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>[
                    'Slot Machine A',
                    'Slot Machine B',
                    'Slot Machine C'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (dropdownValue == 'Slot Machine A' &&
                            _slotMachineA == true ||
                        dropdownValue == 'Slot Machine B' &&
                            _slotMachineB == true ||
                        dropdownValue == 'Slot Machine C' &&
                            _slotMachineC == true) {
                      tempCounter = _counter;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WinPage(data: tempCounter)),
                      );
                      reset();
                    } else {
                      reset();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LosePage()),
                      );
                    }
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods
  }
}

class WinPage extends StatelessWidget {
  int data;

  WinPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('You Won!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Congratulations! You picked the best slot machine.'),
            Text('It took you $data pulls to figure it out.'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Play again?'),
            ),
          ],
        ),
      ),
    );
  }
}

class LosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('You Lost!'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: const Text('Play again?'),
        ),
      ),
    );
  }
}



/*class WinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('You Won!'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'Multi-Arm Bandit'),
            );
          },
          child: const Text('Play again?'),
        ),
      ),
    );
  }
}

class LosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('You Lost!'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'Multi-Arm Bandit'),
            );
          },
          child: const Text('Play again?'),
        ),
      ),
    );
  }
}*/
