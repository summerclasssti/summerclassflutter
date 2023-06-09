//part of significa que esse arquivo é parte do app_pages.dart, uma 'continuação'.
part of 'app_pages.dart';

//Classe abstrata que define as Rotas como strings para serem usadas na navegação nomeada.
abstract class Routes{

  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const DETAILS = '/details';
  static const NEW_MOVIE = '/new_movie';
  static const UPDATE_MOVIE = '/update_movie';
}