import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:summer_class_app/app/controllers/home_controller.dart';
import 'package:summer_class_app/app/routes/app_pages.dart';
import '../data/repository/movie_repository.dart';

class DetailsController extends GetxController {
  final MovieRepository? movieRepository;
  DetailsController({@required this.movieRepository});

  final HomeController homeController = Get.find();

  //Variável observável. Ao atualizá-la os Widgets GetX e ObX que a contém também são atualizados.
  final _likedMovie = false.obs;
  final movieId = Get.find<HomeController>().onPressedIndex + 1;
  final movieInfo = Get.arguments["movie_info"];
  get likedMovie => _likedMovie.value;
  set likedMovie(value) => _likedMovie.value = value;
  Uint8List? image;

  @override
  void onInit() {
    image = Uint8List.fromList(base64Decode(movieInfo.img));
    super.onInit();
  }

  //Executado ao pressionar o coração de like.
  void onPressedLikeBtn() {
    likedMovie = !likedMovie;
  }

  //Executado ao pressionar o botão excluir.
  void onPressedDeleteButton() {
    movieRepository?.deleteMovie(movieId);
    Future.delayed(const Duration(seconds: 3), () {
      homeController.reloadData();
      Get.offAllNamed(Routes.HOME);
    });
  }

  void onPressedUpdateButton() {
    Get.toNamed(Routes.UPDATE_MOVIE, arguments: {"index": movieId, "movie_info": movieInfo});
  }
}