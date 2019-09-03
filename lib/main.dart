import 'package:flutter/material.dart';
//local files
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/utils/appcolors.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: new ThemeData(
        primaryColor: AppColors.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context ) => HomePage(),
      },
    );
  }
}