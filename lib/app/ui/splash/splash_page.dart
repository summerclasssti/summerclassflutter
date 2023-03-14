import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:summer_class_app/app/controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) {
          return Stack(
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1200),
                opacity: _.visibleStrip ? 1.0 : 0.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.access_time,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.settings,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.account_balance,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.edit,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.directions_bus,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.access_time,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.settings,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.wifi,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.local_library,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.format_list_bulleted,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.restaurant,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.library_books,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.settings,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.wifi,
                          size: _.findIconSize(), color: Colors.white),
                      Icon(Icons.local_library,
                          size: _.findIconSize(), color: Colors.white),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                onEnd: _.onEnd,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 1300),
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: _.animatedMargin),
                child: SizedBox(
                  width: _.findLogoSize(),
                  height: _.findLogoSize(),
                  child: Card(
                    color: Colors.white,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Image.asset(
                        'assets/um_summerclass.png',
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
