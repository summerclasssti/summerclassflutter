import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:summer_class_app/app/controllers/new_movie_controller.dart';
import 'package:summer_class_app/app/controllers/update_movie_controller.dart';
import 'package:summer_class_app/app/data/model/movie_model.dart';

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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
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
