import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:summer_class_app/app/controllers/details_controller.dart';
import 'package:summer_class_app/app/data/model/movie_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    MovieModel movieInfo = Get.arguments["movie_info"];
    int heroTag = Get.arguments["tag"];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Sobre o Filme'), centerTitle: true, automaticallyImplyLeading: true,),
      body: GetBuilder<DetailsController>(
          init: DetailsController(),
          builder: (_) {
            return ListView(
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: heroTag,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.black],
                          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        child: Image.network(
                          movieInfo.img,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(movieInfo.titulo, style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),),
                    IconButton(
                      onPressed: _.onPressedLikeBtn,
                      icon: GetX<DetailsController>(
                        builder: (_) {
                        return Icon(_.likedMovie ? Icons.favorite : Icons.favorite_border);
                      },
                    ), color: Colors.red,)
                  ],
                ),
                Text(movieInfo.diretor, style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontSize: 12)),
                const SizedBox(height: 20,),
                Text(
                    movieInfo.sinopse,
                    style: const TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                )
              ],
            );
          }),
    );
  }
}
