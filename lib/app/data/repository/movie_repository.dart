import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:summer_class_app/app/data/providers/api.dart';

class MovieRepository {
  final MovieApiClient? apiClient;

  MovieRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getAll() {
    return apiClient!.getAll();
  }

  Future getSheet() {
    return apiClient!.getSheet();
  }

  Future deleteMovie(int index) {
    return apiClient!.deleteMovie(index);
  }

  Future postMovie(int index, String titulo, String diretor, String sinopse, String img) {
    return apiClient!.postMovie(index, titulo, diretor, sinopse, img);
  }

  Future updateMovie(int index, String titulo, String diretor, String sinopse, String img) {
    return apiClient!.postMovie(index, titulo, diretor, sinopse, img);
  }
}
