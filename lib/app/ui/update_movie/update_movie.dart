import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
// import 'package:http/http.dart' as http;
import 'package:summer_class_app/app/controllers/new_movie_controller.dart';
import 'package:summer_class_app/app/controllers/update_movie_controller.dart';
import 'package:summer_class_app/app/data/model/movie_model.dart';
import 'package:summer_class_app/app/data/repository/movie_repository.dart';

class UpdateMoviePage extends GetView<UpdateMovieController> {
  UpdateMoviePage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MovieModel movieInfo = Get.arguments["movie_info"];
    int updateIndex = movieInfo.id;
    String? titulo;
    String? diretor;
    String? sinopse;
    String? img;

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
                        if (value == null || value.isEmpty) {
                          diretor = movieInfo.diretor;
                        } else {
                          diretor = value;
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
                        if (value == null || value.isEmpty) {
                          sinopse = movieInfo.sinopse;
                        } else {
                          sinopse = value;
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
                        if (value == null || value.isEmpty) {
                          img = movieInfo.img;
                        } else {
                          img = value;
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
                            debugPrint(updateIndex.toString());
                            controller.updateMovie(updateIndex, titulo!, diretor!, sinopse!, img!);
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
