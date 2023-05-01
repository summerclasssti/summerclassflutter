import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:summer_class_app/app/controllers/home_controller.dart';
import 'package:summer_class_app/app/data/repository/movie_repository.dart';
import 'package:summer_class_app/app/routes/app_pages.dart';

class UpdateMovieController extends GetxController {
  final MovieRepository? movieRepository;
  UpdateMovieController({@required this.movieRepository});

  final HomeController homeController = Get.find();

  updateMovie(int index, String titulo, String diretor, String sinopse, String img) {
    movieRepository!.updateMovie(index, titulo, diretor, sinopse, img);
    Future.delayed(const Duration(seconds: 3), () {
      homeController.reloadData();
      Get.offAllNamed(Routes.HOME);
    });
  }
}