import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:summer_class_app/app/controllers/update_movie_controller.dart';

class UpdateMoviePage extends GetView<UpdateMovieController> {
  UpdateMoviePage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Movie Page')),
      body: GetBuilder<UpdateMovieController>(
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
                          controller.titulo = controller.movieInfo.titulo;
                        } else {
                          controller.titulo = value;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Diretor',
                      ),
                      onSaved: (String? value) {
                        if (value == null || value.isEmpty) {
                          controller.diretor = controller.movieInfo.diretor;
                        } else {
                          controller.diretor = value;
                        }
                      },
                    ),TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Sinopse',
                      ),
                      onSaved: (String? value) {
                        if (value == null || value.isEmpty) {
                          controller.sinopse = controller.movieInfo.sinopse;
                        } else {
                          controller.sinopse = value;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: controller.imageBytes != null
                        ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: MemoryImage(controller.imageBytes!),
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
                        onPressed: controller.imagePicker,
                        child: const Text('Adicionar imagem'),
                      ),
                    ),
                    if (controller.imgBase64!.length >= 50000) const Text("Imagem muito grande"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                            _formKey.currentState!.save();
                            controller.updateIndex = controller.movieInfo.id;
                            controller.updateMovie(controller.updateIndex!, controller.titulo!, controller.diretor!, controller.sinopse!, controller.imgBase64!);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Salvando...')));
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
