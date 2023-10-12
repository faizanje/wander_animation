import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wander_animation/gen/assets.gen.dart';
import 'package:wander_animation/widgets/trip_data_card.dart';
import 'package:wander_animation/widgets/trip_details_pageview_item.dart';

import '../models/trip_data.dart';

class TripDetailsPage extends StatelessWidget {
  const TripDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TripDetailsBody();
  }
}

class TripDetailsBody extends StatefulWidget {
  const TripDetailsBody({super.key});

  @override
  State<TripDetailsBody> createState() => _TripDetailsBodyState();
}

class _TripDetailsBodyState extends State<TripDetailsBody> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final PageController _pageController;
  double offset = 0;
  late final Animation<double> _sizeXAnimation;
  late final Animation<double> _sizeYAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
      }
    });
    _pageController = PageController();
    _pageController.addListener(() {
      final screenHeight = MediaQuery.of(context).size.height;
      setState(() {
        offset = _pageController.offset / screenHeight;
      });
    });

    _sizeXAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(_animationController);

    _sizeYAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollNotification>(
      onNotification: (overscroll) {
        if (overscroll.overscroll < 0.5 &&
            overscroll.dragDetails != null &&
            overscroll.metrics.axisDirection == AxisDirection.down) {
          if (!_animationController.isAnimating) {
            _animationController.forward();
          }
        }
        return true;
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scaleX: _sizeXAnimation.value,
            scaleY: _sizeYAnimation.value,
            child: Scaffold(
              appBar: _buildAppBar(context),
              extendBodyBehindAppBar: true,
              body: Stack(
                children: [
                  _buildBackground(),
                  _buildHeader(),
                  PageView(
                    scrollDirection: Axis.vertical,
                    controller: _pageController,
                    children: [
                      const SizedBox.shrink(),
                      TripDetailsPageViewItem(),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      forceMaterialTransparency: true,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        style: IconButton.styleFrom(
          backgroundColor: Color.lerp(Colors.white, Colors.black.withOpacity(0.25), 1 - offset) ?? Colors.transparent,
        ),
        icon: Icon(Icons.close, color: Color.lerp(Colors.white, Colors.black, offset)),
      ),
      actions: [
        Opacity(
          opacity: offset,
          child: IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage(Assets.images.ellipse36.path),
            ),
            onPressed: () {},
          ),
        )
      ],
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: FractionalOffset(0, 1 - (offset)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const TitleSubtitle(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'date',
                    child: Opacity(
                      opacity: 1 - offset,
                      child: Text(
                        'May 5-15',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Color.lerp(Colors.white, Colors.black, offset),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Hero(
                      tag: 'title',
                      child: Text(
                        'Riding through the lands of the legends',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Color.lerp(Colors.white, Colors.black, offset),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildUserChips(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Wrap _buildUserChips() {
    return Wrap(
      children: [
        (name: 'Anne', imagePath: Assets.images.ellipse36.path),
        (name: 'Mike', imagePath: Assets.images.ellipse39.path),
        (name: 'Sophia', imagePath: Assets.images.ellipse37.path),
      ]
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(right: 4),
              child: Hero(
                tag: e.imagePath,
                child: Material(
                  type: MaterialType.transparency,
                  child: Chip(
                    backgroundColor: Color.lerp(Colors.white, Colors.grey[800], 1 - offset),
                    shape: const StadiumBorder(
                      side: BorderSide(
                          // color: Color.lerp(Colors.red, Colors.black26, height) ?? Colors.transparent,
                          ),
                    ),
                    side:
                        BorderSide(color: Color.lerp(Colors.transparent, Colors.black26, offset) ?? Colors.transparent),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        e.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.lerp(Colors.white, Colors.black, offset),
                        ),
                      ),
                    ),
                    avatar: CircleAvatar(
                      backgroundImage: AssetImage(e.imagePath),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Positioned _buildBackground() {
    return Positioned.fill(
      child: Hero(
        tag: 'bg',
        child: Opacity(
          opacity: 1 - ((offset >= 0.0 && offset <= 1.0) ? offset : 0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  Assets.images.pexelsTraceHudson2724664.path,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
