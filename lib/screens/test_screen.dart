import 'package:flutter/material.dart';

import '../widgets/house_cards.dart';

class TestHomeScreen extends StatefulWidget {
  const TestHomeScreen({super.key});

  @override
  State<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  late final Animation<double> appbarSize;
  late final Animation<double> appbarOpacity;

  late final Animation<double> welcomeOpacity;

  late final Animation<double> titleFade;

  late final Animation<double> buyRentScale;

  late final Animation<Offset> mainSlide;

  late final Animation<double> secondaryFade;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    appbarSize = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.15, curve: Curves.easeIn),
      ),
    );

    appbarOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.13, 0.15, curve: Curves.easeIn),
      ),
    );

    welcomeOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.15, 0.18, curve: Curves.easeIn),
      ),
    );

    titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.18, 0.24, curve: Curves.easeIn),
      ),
    );

    buyRentScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.18, 0.32, curve: Curves.easeOutCirc),
      ),
    );

    mainSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.32, 0.40, curve: Curves.decelerate),
      ),
    );

    secondaryFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.40, 0.50, curve: Curves.decelerate),
      ),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orangeAccent[100]!,
              Colors.orangeAccent[300]!
            ],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          height: 56,
                          width: appbarSize.value * 196,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Opacity(
                            opacity: appbarOpacity.value,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on, color: Color(0xffA5957E), size: 18),
                                SizedBox(width: 4),
                                Flexible(
                                  child: Text("Saint Petersburg", style: TextStyle(color: Color(0xffA5957E), fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: appbarSize.value,
                          alignment: Alignment.center,
                          child: const CircleAvatar(
                            radius: 32,
                            backgroundColor: Color(0xffFC9E12),
                            backgroundImage: AssetImage('assets/user_image.png'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Opacity(
                      opacity: welcomeOpacity.value,
                      child: const Text('Hi, Marina', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xffA5957E))),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: titleFade.value * 96,
                      child: const Text("let's select your\nperfect place", style: TextStyle(fontSize: 40, color: Color(0xff232220), height: 1)),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Transform.scale(
                            scale: buyRentScale.value,
                            child: buyShape((buyRentScale.value * 1034).toInt()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Transform.scale(
                            scale: buyRentScale.value,
                            child: rentShape((buyRentScale.value * 2122).toInt()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SlideTransition(
              position: mainSlide,
              child: DraggableScrollableSheet(
                  initialChildSize: 0.43,
                  minChildSize: 0.43,
                  maxChildSize: 0.68,
                  builder: (BuildContext context, ScrollController $controller) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      controller: $controller,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HouseCard.landscape(
                            imagePath: 'assets/apartment_1.jpg',
                            bannerText: "Gladkova St., 25",
                            textVisibility: secondaryFade.value == 1 ? secondaryFade.value : 0,
                            bannerWidth: secondaryFade.value * MediaQuery.of(context).size.width,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: HouseCard.portrait(
                                  imagePath: 'assets/apartment_2.jpg',
                                  bannerText: "Gladkova St., 25",
                                  textVisibility: secondaryFade.value == 1 ? secondaryFade.value : 0,
                                  bannerWidth: secondaryFade.value * MediaQuery.of(context).size.width,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    HouseCard.small(
                                      imagePath: 'assets/apartment_1.jpg',
                                      bannerText: "Gladkova St., 25",
                                      textVisibility: secondaryFade.value == 1 ? secondaryFade.value : 0,
                                      bannerWidth: secondaryFade.value * MediaQuery.of(context).size.width,
                                    ),
                                    const SizedBox(height: 10),
                                    HouseCard.small(
                                      imagePath: 'assets/apartment_3.jpg',
                                      bannerText: "Gladkova St., 25",
                                      textVisibility: secondaryFade.value == 1 ? secondaryFade.value : 0,
                                      bannerWidth: secondaryFade.value * MediaQuery.of(context).size.width,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buyShape (int val) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xffFC9E12),
        shape: BoxShape.circle,
      ),
      child: Column(
        children: [
          const Text(
            "BUY",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            formatNumber(val),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 36,
            ),
          ),
          const Text(
            "offers",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget rentShape (int val) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'RENT',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xffA5957E),
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            formatNumber(val),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.grey,
              fontSize: 36,
            ),
          ),
          const Text(
            'offers',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
        ],
      ),
    );
  }

  static String formatNumber(int number) {
    return number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
  }
}

