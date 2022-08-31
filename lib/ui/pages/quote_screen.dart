import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:quotes/ui/common/quote_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/quote.dart';

class QuotesScreen extends StatefulWidget {

  const QuotesScreen({Key? key}) : super(key: key);
  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {

  bool dataLoaded = false;

  late final Box box;

  @override
  initState() {
    super.initState();
    box = Hive.box('quoteBox');
    if(box.length != 365) {
      readJson();
    }
  }

  @override
  Widget build(BuildContext context) {

    PageController pageController =  PageController(initialPage: getFocusPage()); // Set this value to the Date

    return
      dataLoaded ==false ?
      Container(
        color: Colors.redAccent,
        child: const Center(
             child:  SpinKitRing(
             color: Colors.white,
             size: 70.0 )),
      ) :
      PageView.builder(
        controller: pageController,
        itemCount: box.length,
        itemBuilder: (context,index){
          return QuoteWidget(
            title: box.getAt(index).title,
            quote: box.getAt(index).text,
          );
        });
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/quotes.json');
    final data = await json.decode(response);

    List quotes = [];
    quotes = data["quotes"];

    for(var q in quotes){
      await _addQuote(int.parse(q['id']),q['text'],q['title']);
    }

    setState(() {
      dataLoaded = true;
    });
  }

  _addQuote(int quoteId, String quoteText,String quoteTitle) async {
    Quote newQuote = Quote(
      id: quoteId,
      title: quoteTitle,
      text: quoteText,
      favourite: false
    );
    box.add(newQuote);
  }

  getFocusPage(){
    int result =1;

    final now = DateTime.now();

    bool isLeapYear = checkLeapYear(now.year);

    if(now.month == 1) return now.day;

    int cumulativeDays = 0;

    for(var i = 2 ; i < now.month; i++){

      switch(i) {

        case 2: {
          if(isLeapYear) {
            cumulativeDays += 29;
          } else {
            cumulativeDays +=28;
          }
        }
        break;

        case 3: {
          cumulativeDays +=31;
        }
        break;

        case 4: {
          cumulativeDays +=30;
        }
        break;

        case 5: {
          cumulativeDays +=31;
        }
        break;

        case 6: {
          cumulativeDays +=30;
        }
        break;

        case 7: {
          cumulativeDays +=31;
        }
        break;

        case 8: {
          cumulativeDays +=31;
        }
        break;

        case 9: {
          cumulativeDays +=30;
        }
        break;

        case 10: {
          cumulativeDays +=31;
        }
        break;

        case 11: {
          cumulativeDays +=30;
        }
        break;

        case 12: {
          cumulativeDays +=31;
        }
        break;
      }
    }

    result = cumulativeDays + now.day;

    if(result >365) return 0;

    return result-1;
  }

  checkLeapYear(int year){

    bool result = false;

    if(year % 400 == 0) {
      result =  true;
    } else if (year % 100 == 0) {
      result =  false;
    } else if (year % 4 == 0) {
      result =  true;
    } else {
      result = false;
    }
    return result;
  }
}
