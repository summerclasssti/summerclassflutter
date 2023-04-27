import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
// import 'package:http/http.dart' as http;
import 'package:summer_class_app/app/controllers/new_movie_controller.dart';
import 'package:summer_class_app/app/data/repository/movie_repository.dart';

class NewMoviePage extends GetView<NewMovieController> {
  NewMoviePage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int newIndex = Get.arguments["newIndex"];
  String? titulo;
  String? diretor;
  String? sinopse;
  String? img;

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
                    if (value == null || value.isEmpty) {
                      img = "https://umquatroquatro.com.br/wp-content/uploads/%C3%ADcone-claquete.png";
                    }
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
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        _formKey.currentState!.save();
                        controller.postMovie(newIndex, titulo!, diretor!, sinopse!, img!);
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
