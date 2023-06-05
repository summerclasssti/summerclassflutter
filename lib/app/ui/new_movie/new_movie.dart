import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:summer_class_app/app/controllers/new_movie_controller.dart';

class NewMoviePage extends GetView<NewMovieController> {
  NewMoviePage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Movie Page')),
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
                    controller.titulo = value;
                    if (value == null || value.isEmpty) {
                      controller.titulo = "Título pendente";
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Diretor',
                  ),
                  onSaved: (String? value) {
                    controller.diretor = value;
                    if (value == null || value.isEmpty) {
                      controller.diretor = "Diretor pendente";
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Sinopse',
                  ),
                  onSaved: (String? value) {
                    controller.sinopse = value!;
                    if (value == null || value.isEmpty) {
                      controller.sinopse = "Sinopse pendente";
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
                // if (imgBase64.length >= 50000) const Text("Imagem muito grande"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate retorna true se o form for válido
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        _formKey.currentState!.save();
                        controller.postMovie(controller.newIndex, controller.titulo!, controller.diretor!, controller.sinopse!, controller.imgBase64);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Salvando...')));
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
