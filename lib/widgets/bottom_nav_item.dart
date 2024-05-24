import 'package:flutter/material.dart';

class BottomNavItem extends StatefulWidget {
  const BottomNavItem({
    required this.iconData,
    required this.isActive,
    required this.onPressed,
    super.key,
  });

  final IconData iconData;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  State<BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<BottomNavItem> with TickerProviderStateMixin {
  late final AnimationController animationCtrl;
  late final Animation<double> initialIconSize;
  late final Animation<double> initialIconBorder;
  late final Animation<double> expandedIconSize;
  late final Animation<double> expandedIconBorder;
  bool displayIconOutline = false;
  bool displayExpandedBorder = false;

  @override
  void initState() {
    super.initState();

    animationCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() {
          displayIconOutline = true;

          Future.delayed(const Duration(milliseconds: 375), () {
            displayExpandedBorder = true;
          });

          Future.delayed(const Duration(milliseconds: 900), () {
            displayExpandedBorder = false;
          });

          Future.delayed(const Duration(milliseconds: 1125), () {
            displayIconOutline = false;
          });
        });
      }
    });

    initialIconSize = Tween<double>(begin: 58, end: 40).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: const Interval(
          0.0,
          0.25,
          curve: Curves.easeIn,
        ),
      ),
    );

    initialIconBorder = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1, end: 8),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 8, end: 1),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: const Interval(0.0, 0.75, curve: Curves.easeIn),
      ),
    );

    expandedIconSize = Tween<double>(begin: 40, end: 58).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: const Interval(
          0.25,
          0.50,
          curve: Curves.easeIn,
        ),
      ),
    );

    expandedIconBorder = Tween<double>(begin: 8, end: 0).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: const Interval(
          0.25,
          0.50,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onPressed();
        animationCtrl
          ..reset()
          ..forward();
      },
      child: AnimatedBuilder(
        animation: animationCtrl,
        builder: (context, child) => Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 375),
              curve: Curves.decelerate,
              alignment: Alignment.center,
              height: displayIconOutline ? 40 : widget.isActive ? 52 : 40,
              width: displayIconOutline ? 40 : widget.isActive ? 52 : 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: displayIconOutline
                    ? Colors.transparent
                    : widget.isActive
                    ? Colors.orange
                    : const Color(0xFF000000),
              ),
              child: Icon(
                widget.iconData,
                color: Colors.white,
              ),
            ),
            widget.isActive
                ? Container(
              padding: const EdgeInsets.all(2),
              height: initialIconSize.value,
              width: initialIconSize.value,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: displayIconOutline ? Colors.white : Colors.transparent,
                  width: initialIconBorder.value,
                ),
              ),
            )
                : const SizedBox.shrink(),
            widget.isActive
                ? Container(
              padding: const EdgeInsets.all(2),
              height: expandedIconSize.value,
              width: expandedIconSize.value,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: displayExpandedBorder ? Colors.white : Colors.transparent,
                  width: expandedIconBorder.value,
                ),
              ),
            ) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
