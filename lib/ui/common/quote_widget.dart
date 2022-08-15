import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/styleguide/theme_text.dart';
import 'package:random_color/random_color.dart';

class Quote extends StatelessWidget {

  final String quote;
  final String title;
  const Quote({Key? key,required this.quote, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context,designSize: const Size(369,690));
    var randomColor = RandomColor();

    return Container(
        width: ScreenUtil().screenWidth ,
        color: randomColor.randomColor(colorBrightness: ColorBrightness.dark),
        child: Column(
          children: [
            Expanded(
                child:
                Center(
                   child:
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                         child: Center(child: Text(title,style: ThemeText.quoteTitleStyle)),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 20,bottom: 20),
                         child: Image.asset(
                             color: Colors.white.withOpacity(0.4),
                             "assets/quotes_image.png",
                             width: ScreenUtil().setWidth(50),
                             height: ScreenUtil().setHeight(50)),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 20,right: 20),
                         child: Text(quote,style: ThemeText.quoteTextStyle),
                       ),
                     ],
                   )
                )
            )
          ],
        ),
    );
  }
}
