import 'package:get/get.dart';
import 'package:summer_class_app/app/routes/app_pages.dart';

class SplashController extends GetxController {
  double animatedMargin = 0.0;
  bool visibleStrip = false;

  @override
  void onReady() {
    // Quando o controlador estiver pronto, mudar os valores para iniciar a animação
    visibleStrip = true;
    animatedMargin = 80.0;
    update();
  }

  void onEnd() {
    // Delay de 300 milissegundos antes de chamar a rota HOME para deixar a
    // Splash Screen vísivel por mais alguns instantes.
    Future.delayed(
        const Duration(milliseconds: 300), () => Get.offAllNamed(Routes.HOME));
  }

  double findLogoSize() {
    // Define tamanho do logo como 30% da altura da tela
    return Get.height * 0.3;
  }

  double findIconSize() {
    // Define tamanho dos ícones como a altura da tela dividido por 15, por ser
    // uma coluna de 15 ícones.
    return Get.height / 15;
  }
}
