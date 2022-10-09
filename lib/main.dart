import 'package:books/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';
import 'home_page.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => BookProvider(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home_page",
      routes: {
        "/home_page": (context) => HomePage(),
        "/book_detail": (context) => BookDetail(
          cover: '',
          title: '',
          description: '',
          release: '',
          pages: '',

        )
      },
    );
  }
}
