import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> titles = ["BLUE", "GREY", ""];

  final List<Widget> images = [
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.grey,
    ),
    ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: const Icon(Icons.add_box_rounded, color: Colors.blue, size: 200)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Filmes nacionais"),
        centerTitle: true,
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: VerticalCardPager(
                  titles: titles,  // required
                  images: images,  // required
                  textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // optional
                  onSelectedItem: onSelectedItem,
                  initialPage: 1, // optional
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelectedItem(int index) {
    debugPrint(titles.length.toString());
    debugPrint(index.toString());
    if (index == titles.length -1) {
      Navigator.pushNamed(context, "/new");
    } else {
      debugPrint(titles[index]);
    }
  }
}