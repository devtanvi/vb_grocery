import 'package:flutter/material.dart';
import 'Route/route.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Nunito Sans",
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffEFFAEE)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: RouteScreen.routes,
    );
  }
}
