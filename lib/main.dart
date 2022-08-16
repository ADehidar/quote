import 'package:flutter/material.dart';
import 'package:quotes/ui/pages/quote_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:
      const Scaffold(

            body: SafeArea(
                child: QuotesScreen()
            ),
      ),
    );
  }
}

