import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
       primarySwatch: primarySwatch,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.white,
      canvasColor: creamColor,
      buttonColor: Color(0xff3366ff),
      accentColor: Color(0xff3366ff),
      appBarTheme: AppBarTheme(
          // color: Colors.deepPurple,
          elevation: 0,
          backgroundColor: Color(0xff3366ff),
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: Theme.of(context).textTheme.copyWith(
              headline6:
                  context.textTheme.headline6?.copyWith(color: Colors.white))));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.black,
      canvasColor: darkCreamColor,
      buttonColor: lightBluishColor,
      accentColor: Colors.white,
      appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: Theme.of(context).textTheme.copyWith(
              headline6:
                  context.textTheme.headline6?.copyWith(color: Colors.white))));

  // Colors
  static Color creamColor = Color(0xfff5f5f5);
  static Color darkCreamColor = Vx.gray900;
  static Color darkBluishColor = Color(0xff403b58);
  static Color lightBluishColor = Vx.indigo500;
  static Color darkIndigo = Color(0xff0254a0);
  static Color successGreen = Color(0xff11aa20);

  static const MaterialColor primarySwatch = const MaterialColor( 
    0xff3366FF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
       50: const Color(0xffD6E4FF ),//10% 
      100: const Color(0xffD6E4FF),//20% 
      200: const Color(0xffADC8FF),//30% 
      300: const Color(0xff84A9FF),//40% 
      400: const Color(0xff6690FF),//50% 
      500: const Color(0xff3366FF),//60% 
      600: const Color(0xff254EDB),//70% 
      700: const Color(0xff1939B7),//80% 
      800: const Color(0xff102693),//90% 
      900: const Color(0xff091A7A),//100% 
    }, 
  ); 
}
