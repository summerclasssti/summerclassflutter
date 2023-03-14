import 'package:meta/meta.dart';
import 'package:summer_class_app/app/data/providers/api.dart';

class MovieRepository {
  final MovieApiClient? apiClient;

  MovieRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getAll() {
    return apiClient!.getAll();
  }
}

