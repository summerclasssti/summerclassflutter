import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:summer_class_app/app/controllers/new_movie_controller.dart';

class NewMoviePage extends GetView<NewMovieController> {
  NewMoviePage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? titulo;
  String? diretor = "Nome do diretor pendente";
  String? sinopse = "Sinópse pendente";
  String? img;
  int index = Get.arguments["index"];

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
                    titulo = value;
                    if (value == null || value.isEmpty) {
                      titulo = "Título pendente";
                    }
                  },
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Título pendente";
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Diretor',
                  ),
                  onSaved: (String? value) {
                    diretor = value;
                    if (value == null || value.isEmpty) {
                      diretor = "Diretor pendente";
                    }
                  },
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Diretor pendente";
                  //   }
                  //   return null;
                  // },
                ),TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Sinopse',
                  ),
                  onSaved: (String? value) {
                    sinopse = value!;
                    if (value == null || value.isEmpty) {
                      sinopse = "Sinopse pendente";
                    }
                  },
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Sinopse pendente";
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Img url',
                  ),
                  onSaved: (String? value) {
                    img = value;
                  },
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Url pendente';
                  //   }
                  //   return null;
                  // },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        _formKey.currentState!.save();
                        debugPrint(_formKey.currentState.toString());
                        debugPrint("1:$titulo 2:$diretor 3:$sinopse 4:$img");
                      }
                    },
                    child: const Text('Submit'),
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
