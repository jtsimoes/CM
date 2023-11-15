import 'package:go_router/go_router.dart';
//import "package:whats_up/utils/globals.dart";
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Something went wrong, try going back to the home page!",
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Icon(Icons.home),
            ),
          ],
        ),
      ),
    );
  }
}
