import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gsheets/gsheets.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:summer_class_app/app/data/model/movie_model.dart';

const baseUrl = 'https://script.google.com/macros/s/AKfycbxujadYP5cLRWDpzR76guvfJq4GJXX3e5EP6W0-wYhcjTLectSErORMxubvmWVoLLCc-g/exec';

class MovieApiClient {
  final http.Client? httpClient;

  MovieApiClient({@required this.httpClient});

  final _spreadsheetId = "1JClY82U2bNpZd8pyOmPGnynUJbWEB_-0NbKKV5QK7CA";

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

  Future<Worksheet?> getSheet() async {
    try {
      await dotenv.load(fileName: '.env');
      final _credentials = dotenv.env["CRED"];
      final gsheets = GSheets(_credentials);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      final sheet = ss.worksheetByTitle('Página 1');

      return sheet;
    } catch (e) {
      debugPrint(e.toString());
    }
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
