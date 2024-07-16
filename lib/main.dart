import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qnquizz/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDK-hikdQiujHp3RnzZl8Uzg1NwNfJjw7Y",
        appId: "1:384243493921:android:8c2f93425fc5c2425a4760",
        messagingSenderId: "384243493921",
        projectId: "qnquizz",
      ),
    );
    runApp(const QuizQn());
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
}

class QuizQn extends StatelessWidget {
  const QuizQn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
