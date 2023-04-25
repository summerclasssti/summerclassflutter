import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:summer_class_app/app/controllers/new_movie_controller.dart';

class NewMoviePage extends GetView<NewMovieController> {
  const NewMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Movie Page')),
      body: GetBuilder<NewMovieController>(
        builder: (_) {
          return const Center(child: Text("Work in progress"));
        }
      ),
    );
  }
}
