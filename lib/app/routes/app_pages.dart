import 'package:get/get.dart';
import 'package:summer_class_app/app/bindings/details_binding.dart';
import 'package:summer_class_app/app/bindings/home_binding.dart';
import 'package:summer_class_app/app/bindings/new_form_binding.dart';
import 'package:summer_class_app/app/bindings/update_form_binding.dart';
import 'package:summer_class_app/app/ui/details/details_page.dart';
import 'package:summer_class_app/app/ui/home/home_page.dart';
import 'package:summer_class_app/app/ui/new_movie/new_movie.dart';
import 'package:summer_class_app/app/ui/splash/splash_page.dart';
import 'package:summer_class_app/app/ui/update_movie/update_movie.dart';

//part indica que app_routes.dart faz parte desse arquivo. Essa divisão existe apenas por questões de organização.
part 'app_routes.dart';

//Classe abstrata que contém todas as Pages do Aplicativo.
abstract class AppPages{

  //Lista de páginas(GetPage) que é inserida no campo getPages da main.
  static final pages = [
    GetPage(name: Routes.SPLASH, page:()=> SplashPage()),
    GetPage(name: Routes.HOME, page: ()=>HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.DETAILS, page: ()=>DetailsPage(), binding: DetailsBinding()),
    GetPage(name: Routes.NEW_MOVIE, page: ()=>NewMoviePage(), binding: NewMovieBinding()),
    GetPage(name: Routes.UPDATE_MOVIE, page: ()=>UpdateMoviePage(), binding: UpdateMovieBinding()),
  ];
}