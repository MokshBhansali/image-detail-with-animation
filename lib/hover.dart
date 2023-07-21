import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HoverCard extends StatefulWidget {
  const HoverCard({super.key, required this.image});
  final String image;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  double height = 500;
  double width = 400;

  late AnimationController _controller;
  late Animation<double> _rotateAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _headTextOpacityAnimation;
  late Animation<double> _subTextOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _rotateAnimation = Tween(begin: pi / 2, end: 0.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, .5, curve: Curves.fastOutSlowIn)));

    _colorAnimation = ColorTween(
            begin: Colors.transparent, end: Colors.black.withOpacity(.6))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _headTextOpacityAnimation = Tween(begin: .0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, .8, curve: Curves.ease)));

    _subTextOpacityAnimation = Tween(begin: .0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1.0, curve: Curves.easeInCubic)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MouseRegion(
          onEnter: (event) => _controller.forward(),
          onExit: (event) => _controller.reverse(),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
                SizedBox(
                  height: height,
                  width: width / 2,
                  child: AnimatedBuilder(
                      animation: _rotateAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotateAnimation.value,
                          alignment: Alignment.topRight,
                          child: Container(
                            color: _colorAnimation.value,
                          ),
                        );
                      }),
                ),
                Positioned(
                  right: 0.0,
                  child: SizedBox(
                    height: height,
                    width: width / 2,
                    child: AnimatedBuilder(
                        animation: _rotateAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            alignment: Alignment.bottomLeft,
                            angle: _rotateAnimation.value,
                            child: Container(
                              color: _colorAnimation.value,
                            ),
                          );
                        }),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                          animation: _headTextOpacityAnimation,
                          builder: (context, child) {
                            return Container(
                              alignment: Alignment(
                                  .0, _headTextOpacityAnimation.value - 1.1),
                              height: 80,
                              child: FadeTransition(
                                opacity: _headTextOpacityAnimation,
                                child: Text(
                                  "Heading",
                                  style: GoogleFonts.kaushanScript(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            );
                          }),
                      AnimatedBuilder(
                          animation: _subTextOpacityAnimation,
                          builder: (context, child) {
                            return Container(
                              alignment: Alignment(
                                  .0, _subTextOpacityAnimation.value - 1.1),
                              height: 120,
                              child: FadeTransition(
                                opacity: _subTextOpacityAnimation,
                                child: SizedBox(
                                  width: width - 100,
                                  child:  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                    style: GoogleFonts.kaushanScript(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
