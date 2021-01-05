import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Io copierei i temi da questo link (e poi adatterei alla nostra app): https://medium.com/flutter-community/themes-in-flutter-part-3-71361ffdc344
//CONSULTARE: https://material.io/design/color/the-color-system.html#color-theme-creation
// e questo per una sintesi: https://techieblossom.com/theming-in-flutter/
//Usare gli "on" colors

class AppThemes {
  static String appName = "Papp_Fornitore";

  AppThemes._();

  static final TextStyle lightScreenHeadingStyle = GoogleFonts.poppins(
      textStyle: TextStyle(fontSize: 48.0, color: lightText));
//TextStyle(fontSize: 48.0, letterSpacing: 1.2, color: lightOnPrimary);
  static final TextStyle lightScreenTaskNameStyle = GoogleFonts.poppins(
      textStyle: TextStyle(fontSize: 20.0, color: lightText));
  static final TextStyle lightScreenTaskDurationStyle = GoogleFonts.poppins(
      textStyle: TextStyle(fontSize: 16.0, color: lightText));
  static final TextStyle lightTitle = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  ));
  static final TextStyle lightSubtitle = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: Colors.white70,
    fontSize: 18.0,
  ));
  static Color iconColor = Colors.redAccent.shade200;

  //Colors for theme
  static Color lightPrimaryVariant = Color(0xff141414);
  static Color lightSecondary = Colors.green[100];
  static const Color lightOnPrimary = Colors.black;
  static const Color lightOnSecondary = Colors.white;
  static const Color lightScaffoldBG = Color(0xffffffff); //0xffeeefef
  static Color lightBG = Color(0xffeeefef);
  static Color lightPrimary = Colors.deepPurple[300];
  static Color lightText = Color(0xfeeefef);
  static Color lightAccent = Colors.deepPurple[300];
  static Color lightAppBar = Color(0xffffffff);
  static const Color lightIcon = Colors.black54;

  static Color ratingBG = Colors.yellow[600];
  static Color darkAccent = Color(0xffff9e0d);
  static Color darkPrimary = Colors.black;
  static Color darkPrimaryVariant = Colors.black;
  static Color darkBG = Colors.black;

  static Color darkAppBar = Color(0xff141414);
  static const Color darkScaffoldBG = Color(0xff141414);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightScaffoldBG,
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightPrimaryVariant,
    visualDensity: VisualDensity
        .adaptivePlatformDensity, //visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
    appBarTheme: AppBarTheme(
      color: lightAppBar,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightText,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      iconTheme: IconThemeData(
        color: lightIcon,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: lightPrimary,
      onPrimary: lightOnPrimary,
      primaryVariant: lightPrimaryVariant,
      secondary: lightSecondary,
      onSecondary: lightOnSecondary,
      // secondaryVariant: accent1,
      // background: bg1,
      // surface: bg1,
      // onBackground: txtColor,
      // onSurface: txtColor,
      error: Colors.red.shade400,
      onError: Colors.white70,
    ),
    cardTheme: CardTheme(
      color: lightPrimary, //Colors.teal,
    ),
    iconTheme: IconThemeData(
      color: lightAccent,
    ),
    // textTheme: GoogleFonts.latoTextTheme(),
    textTheme: TextTheme(
      headline6: lightTitle,
      subtitle2: lightSubtitle,
      headline5: lightScreenHeadingStyle,
      bodyText2: lightScreenTaskNameStyle,
      bodyText1: lightScreenTaskDurationStyle,
    ),
  );

  static ThemeData darkmodeTheme = ThemeData(
    scaffoldBackgroundColor: darkScaffoldBG,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    cursorColor: darkPrimaryVariant,
    visualDensity: VisualDensity
        .adaptivePlatformDensity, //visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
    appBarTheme: AppBarTheme(
      color: darkAppBar,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightText,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      iconTheme: IconThemeData(
        color: lightIcon,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: lightPrimary,
      onPrimary: lightOnPrimary,
      primaryVariant: lightPrimaryVariant,
      secondary: lightSecondary,
      onSecondary: lightOnSecondary,
      // secondaryVariant: accent1,
      // background: bg1,
      // surface: bg1,
      // onBackground: txtColor,
      // onSurface: txtColor,
      error: Colors.red.shade400,
      onError: Colors.white70,
    ),
    cardTheme: CardTheme(
      color: lightPrimary, //Colors.teal,
    ),
    iconTheme: IconThemeData(
      color: lightAccent,
    ),
    // textTheme: GoogleFonts.latoTextTheme(),
    textTheme: TextTheme(
      headline6: lightTitle,
      subtitle2: lightSubtitle,
      headline5: lightScreenHeadingStyle,
      bodyText2: lightScreenTaskNameStyle,
      bodyText1: lightScreenTaskDurationStyle,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBG,
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    cursorColor: darkAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      color: lightBG,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );

//   static appTheme() {
//     return ThemeData(
//         backgroundColor: lightBG,
//         primaryColor: lightPrimary,
//         accentColor: lightAccent,
//         cursorColor: lightAccent,
//         scaffoldBackgroundColor: lightBG,
//         appBarTheme: AppBarTheme(
//           color: Colors.teal,
//           iconTheme: IconThemeData(
//             color: lightOnPrimary,
//           ),
//           textTheme: TextTheme(
//             title: TextStyle(
//               color: darkBG,
//               fontSize: 18.0,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
// //      iconTheme: IconThemeData(
// //        color: lightAccent,
// //      ),
//         ));
//   }
}
