import 'package:flutter/material.dart';

class HouseCard extends StatelessWidget {
  const HouseCard({
    required this.imagePath,
    required this.bannerWidth,
    required this.bannerText,
    required this.textVisibility,
    this.bannerTextAlign = Alignment.centerLeft,
    this.cardHeight,
    this.onErrorImagePath = 'assets/images/fallback.jpg', // Fallback image
    super.key,
  });

  final String imagePath;
  final double bannerWidth;
  final String bannerText;
  final double textVisibility;
  final Alignment bannerTextAlign;
  final double? cardHeight;
  final String onErrorImagePath; // Path to fallback image

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: cardHeight ?? MediaQuery
          .of(context)
          .size
          .height * 0.3,
      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) =>
              AssetImage(onErrorImagePath), // Fallback
        ),
      ),
      child: bannerArea(context),
    );
  }

  Widget bannerArea(BuildContext context) {
    double adjustedBannerWidth = bannerWidth + 55;
    double responsiveFontSize = MediaQuery
        .of(context)
        .size
        .width < 360 ? 10 : 12; // Responsive font size

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      width: adjustedBannerWidth,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.7),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
      ),
      child: Stack(
        children: [
          Align(
            alignment: bannerTextAlign,
            child: Opacity(
              opacity: textVisibility,
              child: Text(
                bannerText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff232220),
                  fontSize: responsiveFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  factory HouseCard.landscape({
    required String imagePath,
    required double bannerWidth,
    required String bannerText,
    required double textVisibility,
  }) {
    return HouseCard(
      imagePath: imagePath,
      bannerWidth: bannerWidth,
      bannerText: bannerText,
      textVisibility: textVisibility,
      bannerTextAlign: Alignment.center,
      cardHeight: 200,
    );
  }

  factory HouseCard.portrait({
    required String imagePath,
    required double bannerWidth,
    required String bannerText,
    required double textVisibility,
  }) {
    return HouseCard(
      imagePath: imagePath,
      bannerWidth: bannerWidth,
      bannerText: bannerText,
      textVisibility: textVisibility,
      cardHeight: 400,
    );
  }

  factory HouseCard.small({
    required String imagePath,
    required double bannerWidth,
    required String bannerText,
    required double textVisibility,
  }) {
    return HouseCard(
      imagePath: imagePath,
      bannerWidth: bannerWidth,
      bannerText: bannerText,
      textVisibility: textVisibility,
      cardHeight: 195,
    );
  }

}
