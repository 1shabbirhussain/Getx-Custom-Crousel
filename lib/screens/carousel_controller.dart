// controller.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'carousel_model.dart';

class HomeController extends GetxController {
  final HomeModel _model = HomeModel();
  late Timer _timer;
  late Timer _innerTimer;
  late PageController _pageController;
  int currentPage = 0;

  HomeModel get model => _model;
  Timer get timer => _timer;
  Timer get innertimer => _innerTimer;
  PageController get pageController => _pageController;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    // _startInnerTimer();
    _pageController = PageController(initialPage: 0);
  }
//  IT KEEPS ON RUNNING THROHGHOUT THE APPLICATION AND MAKE SURE THE IMAGE CHANGER TIMER TO RESTART AGAIN WHEN NAVIGATE BACK TO THE PAGE WITHOUT RELOADING
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_innerTimer == null || !_innerTimer.isActive) {
        _startInnerTimer();
      }
    });
  }
//  IT START TIMER BY WHICH IMAGES INDEXES ARE CHANGING
  void _startInnerTimer() {
    _innerTimer = Timer.periodic(Duration(seconds: 3), (Timer innerTimer) {
      if (currentPage < model.images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  @override
  void onClose() {
    _timer.cancel();
    _innerTimer.cancel();
    _pageController.dispose();
    super.onClose();
  }
}
