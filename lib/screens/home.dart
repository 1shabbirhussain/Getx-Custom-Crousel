import 'dart:async';
import 'dart:math';
import 'package:asdfg/screens/details.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> images = [
    "assets/images/fashion1.jpeg",
    "assets/images/fashion2.jpeg",
    "assets/images/fashion3.jpg",
    "assets/images/fashion4.png",
  ];
  // late PageController _pageController;
  // int _currentPage = 0; // Start from the duplicated first item
  late Timer _timer;
  late Timer _innerTimer;
  // late List<DataModel> _dataList;
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _dataList = List.from(dataList)
    //   ..insert(0, dataList.last)
    //   ..add(dataList.first);

    // _pageController =
    //     PageController(initialPage: _currentPage, viewportFraction: 0.8);
    _startTimer();
    _startInnerTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      // Check if the inner timer is not active or has been canceled
      if (_innerTimer == null || !_innerTimer.isActive) {
        // Start the inner timer
        _startInnerTimer();
      }
    });
  }

  void _startInnerTimer() {
    _innerTimer = Timer.periodic(Duration(seconds: 3), (Timer innerTimer) {
      if (currentPage < images.length - 1) {
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    _timer.cancel();
  }

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
                child: Text("Find Your Style",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 30)),
              ),
            ),
            AspectRatio(
              aspectRatio: 1.0,
              child: PageView.builder(
                  onPageChanged: (int index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  // itemCount: dataList.length,
                  itemCount: images.length,
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return carouselView(index);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget carouselView(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;
        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
          print("value $value index $index");
        }
        return Transform.rotate(
          angle: pi * value,
          // child: carouselCard(dataList[index]),
          child: carouselCard(images[index]),
        );
      },
    );
  }

  Widget carouselCard(image) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              // tag: data.imageName,
              tag: image,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                                image: image,
                              )));
                  _innerTimer.cancel();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          image: AssetImage(
                            // data.imageName,
                            image,
                          ),
                          fit: BoxFit.fill),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black26)
                      ]),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            // data.title,
            "data.title",
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            // "\$${data.price}",
            "\${data.price}",
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
