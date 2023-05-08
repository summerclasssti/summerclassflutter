import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:summer_class_app/app/controllers/new_movie_controller.dart';
import 'package:summer_class_app/app/controllers/update_movie_controller.dart';
import 'package:summer_class_app/app/data/model/movie_model.dart';

class UpdateMoviePage extends GetView<UpdateMovieController> {
  UpdateMoviePage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TODO: mandar código que não deveria estar aqui pro controller

  MovieModel movieInfo = Get.arguments["movie_info"];
  int? updateIndex;
  String? titulo;
  String? diretor;
  String? sinopse;
  String imgBase64 = "";
  Uint8List? imageBytes;

  Future<void> imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      imgBase64 = base64Encode(imageBytes!);
      // TODO: descobrir por que que esse update não está funcionando
      controller.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Movie Page')),
      body: GetBuilder<NewMovieController>(
          builder: (_) {
            return Form(
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
                          titulo = movieInfo.titulo;
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
                          diretor = movieInfo.diretor;
                        } else {
                          diretor = value;
                        }
                      },
                    ),TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Sinopse',
                      ),
                      onSaved: (String? value) {
                        if (value == null || value.isEmpty) {
                          sinopse = movieInfo.sinopse;
                        } else {
                          sinopse = value;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: imagePicker,
                        child: const Text('Adicionar imagem'),
                      ),
                    ),
                    if (imgBase64.length >= 50000) const Text("Imagem muito grande"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                            // _formKey.currentState!.save();
                            // updateIndex = movieInfo.id;
                            // controller.updateMovie(updateIndex!, titulo!, diretor!, sinopse!, imgBase64);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Em manutenção...')));
                          }
                        },
                        child: const Text('Salvar'),
                      ),
                    ),
                  ],
                )
            );
          }
      ),
    );
  }
}
