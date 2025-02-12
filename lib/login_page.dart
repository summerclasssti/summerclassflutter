import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:summerclass/home_page.dart';
import 'package:summerclass/sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  loginGoogle() async {
    // FirebaseAuth.
    try {
      await SignInService().signInGoogle();
      
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
      return;
    }
    // print(FirebaseAuth.instance.currentUser!.email);

    if (!context.mounted) {
      return;
    }
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MyHomePage())
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("SummerClass 2024", style: TextStyle(fontSize: 32, color: Colors.grey, fontWeight: FontWeight.bold),),
            SignInButton(
              Buttons.Google,
              onPressed: loginGoogle
            ),
          ],
        ),
      )
    );
  }
}