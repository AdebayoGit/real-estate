import 'package:flutter/material.dart';

class Marker extends StatelessWidget {
  const Marker({
    required this.value,
    required this.textOpacity,
    required this.iconOpacity,
    required this.width,
    required this.withoutLayer,
    super.key,
  });

  final String value;
  final double textOpacity;
  final double iconOpacity;
  final double width;
  final bool withoutLayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: width,
      decoration: decoration(),
      child: content(),
    );
  }

  BoxDecoration decoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      color: Color(0xffFC9E12),
    );
  }

  Widget content() {
    return Visibility(
      visible: withoutLayer,
      replacement: Opacity(
        opacity: textOpacity,
        child: Text(
          value,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      child: Opacity(
        opacity: iconOpacity,
        child: const Icon(
          Icons.apartment,
          color: Colors.white,
        ),
      ),
    );
  }
}
