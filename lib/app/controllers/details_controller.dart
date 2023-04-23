import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:summer_class_app/app/controllers/home_controller.dart';
import '../data/repository/movie_repository.dart';

class DetailsController extends GetxController {
  final MovieRepository? movieRepository;
  DetailsController({@required this.movieRepository});

  //Variável observável. Ao atualizá-la os Widgets GetX e ObX que a contém também são atualizados.
  final _likedMovie = false.obs;
  final movieId = Get.find<HomeController>().onPressedIndex + 1;
  get likedMovie => _likedMovie.value;
  set likedMovie(value) => _likedMovie.value = value;

  //Executado ao pressionar o coração de like.
  void onPressedLikeBtn() {
    debugPrint(movieId.toString());
    likedMovie = !likedMovie;
    movieRepository?.deleteMovie(movieId);
  }
}