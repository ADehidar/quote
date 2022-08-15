import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeText {
   static const _quoteTextStyle = TextStyle(
      fontWeight:  FontWeight.w700,
      color: Colors.white,
      fontStyle: FontStyle.italic,
   );

   static final quoteTextStyle = GoogleFonts.dosis(
      textStyle: _quoteTextStyle.copyWith(
          fontSize: ScreenUtil().setSp(20)),
   );

   static const _quoteTitleStyle = TextStyle(
      fontWeight:  FontWeight.w600,
      color: Colors.white,
      fontStyle: FontStyle.normal,
   );

   static final quoteTitleStyle = GoogleFonts.dosis(
      textStyle: _quoteTitleStyle.copyWith(
          fontSize: ScreenUtil().setSp(22)),
   );
}