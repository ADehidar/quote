import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes/ui/common/quote_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    Map<String, dynamic> quote =  Map<String, dynamic>.from(_quotes[index]);
    return quote['text'];

  }

  getQuoteTitle(int index){
    Map<String, dynamic> quote =  Map<String, dynamic>.from(_quotes[index]);
    return quote['title'];

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
