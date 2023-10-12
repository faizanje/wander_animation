import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

class HomeTripCardLg extends StatelessWidget {
  const HomeTripCardLg({
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
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
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
                  ),
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
