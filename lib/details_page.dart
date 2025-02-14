import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // bool liked = movie["liked"];

    getUserMovie() async {
      var d = await FirebaseFirestore.instance.doc("users_movies/${FirebaseAuth.instance.currentUser!.uid}_${movie["id"]}").get();
      return d.data();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getUserMovie(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          bool liked = false;
          if (snapshot.data != null) {
            liked = snapshot.data!["liked"] ?? false;
          }
          return ListView(
            children: [
              Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.black],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    child: Image.memory(
                      movie["image"],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movie["titulo"], style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                    ),
                  ),
                  Row (
                    children: [
                      IconButton(
                        onPressed: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Deletando..."))
                          );
                          await _onPressedDeleteButton(movie);
                          Navigator.pop(context, true);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                      IconButton(
                        onPressed: () => _onPressedLikeButton(movie, !liked),
                        icon: Icon(
                          liked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        )
                      )
                    ],
                  ),
                ],
              ),
              Text(movie["diretor"],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 12
                )
              ),
              const SizedBox(height: 20,),
              Text(
                movie["sinopse"],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                )
              ),
            ],
          );
        }
      )
    );
  }

  void _onPressedLikeButton(Map<String, dynamic> movie, bool liked) async {
    // setState(() {
    //   movie["liked"] = liked;
    // });
    var d = await db.doc("users_movies/${FirebaseAuth.instance.currentUser!.uid}_${movie["id"]}").get();
    if (!d.exists) {
      await db.doc("users_movies/${FirebaseAuth.instance.currentUser!.uid}_${movie["id"]}").set({
        "liked": liked
      });
    } else {
      await db.collection("users_movies").doc("${FirebaseAuth.instance.currentUser!.uid}_${movie["id"]}").update({"liked": liked});
    }
    setState(() {
      movie["liked"] = liked;
    });
  }

  Future<void> _onPressedDeleteButton(Map<String, dynamic> movie) async {
    await db.collection("movies").doc(movie["id"]).delete();
  }
}
