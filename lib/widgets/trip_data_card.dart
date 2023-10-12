import 'package:flutter/material.dart';
import 'package:wander_animation/models/trip_data.dart';

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
