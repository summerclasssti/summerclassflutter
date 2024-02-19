import 'package:flutter/material.dart';
import 'package:summerclass/home_page.dart';
import 'package:summerclass/login_page.dart';
import 'package:summerclass/sign_in.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  tryLogin() async {
    var hasLogged = await SignInService().trySignInGoogle();
    if (!context.mounted) {
      return;
    }
    if (hasLogged) {
       Navigator.pushReplacement(context,
        MaterialPageRoute(builder: ((context) => const MyHomePage())
        )
      );
    } else {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (c) => const LoginPage())
        // Login
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tryLogin(),
      builder: (context, snapshot) {
        return const Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("SummerClass 2024", style: TextStyle(color: Colors.grey, fontSize: 32, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 50,),
              CircularProgressIndicator(color: Colors.grey),
            ],
          ),
        );
      }
    );
  }
}