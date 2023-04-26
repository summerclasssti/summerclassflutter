import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:summer_class_app/app/controllers/details_controller.dart';
import 'package:summer_class_app/app/controllers/home_controller.dart';
import 'package:summer_class_app/app/data/providers/api.dart';
import 'package:summer_class_app/app/data/repository/movie_repository.dart';

class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailsController(movieRepository: MovieRepository(apiClient: MovieApiClient(httpClient: http.Client()))));
    Get.put(HomeController(movieRepository: MovieRepository(apiClient: MovieApiClient(httpClient: http.Client()))));
  }
}