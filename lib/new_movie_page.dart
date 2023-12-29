import 'package:flutter/material.dart';

class NewMoviePage extends StatelessWidget {
  const NewMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Novo filme"),
        centerTitle: true,
      ),
      body: const Placeholder(),
    );
  }
}
