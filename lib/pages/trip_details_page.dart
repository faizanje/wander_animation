import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wander_animation/gen/assets.gen.dart';

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
  double height = 0;
  late Animation<double> _sizeXAnimation; // Add this animation for size
  late Animation<double> _sizeYAnimation; // Add this animation for size
  bool scrollPageView = true;
  int currentPage = 0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        // _animationController.reverse();
        // await Future.delayed(Duration(milliseconds: 100));
        // if (context.mounted) {
        Navigator.pop(context);
        // }
      }
    });
    _pageController = PageController();
    _pageController.addListener(() {
      final screenHeight = MediaQuery.of(context).size.height;
      // print('Height: ${height} :: ScreenHeight: ${screenHeight}');
      setState(() {
        height = _pageController.offset / screenHeight;
        // height = height;
      });
    });

    _sizeXAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95, // Adjust this value as per your requirement
    ).animate(_animationController); // Assign the animation controller here too

    _sizeYAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9, // Adjust this value as per your requirement
    ).animate(_animationController); // Assign the animation controller here too
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollNotification>(
      onNotification: (overscroll) {
        print('overscroll.metrics.axisDirection ${overscroll.metrics.axisDirection}');
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
                  _buildTitle(),
                  PageView(
                    // physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    // physics: scrollPageView ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: [
                      buildPage1(),
                      buildPage2(),
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
          backgroundColor: Color.lerp(Colors.white, Colors.black.withOpacity(0.25), 1 - height) ?? Colors.transparent,
        ),
        icon: Icon(Icons.close, color: Color.lerp(Colors.white, Colors.black, height)),
      ),
      actions: [
        Opacity(
          opacity: height,
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

  Widget _buildTitle() {
    return Align(
      // alignment: FractionalOffset(0, 1 - (1) + (0.2)),
      alignment: FractionalOffset(0, 1 - (height)),
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
                      opacity: 1 - height,
                      child: Text(
                        'May 5-15',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Color.lerp(Colors.white, Colors.black, height),
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
                              color: Color.lerp(Colors.white, Colors.black, height),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
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
                              backgroundColor: Color.lerp(Colors.white, Colors.grey[800], 1 - height),
                              shape: const StadiumBorder(
                                side: BorderSide(
                                    // color: Color.lerp(Colors.red, Colors.black26, height) ?? Colors.transparent,
                                    ),
                              ),
                              side: BorderSide(
                                  color: Color.lerp(Colors.transparent, Colors.black26, height) ?? Colors.transparent),
                              label: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  e.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color.lerp(Colors.white, Colors.black, height),
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
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPage1() {
    return GestureDetector(
      // onVerticalDragDown: (details) {
      //   print('onVerticalDragDown ${details}');
      // },
      // onVerticalDragStart: _onDragStart,
      // onVerticalDragUpdate: _onDragUpdate,
      // onVerticalDragEnd: _onDragEnd,
      // onVerticalDragUpdate: onVerticalDrag,
      // onVerticalDragEnd: (details) {
      //   setState(() {
      //     scale = 1.0; // Reset the scale when the drag ends.
      //   });
      // },
      child: Container(
          // color: Colors.red.withOpacity(0.6),
          ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    print('_onDragStart ${details}');
    _animationController.stop();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _animationController.value += details.primaryDelta! / context.size!.height;

    // if (deltaY > 0) {
    //   // Scrolling down
    //   scrollPageView = false;
    // } else if (deltaY < 0) {
    //   // Scrolling up
    //   scrollPageView = true;
    // }

    print('_onDragUpdate ${_animationController.value}');
  }

  void _onDragEnd(DragEndDetails details) {
    print('_onDragEnd ${details}');
    print('_animationController.value >= 0.5 == ${_animationController.value >= 0.5}');
    if (_animationController.value >= 0.2) {
      _animationController.forward();
      Navigator.of(context).pop();
    } else {
      _animationController.reverse();
    }
  }

  // void onVerticalDrag(details) {
  //   print(details.delta.dy);
  //   final dragDelta = details.delta.dy;
  //   final scaleFactor = 1.0 - (dragDelta / 20); // Adjust the divisor as needed for the desired shrink effect.
  //   setState(() {
  //     scale = scaleFactor.clamp(0.5, 1.0); // Limit the minimum scale to 0.5.
  //   });
  //   // final drag = details.globalPosition / MediaQuery.of(context).size.height;
  //   // print(drag);
  // }

  Widget buildPage2() {
    final tripData = [
      const TripData(
        title: 'Geo Summary',
        imagePath:
            'https://images.pexels.com/photos/2678301/pexels-photo-2678301.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        tripAdditionalInfos: [(title: 'Over 11 days', number: '1,457 km')],
      ),
      const TripData(
        title: 'Media',
        imagePath:
            'https://images.pexels.com/photos/3733269/pexels-photo-3733269.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        tripAdditionalInfos: [
          (title: 'Photos', number: '257'),
          (title: 'Videos', number: '14'),
        ],
      ),
    ];
    return SafeArea(
      child: AnimationLimiter(
        child: Container(
          // color: Colors.red.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              childAnimationBuilder: (child) => SlideAnimation(
                // horizontalOffset: 50,
                verticalOffset: 30,
                child: child,
              ),
              // delay: Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 400),
              children: [
                buildHiddenHeader(),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: tripData.length,
                    itemBuilder: (context, index) => TripDataCard(tripData: tripData[index]),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('TRIP BOARD', style: TextStyle()),
                const SizedBox(height: 8),
                buildMessageRow(
                    message: 'What a trip! Thanks for all the memories! Whats next?',
                    imagePath: Assets.images.ellipse53.path),
                const SizedBox(height: 12),
                buildMessageRow(
                    message: "Folk, that was fun. Next time with better car, not that piece of shit!\nHaha.",
                    imagePath: Assets.images.ellipse37.path),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildMessageRow({required String imagePath, required String message}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black26, width: 2),
            ),
            padding: const EdgeInsets.all(16),
            // child: const Text('What a trip! Thanks for all the memories! Whats next?'),
            child: Text(message),
          ),
        )
      ],
    );
  }

  SizedBox _buildTripDataCard() {
    return SizedBox.fromSize(
      size: const Size(180, 220),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: const NetworkImage(
              'https://images.pexels.com/photos/2678301/pexels-photo-2678301.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GEO SUMMARY',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const Spacer(),
            Text(
              '1,467 km',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            Text(
              'Over 11 days',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHiddenHeader() {
    return Opacity(
      opacity: 0,
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'May 5-15',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 16),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Text(
                  'Riding through the lands of the legends',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Theme(
            data: ThemeData.dark().copyWith(textTheme: GoogleFonts.montserratTextTheme()),
            child: Wrap(
              children: [
                (name: 'Anne', imagePath: Assets.images.ellipse36.path),
                (name: 'Mike', imagePath: Assets.images.ellipse39.path),
                (name: 'Sophia', imagePath: Assets.images.ellipse37.path),
              ]
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: Material(
                        color: Colors.transparent,
                        child: Theme(
                          data: ThemeData.dark().copyWith(textTheme: GoogleFonts.montserratTextTheme()),
                          child: Chip(
                            label: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(e.name, style: const TextStyle(fontWeight: FontWeight.w600)),
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
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildBackground() {
    return Positioned.fill(
      child: Hero(
        tag: 'bg',
        child: Opacity(
          opacity: 1 - ((height >= 0.0 && height <= 1.0) ? height : 0),
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

class TitleSubtitle extends StatelessWidget {
  const TitleSubtitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'date',
          child: Text(
            'May 5-15',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(height: 16),
        FractionallySizedBox(
          widthFactor: 0.8,
          child: Hero(
            tag: 'title',
            child: Text(
              'Riding through the lands of the legends',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class TripDataCard extends StatelessWidget {
  const TripDataCard({super.key, required this.tripData});

  final TripData tripData;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(180, 220),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(
              tripData.imagePath,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tripData.title.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const Spacer(),
            ...tripData.tripAdditionalInfos.map((e) {
              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.number,
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      e.title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white70,
                          ),
                    )
                  ],
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}

class _Page2 extends StatelessWidget {
  const _Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
