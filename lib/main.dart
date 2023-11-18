import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'books_splash.dart';
import 'controller/app/home_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
      ],
      child: MaterialApp(
        title: 'Vani',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "SourceSansPro",
        ),
        home: const BooksSplash(),
      ),
    );
  }
}
