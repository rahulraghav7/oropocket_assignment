import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/movie.dart';

class RatingTile extends StatelessWidget {
  const RatingTile(
      {required this.movie,
        required this.index,
        required this.isDetailScreen,
        required this.isRanking,
        Key? key})
      : super(key: key);

  final Movie movie;
  final int index;
  final bool isDetailScreen;
  final bool isRanking;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: index == 0 && isRanking
              ? isDetailScreen
              ? Theme.of(context).backgroundColor
              : const Color.fromARGB(255, 31, 140, 255)
              : const Color.fromARGB(255, 37, 38, 52),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar(
              unratedColor: Colors.transparent,
              itemSize: 16,
              initialRating: (movie.voteAverage ~/ 2) + 0.0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                  empty: const Icon(
                    Icons.star_border_outlined,
                    color: Colors.amber,
                  )),
              onRatingUpdate: (rating) {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                '${movie.voteAverage ~/ 2}/5',
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 205, 206, 209)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
