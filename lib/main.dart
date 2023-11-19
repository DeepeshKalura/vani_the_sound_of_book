import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'books_splash.dart';
// import 'controller/firebase/api_to_firebase.dart';
import 'controller/firebase/api_to_firebase.dart';
import 'firebase_options.dart';
import 'controller/app/home_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ApiToFirebase apiToFirebase = ApiToFirebase();
  await apiToFirebase.discoverBooks();
  await apiToFirebase.addBookToFirebase();
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
        home: const
            // HomeScreen(),
            BooksSplash(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vani"),
      ),
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
