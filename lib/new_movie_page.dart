import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
  File? imagePath;
  Uint8List? imageBytes;

  @override
  initState() {
    super.initState();
    loadAssetImage();
    debugPrint("Details initState Called: $imagePath");
  }

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
              child: InkWell (
                onTap: imagePicker,
                child: imageBytes != null
                   ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: MemoryImage(imageBytes!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 100,
                    height: 100,
                  )
                  : Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 80,
                    ),
                  ),
              )
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
                    await postMovie(titulo!, diretor!, sinopse!, imagePath!);
                    Navigator.pop(context, true);
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

  Future<void> loadAssetImage() async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/claquete.png';
    ByteData assetData = await rootBundle.load('assets/claquete.png');
    File(tempPath).writeAsBytesSync(assetData.buffer.asUint8List());
    // File tempFile = File(tempPath);
    imagePath = File(tempPath);
    debugPrint(imagePath!.path);
  }

  imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      setState(() {
        this.imageBytes = imageBytes;
      });
      imagePath = File(pickedFile.path);
      debugPrint("Image path: $imagePath");
    }
  }

  postMovie(String titulo, String diretor, String sinopse, File imagePath) async {
    Uint8List imageBytes = await imagePath.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    Map<String, dynamic> movie = {
      "titulo": titulo,
      "diretor": diretor,
      "sinopse": sinopse,
      "image": base64Image,
      "user_id": FirebaseAuth.instance.currentUser!.uid,
      "user_email": FirebaseAuth.instance.currentUser!.email,
    };

    await db.collection("movies").add(movie); // salvando filme
  }
}
