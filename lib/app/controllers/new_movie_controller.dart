import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:summer_class_app/app/data/repository/movie_repository.dart';

class NewMovieController extends GetxController {
  final MovieRepository? movieRepository;
  NewMovieController({@required this.movieRepository});
}