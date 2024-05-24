import 'package:flutter/material.dart';

import '../widgets/marker.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final GlobalKey key = GlobalKey();
  late final AnimationController _animationController;

  late final Animation<double> _scaleAnimation;
  late final Animation<double> _markerAnimation;
  late final Animation<double> _textOpacity;

  late final AnimationController _markerController;

  late final Animation<double> _widthAnimation;
  late final Animation<double> _iconAnimation;

  late double markerWidth;
  late bool withoutLayer;

  @override
  void initState() {
    super.initState();
    markerWidth = 96;
    withoutLayer = false;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.40, curve: Curves.easeIn),
      ),
    );

    _markerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.50, 0.80, curve: Curves.easeIn),
      ),
    );

    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.80, 1.0, curve: Curves.easeIn),
      ),
    );

    _markerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _widthAnimation = Tween<double>(begin: markerWidth, end: 48).animate(
      CurvedAnimation(
        parent: _markerController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    _iconAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 0.5),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.5, end: 1),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _markerController,
        curve: const Interval(0.6, 0.8, curve: Curves.easeIn),
      ),
    );

    // Start the main animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _markerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _animationController,
        _markerController,
      ]),
      builder: (context, child) => Stack(
        children: [
          Image.asset(
            'assets/Map-VLF.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black
                .withOpacity(0.5), // Adjust opacity to control darkness
            colorBlendMode: BlendMode.darken,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 80,
                left: 32,
                right: 32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(32),
                          ),
                        ),
                        height: 56,
                        width: 196,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: Color(0xff757575),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Saint Petersburg",
                              style: TextStyle(
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    alignment: Alignment.center,
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.tune_rounded,
                        color: Color(0xff757575),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.40,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: 72,
                    child: Transform.scale(
                      scale: _markerAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: Marker(
                        value: "10,3 mn P",
                        textOpacity: _textOpacity.value,
                        width: _widthAnimation.value,
                        withoutLayer: markerWidth == 48,
                        iconOpacity: _iconAnimation.value,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 88,
                    top: 58,
                    child: Transform.scale(
                      scale: _markerAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: Marker(
                        value: "10,3 mn P",
                        textOpacity: _textOpacity.value,
                        width: _widthAnimation.value,
                        withoutLayer: markerWidth == 48,
                        iconOpacity: _iconAnimation.value,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 32,
                    top: 80,
                    child: Transform.scale(
                      scale: _markerAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: Marker(
                        value: "10,3 mn P",
                        textOpacity: _textOpacity.value,
                        width: _widthAnimation.value,
                        withoutLayer: markerWidth == 48,
                        iconOpacity: _iconAnimation.value,
                      ),
                    ),
                  ),

                  // Bottom 3 map bubbles
                  Positioned(
                    right: 56,
                    bottom: 0,
                    child: Transform.scale(
                      scale: _markerAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: Marker(
                        value: "10,3 mn P",
                        textOpacity: _textOpacity.value,
                        width: _widthAnimation.value,
                        withoutLayer: markerWidth == 48,
                        iconOpacity: _iconAnimation.value,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 64,
                    bottom: 80,
                    child: Transform.scale(
                      scale: _markerAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: Marker(
                        value: "10,3 mn P",
                        textOpacity: _textOpacity.value,
                        width: _widthAnimation.value,
                        withoutLayer: markerWidth == 48,
                        iconOpacity: _iconAnimation.value,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 32,
                    bottom: 128,
                    child: Transform.scale(
                      scale: _markerAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: Marker(
                        value: "10,3 mn P",
                        textOpacity: _textOpacity.value,
                        width: _widthAnimation.value,
                        withoutLayer: markerWidth == 48,
                        iconOpacity: _iconAnimation.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                bottom: 96,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.scale(
                        key: key,
                        scale: _scaleAnimation.value,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            final renderBox = key.currentContext
                                ?.findRenderObject() as RenderBox;
                            final offset = renderBox.localToGlobal(Offset.zero);
                            await showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                offset.dx - 40,
                                offset.dy - 50,
                                MediaQuery.of(context).size.width - offset.dx,
                                MediaQuery.of(context).size.height -
                                    offset.dy -
                                    60,
                              ),
                              color: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              popUpAnimationStyle: AnimationStyle(
                                  curve: Curves.slowMiddle,
                                  duration: const Duration(milliseconds: 500)),
                              items: [
                                const PopupMenuItem(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.verified_user,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Cosy areas'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    _markerController.forward();
                                    setState(() {
                                      markerWidth = 48;
                                    });
                                  },
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.account_balance_wallet,
                                        color: markerWidth == 48
                                            ? Colors.orange
                                            : null,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                          color: markerWidth == 48
                                              ? Colors.orange
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_cart,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Infrasturce',
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    _markerController.reverse();
                                    setState(() {
                                      withoutLayer = true;
                                      markerWidth = 96;
                                    });
                                  },
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.layers,
                                        color: markerWidth == 96
                                            ? Colors.orange
                                            : null,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Without any layer',
                                        style: TextStyle(
                                          color: markerWidth == 96
                                              ? Colors.orange
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor:
                                const Color(0xff737373).withAlpha(128),
                            child: const Icon(
                              Icons.wallet,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor:
                              const Color(0xff737373).withAlpha(128),
                          child: const Icon(
                            Icons.near_me,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff737373).withAlpha(128),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32),
                        ),
                      ),
                      height: 56,
                      width: 168,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sort_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            "List of variants",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
