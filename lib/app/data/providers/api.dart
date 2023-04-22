import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
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

  static const _credentials = r'''{
    "type": "service_account",
    "project_id": "summerclass2023",
    "private_key_id": "97aef78d7b7eb57f813cd23d6e4a2b8d2a4a436c",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCK9/YFuMq2SgQ2\nQcG91i7zQTyQFHd9PABkLjz0KIls+eF0RAXex0U9U9AGYCixZkMgtRvHoXGTxcS1\nN3F9bCbsiVqqyX9hXP40LKOg4ge9WbvrHbq2HC4FdEmAJg5t8j+sW8qTUnCrU6cv\nwEegthYSw6w0bgpxo+/Fly7zya7R/EQSkxAfKZk2dssuN5kusm+gEh7GozLGZLPu\nmupSmOCvtoYM5L3KJbFhwW8Ea2VfaRoKahHZbwBwQsy7PeQWIkW7ifqvoBYnMzRp\nBvTwQHz2co0mwWiX5I6Vi8iqdzxV3aWJoyhM6Jw6cZmSZVrEIqjfnZIWqAIwARWY\nIM1Cml3bAgMBAAECggEABkuFx/jFqfmmJ8tu8/zI4xKdJGbg8MajVLM2TKMUP2Ax\nKWI2PkMaX+61GVmiwXWnhcqrOvqu5lA+AS14eFBKK33SiLKYkN40n6o3MUyVdPgL\nIXMXAZsHx9rekRQ1CoYmNaMLODgysitKz/vVFf9/9kXWpG6PQScsoqLSD1xr85QT\nB8DemPHlPzHaXkxzG4EYtkPEoWLpb6jfWO/l/WIaDlP7BoDh3GOn54VMvKe6k3/7\nVCgAFZDnkqgF+E7YA9IRUPoTvpB/V0ewNClhXxexNsgmkHOaspUdWadqzkYK9oDc\nLvklNnsYbie3uw8abCl98AjAHgVcn3UOsHx9jKPL9QKBgQC+exT6sYz2caapTvDN\nXi5T7XKW5v7nRMnacurOQP7P3HETGlV5nLPaU9qRXMk3wFRbfJY89JrmDUj2eu2F\n2BcIJpV9O7P+jfF0J7Od8/5Ae1ZCpDVhgZXHhc10Tzr47wAIznVn8LNrF6d/pV7b\nvahkuy02IwleUknaTjBWYm4hpQKBgQC6xO/1as9VOplGJ5KhAy137WSH0TGwdjRB\n603T2aVb3w5idgwOpYFn2acieQBradyUC+XMkRAOuzW7a+LksPxEbvy5NW8mD9eM\nPC/7PFvfbdeg2toxlXuvV2xVgQtdsuvVTBLW2yr/jCuzdz7RC2Z3k/2w0OdxX/+R\nhta8649pfwKBgHg4UKZk9zX3xxtmwl6ryYuY+tC5HDq01L11+DKTHP/t/sPyw+3M\ndEsgz3sdV7ZDQjq3qE7yhu0Zh2phbZYjK24ug/0VeGX6CmGoSRoxC9CAx5Gp+DMB\nSZozHdgBxZOlrJziSYF/jo3R0RqkMfl4e1aQOFnJxTjtsMUCwklTOHUtAoGBAJUy\nd0IEhgXensyFFkQbZroT4KgCfAAsHQi/sNdYWRkv8azEAlO88MgF/day9JvZ4EQ/\n0N3+z+YEtSK4R3NK0urUAnzta5HrO9QhzG6VRAsTExrDWWQctsZWPwt635qFMJGe\niLosMIgd8FcYHg0eX0eM6C7UYt6VwnH9VhNq1ZB/AoGBAJ9BoeBfwwTO1fB9nhkq\nNxxBF1j4abKN0yvFHbxcQXKYCcAJSqPtPxduVB1QemwrAFlhpfrGG9fjnXTVI/rh\ntxkd5Ga/5twwTtH2388/2nyQuUw+vDwMArWvDzMeFCKgkCP7gsZ5tEgWwMVNuJK+\nyOoqX4+7v0rJgNrJJhctltVN\n-----END PRIVATE KEY-----\n",
    "client_email": "summerclass2023@summerclass2023.iam.gserviceaccount.com",
    "client_id": "100630960056933570948",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/summerclass2023%40summerclass2023.iam.gserviceaccount.com"
  }''';

  final _spreadsheetId = "1JClY82U2bNpZd8pyOmPGnynUJbWEB_-0NbKKV5QK7CA";

  Future<List<MovieModel>> getMovies() async {
    try {
      final gsheets = GSheets(_credentials);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      var sheet = ss.worksheetByTitle('Filmes');
      var values = await sheet!.values.allRows();
      List<Map<String, dynamic>> data = [];

      for (var i = 1; i < values.length; i ++) {
        Map<String, dynamic> resp = {};
        var row = values[i];
        resp['id'] = int.parse(row[0]);
        resp['titulo'] = row[1];
        resp['diretor'] = row[2];
        resp['sinopse'] = row[3];
        resp['img'] = row[4];
        // debugPrint(resp.toString());

        data.add(resp);
      }
      return data.map((movieJson) => MovieModel.fromJson(movieJson)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
