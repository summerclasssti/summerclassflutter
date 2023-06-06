import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:summer_class_app/app/controllers/home_controller.dart';
import 'package:summer_class_app/app/data/repository/movie_repository.dart';
import 'package:summer_class_app/app/routes/app_pages.dart';

class NewMovieController extends GetxController {
  final MovieRepository? movieRepository;
  NewMovieController({@required this.movieRepository});

  final HomeController homeController = Get.find();

  int newIndex = Get.arguments["newIndex"];
  String? titulo;
  String? diretor;
  String? sinopse;
  String imgBase64 = "";
  Uint8List? imageBytes;


  postMovie(int index, String titulo, String diretor, String sinopse, String img) {
    movieRepository!.postMovie(index, titulo, diretor, sinopse, img);
    Future.delayed(const Duration(seconds: 3), () {
      homeController.reloadData();
      Get.offAllNamed(Routes.HOME);
    });
  }

  Future<void> imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      imgBase64 = await base64Encode(imageBytes!);
      update();
    }
  }

  setFieldInfo(String field, String? value) {
    switch(field) {
      case "titulo":
        if (value == null || value.isEmpty) {
          titulo = "Título pendente";
        }
        break;
      case "diretor":
        if (value == null || value.isEmpty) {
          titulo = "Diretor pendente";
        }
        break;
      case "sinopse":
        if (value == null || value.isEmpty) {
          titulo = "Título pendente";
        }
        break;
      default:
        debugPrint("Campo $field não encontrado!");
    }
  }
}