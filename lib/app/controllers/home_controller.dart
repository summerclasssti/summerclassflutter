import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:summer_class_app/app/data/model/movie_model.dart';
import 'package:summer_class_app/app/data/repository/movie_repository.dart';
import 'package:summer_class_app/app/routes/app_pages.dart';

class HomeController extends GetxController {

  //Usada para mostrar circular progress na HomePage.
  bool isLoading = true;

  //Lista de filmes (MovieModel)
  List<MovieModel> movieList = [];
  final MovieRepository? movieRepository;
  HomeController({@required this.movieRepository}) : assert(movieRepository != null);

  late int onPressedIndex;

  //Função executada assim que o controlador é iniciado.
  @override
  void onInit() {
    // fetchData();
    fetchMovies();
    super.onInit();
  }

  //Lista de imagens utilizada no VerticalCardPager
  List<Widget> images = [];

  //Lista de títulos utilizada no VerticalCardPager
  List<String> titles = [];

  //Callback executado quando há clique num filme. Index é o inteiro referente ao filme na lista.
  void onSelectedItem(int index) {
    onPressedIndex = index;
    if (index >= movieList.length) {
      Get.toNamed(Routes.NEW_MOVIE, arguments: {"newIndex": movieList.length + 1});
    } else {
      Get.toNamed(Routes.DETAILS, arguments: {"movie_info":movieList[index], "tag": index + 1});
    }
  }

  //Função que busca os dados da API
  // void fetchData() {
  //   movieRepository?.getAll().then((value) {
  //     // movieList = value;
  //     // fillMovieInfo(movieList);
  //     // isLoading = false;
  //     // update();
  //   });
  // }

  void fetchMovies() {
    try {
      movieRepository?.getMovies().then((value) {
        movieList = value;
        fillMovieInfo(movieList);
        isLoading = false;
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  //Preenche a lista de Widgets que ficam na HomePage. Recebe uma lista de MovieModel.
  void fillMovieInfo(List<MovieModel> movieList) {
    int i = 1;
    for(MovieModel movie in movieList ){
      titles.add("");
      images.add(
        Hero(
              tag: i,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  movie.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),);
      i++;
    }
    // Adiciona um card de adicionar depois da lista de filmes
    titles.add("");
    images.add(
      Hero(
        tag: i,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: const Icon(Icons.add_box_rounded, color: Colors.blue, size: 200)
        ),
      ),);
  }

  //Recarrega a lista de Widgets chamando o fetchData().
  void reloadData() {
    isLoading = true;
    update();
    titles = [];
    images = [];
    fetchMovies();
  }
}
