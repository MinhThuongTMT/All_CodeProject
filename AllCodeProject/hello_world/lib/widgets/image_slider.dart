import 'package:flutter/material.dart';
import 'dart:async';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;
  final List<String> _imageList = [
    'assets/images/health1.jpg',
    'assets/images/health2.jpg',
    'assets/images/health3.png',
  ];

  late Timer _timer;
  late PageController
      _pageController; // Sử dụng PageController để điều khiển trang

  @override
  void initState() {
    super.initState();
    // Khởi tạo PageController
    _pageController = PageController(initialPage: _currentIndex);

    // Cài đặt timer tự động chuyển ảnh mỗi 5 giây
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentIndex < _imageList.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      // Di chuyển tới trang tiếp theo
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Huỷ timer khi widget không còn sử dụng
    _pageController.dispose(); // Huỷ page controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController, // Áp dụng PageController
      itemCount: _imageList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_imageList[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
