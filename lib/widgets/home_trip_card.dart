import 'package:flutter/material.dart';

class HomeTripCard extends StatelessWidget {
  const HomeTripCard({
    super.key,
    required this.imagePath,
    required this.date,
    required this.title,
  });

  final String imagePath;
  final String date;
  final String title;

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
  }
}
