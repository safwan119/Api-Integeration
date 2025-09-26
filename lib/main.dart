import 'package:api_integeration/View/splash_screen.dart';
import 'package:api_integeration/another_example_api/api_example_2.dart';
import 'package:api_integeration/another_example_api/api_upload_image.dart';
import 'package:flutter/material.dart';

import 'another_example_api/api_example1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
