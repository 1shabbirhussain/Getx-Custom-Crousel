// carousel.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asdfg/screens/details_view.dart';
import 'carousel_controller.dart';

class MyCustomCarousel extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Center(
                child: Text(
                  "Custom Carousel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1.0,
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  return PageView.builder(
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.model.images.length,
                    physics: const ClampingScrollPhysics(),
                    controller: controller.pageController,
                    itemBuilder: (context, index) {
                      return carouselView(controller, index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget carouselView(HomeController controller, int index) {
    return AnimatedBuilder(
      animation: controller.pageController,
      builder: (context, child) {
        double value = 0.0;
        if (controller.pageController.position.haveDimensions) {
          value = index.toDouble() - (controller.pageController.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
          // print("value $value index $index");
        }
        return Transform.rotate(
          angle: pi * value,
          child: carouselCard(controller.model.images[index]),
        );
      },
    );
  }

  Widget carouselCard(String image) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: image,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => DetailsScreen(image: image));
                  controller.innertimer.cancel();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding:  EdgeInsets.only(top: 20),
          child:  Text(
            "Title",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Sub-Title",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
