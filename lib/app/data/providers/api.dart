import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:summer_class_app/app/data/model/movie_model.dart';

const baseUrl = 'https://script.google.com/macros/s/AKfycbxujadYP5cLRWDpzR76guvfJq4GJXX3e5EP6W0-wYhcjTLectSErORMxubvmWVoLLCc-g/exec';

class MovieApiClient {
  final http.Client? httpClient;

  MovieApiClient({@required this.httpClient});

  Future<List<MovieModel>> getAll() async {
    try {
      const url = '$baseUrl?function=getMovies';
      final response = await httpClient!.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        // debugPrint(jsonResponse.toString());
        return jsonResponse.map((movieJson) => MovieModel.fromJson(movieJson)).toList();
      } else {
        debugPrint('Error -getAll');
      }
    } catch (e) {
      debugPrint("Error fetching from API: $e");
    }
    return [];
  }

  deleteMovie(int movieId) async {
    try {
      final url = '$baseUrl?function=deleteMovie&index=$movieId';
      await httpClient!.post(Uri.parse(url));
      debugPrint(url.toString());
    } catch (e) {
      debugPrint("Error fetching from API: $e");
    }
  }

  postMovie(int index, String titulo, String diretor, String sinopse, String img) async {
    try {
      final url = '$baseUrl?function=postMovie&index=$index&titulo=$titulo&diretor=$diretor&sinopse=$sinopse&img=$img';
      final response = await httpClient!.post(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        // debugPrint(jsonResponse.toString());
        return jsonResponse.map((movieJson) => MovieModel.fromJson(movieJson)).toList();
      } else {
        debugPrint('Error -getAll');
      }
    } catch (e) {
      debugPrint("Error fetching from API: $e");
    }
    return [];
  }
}
