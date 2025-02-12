import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInService {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  SignInService();

  _createUserDoc() async {
    DocumentReference documentReference = FirebaseFirestore.instance.doc('/users/${FirebaseAuth.instance.currentUser!.uid}');
    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) return;

    documentReference.set(
      {
        'created_at': DateTime.now(),
        'updated_at': DateTime.now(),
        'email': FirebaseAuth.instance.currentUser!.email,
        'liked': [],
      }
    );
  }

  signInGoogle() async {
    var account = await _googleSignIn.signIn();
    var b = await account!.authentication;
    final authCredential = GoogleAuthProvider.credential(accessToken: b.accessToken, idToken: b.idToken);
    try {
      var u = await FirebaseAuth.instance.signInWithCredential(authCredential);
      await _createUserDoc();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<bool> trySignInGoogle() async {
    var account = await _googleSignIn.signInSilently();
    if (account == null) {
      return false;
    }
    var b = await account!.authentication;
    final authCredential = GoogleAuthProvider.credential(accessToken: b.accessToken, idToken: b.idToken);
    try {
      var u = await FirebaseAuth.instance.signInWithCredential(authCredential);
      await _createUserDoc();
    } catch (err) {
      debugPrint(err.toString());
    }
    return true;
  }

  logoutGoogle() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}