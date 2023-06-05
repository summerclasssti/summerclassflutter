import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:summer_class_app/app/controllers/home_controller.dart';
import 'package:summer_class_app/app/data/model/movie_model.dart';
import 'package:summer_class_app/app/data/repository/movie_repository.dart';


class UpdateMovieController extends GetxController {
  final MovieRepository? movieRepository;
  UpdateMovieController({@required this.movieRepository});

  final HomeController homeController = Get.find();

  MovieModel movieInfo = Get.arguments["movie_info"];
  int? updateIndex;
  String? titulo;
  String? diretor;
  String? sinopse;
  String? imgBase64;
  Uint8List? imageBytes;


  updateMovie(int index, String titulo, String diretor, String sinopse, String img) async {
    await movieRepository!.updateMovie(index, titulo, diretor, sinopse, img);
    homeController.reloadData();
  }

  Future<void> imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      imgBase64 = base64Encode(imageBytes!);
      update();
    }
  }

}