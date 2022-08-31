import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quotes/ui/model/quote.dart';
import 'package:quotes/ui/pages/quote_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async{
    // Initialize hive
    await Hive.initFlutter();
    // Registering the adapter
    Hive.registerAdapter(QuoteAdapter());
    // Opening the box
    await Hive.openBox('quoteBox');
    runApp(const MyApp());
  });
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

