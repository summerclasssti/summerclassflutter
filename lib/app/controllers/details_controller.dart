import 'package:get/get.dart';

class DetailsController extends GetxController {

  //Variável observável. Ao atualizá-la os Widgets GetX e ObX que a contém também são atualizados.
  final _likedMovie = false.obs;
  get likedMovie => _likedMovie.value;
  set likedMovie(value) => _likedMovie.value = value;

  //Executado ao pressionar o coração de like.
  void onPressedLikeBtn() {
    likedMovie = !likedMovie;
  }
}