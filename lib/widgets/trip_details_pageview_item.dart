import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wander_animation/gen/assets.gen.dart';
import 'package:wander_animation/models/trip_data.dart';
import 'package:wander_animation/widgets/trip_data_card.dart';

class TripDetailsPageViewItem extends StatelessWidget {
  TripDetailsPageViewItem({super.key});

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

  @override
  Widget build(BuildContext context) {
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
                buildHiddenHeader(context),
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

  Widget buildHiddenHeader(BuildContext context) {
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
}
