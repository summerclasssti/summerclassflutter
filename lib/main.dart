import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  //Aqui o aplicativo é inicializado.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //GetMaterialApp é uma extensão do MaterialApp básico do Flutter com personalizações específicas do GetX.
    return GetMaterialApp(
      title: "Model App",
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
    );
  }
}
