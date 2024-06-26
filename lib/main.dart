import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/carousel_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "My Carousel",
        debugShowCheckedModeBanner: false,
        home: MyCustomCarousel(),
        );
  }
}
