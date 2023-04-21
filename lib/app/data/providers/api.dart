import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:summer_class_app/app/data/model/movie_model.dart';

const baseUrl = 'https://script.google.com/macros/s/AKfycby7fanYDxT76nJ0026jiI6kquTYL3Qa60dg3GfHapUrFp7lFVT3yNUhX7FoWW-kTsyP8w/exec';

class MovieApiClient {
  final http.Client? httpClient;

  MovieApiClient({@required this.httpClient});

  Future<List<MovieModel>> getAll() async {
    try {
      final response = await httpClient!.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
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