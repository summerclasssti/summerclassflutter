import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMoviePage extends StatefulWidget {
  const NewMoviePage({super.key});

  @override
  State<NewMoviePage> createState() => _NewMoviePageState();
}

class _NewMoviePageState extends State<NewMoviePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  String? titulo;
  String? diretor;
  String? sinopse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Novo filme")),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Título',
              ),
              onSaved: (String? value) {
                if (value == null || value.isEmpty) {
                  titulo = "Título pendente";
                } else {
                  titulo = value;
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Diretor',
              ),
              onSaved: (String? value) {
                if (value == null || value.isEmpty) {
                  diretor = "Diretor pendente";
                } else {
                  diretor = value;
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Sinopse',
              ),
              onSaved: (String? value) {
                if (value == null || value.isEmpty) {
                  sinopse = "Sinopse pendente";
                } else {
                  sinopse = value;
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate retorna true se o form for válido
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Salvando...')));
                    _formKey.currentState!.save();
                    await postMovie(titulo!, diretor!, sinopse!);
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  }
                },
                child: const Text('Salvar'),
              ),
            ),
            // ElevatedButton(onPressed: controller.printAll, child: const Text("Print")),
          ],
        ),
      )
    );
  }

  postMovie(String titulo, String diretor, String sinopse) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, dynamic> movie = {
      "titulo": titulo,
      "diretor": diretor,
      "sinopse": sinopse,
      "image": fileName,
      "liked": false,
    };

    await db.collection("movies").doc(fileName).set(movie); // salvando filme
  }
}
