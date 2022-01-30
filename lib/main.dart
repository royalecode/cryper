import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cryper/Authenticate.dart';
import 'package:cryper/AuthenticationProvider.dart';
import 'package:cryper/constantes_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationProvider?>(
            create: (_) => AuthenticationProvider(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
            context
                .read<AuthenticationProvider>()
                .authState,
            initialData: null,
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cryper app',
          themeMode:ThemeMode.dark,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme(
              primary: lightBlueColor,
              onPrimary: Color(0xFFFFFFFF),
              primaryVariant: lightBlueColor,
              secondary: accentColor,
              secondaryVariant: accentColor,
              onSecondary: Color(0xFF2D2D2D),
              surface: lightColor,
              onSurface: Color(0xFF2D2D2D),
              background: primaryColor,
              onBackground: Color(0xFF2D2D2D),
              error: Colors.red,
              onError: Color(0xFF2D2D2D),
              brightness: Brightness.light,
            ),
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              headline1: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 36.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter"),
              headline2: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 29.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Inter"),
              headline4: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"),
              headline5: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"),
              headline6: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Inter"),
              subtitle1: TextStyle(
                  color: Color(0xFF747E98),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter"),
              subtitle2: TextStyle(
                  color: Color(0xFF747E98),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter"),
              bodyText1: TextStyle(
                  color: Color(0xFF747E98),
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Inter"),
              bodyText2: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter"),
            ),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: primaryColor,
            colorScheme: ColorScheme(
                primary: lightBlueColor,
                onPrimary: Colors.white,
                primaryVariant: lightBlueColor,
                secondary: accentColor,
                secondaryVariant: accentColor,
                onSecondary: Colors.white,
                surface: primaryColor,
                onSurface: Colors.white,
                background: primaryColor,
                onBackground: Colors.white,
                error: Colors.red,
                onError: Colors.white,
                brightness: Brightness.dark),
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              headline1: TextStyle(
                  color: Color(0xFFffffff),
                  fontSize: 36.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter"),
              headline2: TextStyle(
                  color: Color(0xFFffffff),
                  fontSize: 29.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Inter"),
              headline4: TextStyle(
                  color: Color(0xFFffffff),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"),
              headline5: TextStyle(
                  color: Color(0xFFffffff),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"),
              headline6: TextStyle(
                  color: Color(0xFFffffff),
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Inter"),
              subtitle1: TextStyle(
                  color: Color(0xFF747E98),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter"),
              subtitle2: TextStyle(
                  color: Color(0xFF747E98),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter"),
              bodyText1: TextStyle(
                  color: Color(0xFF747E98),
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Inter"),
              bodyText2: TextStyle(
                  color: Color(0xFFffffff),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter"),
            ),
          ),
          home: AnimatedSplashScreen(
            nextScreen: Authenticate(),
            splash: Center(
              child: Hero(
                tag: "logo",
                child: SvgPicture.asset(
                  Theme
                      .of(context)
                      .brightness == Brightness.light
                      ? "assets/images/logoCryperLight.svg"
                      : "assets/images/logoCryper.svg",
                ),
              ),
            ),
            duration: 1000,
            pageTransitionType: PageTransitionType.fade,
            splashTransition: SplashTransition.fadeTransition,
            // backgroundColor: Color(0xFF191D2D),
          ),
        ));
  }
}


