import 'package:flutter/material.dart';
import 'dart:async';

import 'package:techdemo/techdemo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String log_text = "";

  int debug_print(String arg) {
    setState(() {
      log_text += arg + "\n";
    });

    return 0;
  }

  @override
  void initState() {
    super.initState();
    Backend.global_debug_print = debug_print;
    int ret = Backend.init();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 20);
    const spacerSmall = SizedBox(height: 10);

    var logBox = Column(
      children: [
        Text(
          log_text,
          style: textStyle,
          textAlign: TextAlign.left,
        ),
      ],
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Tech Demo'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Backend.test();
                  },
                  child: Text('Trigger'),
                ),
                logBox,
              ]
            )
          ),
        ),
      ),
    );
  }
}
