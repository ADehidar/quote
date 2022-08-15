import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes/ui/common/quote_widget.dart';

class QuotesScreen extends StatefulWidget {

  const QuotesScreen({Key? key}) : super(key: key);
  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {

  List _quotes = [];
  bool dataLoaded = false;

  @override
  initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {

    PageController pageController =  PageController(initialPage: 5); // Set this value to the Date

    return
      dataLoaded ==false ?
      const CircularProgressIndicator():
      PageView.builder(
        controller: pageController,
        itemCount: _quotes.length,
        itemBuilder: (context,index){
          return Quote(
            title: getQuoteTitle(index),
            quote: getQuote(index),
          );
        });
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/quotes.json');
    final data = await json.decode(response);
    setState(() {
      _quotes = data["quotes"];
      dataLoaded = true;
    });
  }

  getQuote(int index){
    Map<String, dynamic> quote = new Map<String, dynamic>.from(_quotes[index]);
    return quote['text'];

  }

  getQuoteTitle(int index){
    Map<String, dynamic> quote = new Map<String, dynamic>.from(_quotes[index]);
    return quote['title'];

  }
}
