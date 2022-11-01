import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../reusable widgets/movie_card.dart';
import '../reusable widgets/rating_widget.dart';


class DetailMovieScreen extends StatelessWidget {
  const DetailMovieScreen(
      {required this.movie,
        required this.index,
        required this.isRanking,
        Key? key, required this.movieList})
      : super(key: key);

  final Movie movie;
  final int index;
  final bool isRanking;
  final List<Movie> movieList;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 8, 24),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
              'https://www.themoviedb.org/t/p/w1280${movie.posterPath}',
              fit: BoxFit.fitHeight,
              errorWidget: (context, error, d) {
                return const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                      child: Text(
                        'No image Found',
                        textAlign: TextAlign.center,
                      )),
                );
              },
            ),
            Column(
              children: [
                Container(
                  height: 700,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Color.fromARGB(50, 7, 8, 24),
                            Color.fromARGB(255, 7, 8, 24),
                          ],
                          stops: [
                            0.0,
                            0.6
                          ])),
                ),
              ],
            ),
            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: 'Back',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 160,
                  ),
                  index == 0 && isRanking
                      ? const Text(
                    'Top movie this week',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 205, 206, 209)),
                  )
                      : Container(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index == 0 && isRanking
                          ? Padding(
                        padding:
                        const EdgeInsets.only(top: 8.0, right: 12),
                        child: Container(
                            height: 38,
                            child: Image.asset(
                                'assets/goldmedal_large.png')),
                      )
                          : Container(),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${movie.releaseDate.year.toString()} • ',
                                  style: buildStyleGenre(movie),
                                ),
                                Container(
                                  width: 200,
                                  height: 14,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: movie.genreIds.length,
                                      itemBuilder: (context, index) {
                                        if (index ==
                                            movie.genreIds.length - 1) {
                                          return Text(
                                            '${movie.genres[index]}',
                                            style: buildStyleGenre(movie),
                                          );
                                        } else {
                                          return Text(
                                            '${movie.genres[index]} / ',
                                            style: buildStyleGenre(movie),
                                          );
                                        }
                                      }),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              movie.overview,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RatingTile(
                                movie: movie,
                                index: index,
                                isDetailScreen: true,
                                isRanking: isRanking,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Also trending',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                           Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                if (index != this.index) {
                                  return MovieCard(
                                    movie: movieList[index],
                                    index: index,
                                    isRanking: false,
                                  );
                                } else {
                                  return Container();
                                }
                              },
                              itemCount: 5,
                            ),
                          )


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle buildStyleGenre(Movie movie) {
    return const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Color.fromARGB(255, 204, 229, 255));
  }
}
