import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> titles = ["RED", "YELLOW", "BLACK", "CYAN", "BLUE", "GREY", ];

  final List<Widget> images = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.black,
    ),
    Container(
      color: Colors.cyan,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Summerclass"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: VerticalCardPager(
                  titles: titles,  // required
                  images: images,  // required
                  textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // optional
                  onSelectedItem: (index) {
                    debugPrint(titles[index]);
                  },
                  initialPage: 1, // optional
              ),
            ),
          ],
        ),
      ),
    );
  }
}