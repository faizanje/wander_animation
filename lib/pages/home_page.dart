import 'package:flutter/material.dart';
import 'package:wander_animation/gen/assets.gen.dart';
import 'package:wander_animation/widgets/stacked_row.dart';

import 'trip_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage(Assets.images.ellipse36.path),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: Text(
                'Your trips',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Current trip'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      // MaterialPageRoute(
                      //   builder: (context) => const TripDetailsBody(),
                      // )
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        reverseTransitionDuration: const Duration(milliseconds: 500),
                        pageBuilder:
                            (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                          return const TripDetailsPage();
                        },
                        transitionsBuilder: (BuildContext context, Animation<double> animation,
                            Animation<double> secondaryAnimation, Widget child) {
                          return Align(
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        opaque: false,
                      ),
                    );
                  },
                  child: const _TripCard(),
                ),
                Positioned(
                  bottom: -20,
                  left: 20,
                  // alignment: Alignment.bottomCenter,
                  child: StackedRow(
                    items: [
                      Assets.images.ellipse36.path,
                      Assets.images.ellipse39.path,
                      Assets.images.ellipse37.path,
                    ]
                        .map(
                          (e) => Hero(
                            tag: e,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(e),
                            ),
                          ),
                        )
                        .toList(),
                    size: 42,
                    direction: TextDirection.rtl,
                    xShift: 10,
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 220,
              ),
              shrinkWrap: true,
              children: const [
                HomeTripCard(
                  imagePath:
                      'https://images.pexels.com/photos/2377432/pexels-photo-2377432.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  date: 'Mar 7-21',
                  title: 'Road trips over Italian Riviera',
                ),
                HomeTripCard(
                  imagePath:
                      'https://images.pexels.com/photos/1615807/pexels-photo-1615807.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  date: 'Jan 7-23',
                  title: 'Weekend in Lisbon',
                ),
                HomeTripCard(
                  imagePath:
                      'https://images.pexels.com/photos/1559908/pexels-photo-1559908.jpeg?auto=compress&cs=tinysrgb&w=600',
                  date: 'Mar 7-21',
                  title: 'Road trips over Italian Riviera',
                ),
                HomeTripCard(
                  imagePath:
                      'https://images.pexels.com/photos/1550348/pexels-photo-1550348.jpeg?auto=compress&cs=tinysrgb&w=600',
                  date: 'Mar 7-21',
                  title: 'Road trips over Italian Riviera',
                )
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          Hero(
            tag: 'bg',
            child: Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  Assets.images.pexelsTraceHudson2724664.path,
                ),
              ),
            )),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TitleSubtitle(),
                  SizedBox(height: 48),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeTripCard extends StatelessWidget {
  const HomeTripCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
  });

  final String imagePath;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imagePath),
            colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
    return const Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TitleSubtitle(),
                SizedBox(height: 48),
              ],
            ),
          ),
        )
      ],
    );
  }
}
