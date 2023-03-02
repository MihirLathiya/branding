import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  CarouselController carouselController = CarouselController();

  int selectCarouselPage = 0;

  List<String> pages = ['Hello', 'Hello1', 'Hello3'];
  List<Map<String, dynamic>> upcomingEventList = [
    {
      'image': 'https://wallpapercave.com/dwp1x/wp7133689.jpg',
      'date': '14 JAN',
    },
    {
      'image': 'https://wallpapercave.com/dwp1x/wp11910934.jpg',
      'date': '26 JAN',
    },
    {
      'image': 'https://wallpapercave.com/fuwp/uwp3318999.webp',
      'date': '14 FEB',
    },
    {
      'image': 'https://wallpapercave.com/dwp1x/wp10760239.jpg',
      'date': '8 MAR',
    },
  ];

  /// UPDATE CarouselPage INDEX
  updateCarouselPage(int value) {
    selectCarouselPage = value;
    update();
  }
}
