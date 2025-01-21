import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}

class TestCach extends StatefulWidget {
  const TestCach({super.key});

  @override
  State<TestCach> createState() => _TestCachState();
}

class _TestCachState extends State<TestCach> {
  var x = 0;

  @override
  Widget build(BuildContext context) {
    SharedPrefData.sharedPreferences!.setDouble("x", x.toDouble());
    var xc =SharedPrefData.sharedPreferences!.getDouble("x");
    return Scaffold(
      appBar: AppBar(
        title: Text(xc.toString()),
      ),
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                x++;
                setState(() {});
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
