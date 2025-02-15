import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:summerclass/login_page.dart';
import 'package:summerclass/sign_in.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final db = FirebaseFirestore.instance;

  bool isLoading = true;
  late bool isLogged;
  List<Map<String, dynamic>> moviesList = [];
  List<String> titles = [];
  List<Widget> images = [];

  @override
  initState() {
    super.initState();
    reloadData();
  }

  logout() async {
    await SignInService().logoutGoogle();
    if (!context.mounted) {
      return;
    }
    Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (c) => const LoginPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Filmes nacionais"),
        centerTitle: true,
        leading: IconButton(
          onPressed: logout,
          icon: const Icon(Icons.logout),
        ),
        actions: [
          IconButton(
            onPressed: reloadData,
            icon: const Icon(Icons.refresh)
          ),
        ],
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : VerticalCardPager(
          initialPage: 1,
          titles: titles,
          images: images,
          onSelectedItem: onSelectedItem,
        ),
    );
  }

  Future<void>getAll() async {
    try{
      List<Map<String, dynamic>> moviesList = [];
      await db.collection("movies").get().then((querySnapshot) async {
        final docs = querySnapshot.docs;
        for (var index = 0; index < docs.length; index++) {
          final docSnapshot = docs[index];

          Map<String, dynamic> movie = {};

          movie["id"] = docSnapshot.id;
          movie["titulo"] = docSnapshot.data()["titulo"];
          movie["diretor"] = docSnapshot.data()["diretor"];
          movie["sinopse"] = docSnapshot.data()["sinopse"];
          movie["liked"] = docSnapshot.data()["liked"];
          movie["image"] = docSnapshot.data()["image"];

          moviesList.add(movie);
        }
      }, onError: (e) {
        debugPrint("Error completing: $e");
      });
      // debugPrint("MovieList: $moviesList");
      this.moviesList = moviesList;
    } catch(e) {
      debugPrint('ERRO db.collection("movies").get(): $e');
    }
  }

  Future<void> fillMovieInfo(List movieList) async {
    for(var movie in movieList){
      titles.add("");
      images.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.memory(
            base64Decode(movie["image"]),
            fit: BoxFit.cover,
          ),
        )
      );
    }

    titles.add("");
    images.add(
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: const Icon(Icons.add_box_rounded, color: Colors.blue, size: 200)
      ),
    );
  }

  Future<void> reloadData() async {
    setState(() {
      isLoading = true;
    });

    titles = [];
    images = [];
    await getAll();
    fillMovieInfo(moviesList);

    setState(() {
      isLoading = false;
    });
  }

  void onSelectedItem(int index) async {
    debugPrint(index.toString());
    if (index == titles.length -1) {
      Navigator.pushNamed(context, "/new");
    } else {
      var shouldReload = await Navigator.pushNamed(context, '/details', arguments: moviesList[index]);
      if (shouldReload == true) {
        reloadData();
      }
    }
  }
}
