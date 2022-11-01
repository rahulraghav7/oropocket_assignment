import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:oropocket_assignment/tabs/rankings/ranking_bloc.dart';

import '../../reusable widgets/movie_card.dart';

class RankingTab extends StatefulWidget {
  RankingTab({Key? key}) : super(key: key);

  @override
  _RankingTabState createState() => _RankingTabState();
}

class _RankingTabState extends State<RankingTab> {
@override
  void initState() {
    // TODO: implement initState
  blocRanking.getMovies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: blocRanking.getMovies,
      child: Column(
        children: [
          StreamBuilder(
              stream: blocRanking.subject.stream,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return const MovieList();
                } else {
                  return const Center(
                    child: RefreshProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  const MovieList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return MovieCard(
            movie: blocRanking.movieList[index],
            index: index,
            isRanking: true,
          );
        },
        itemCount: blocRanking.movieList.length,
      ),
    );
  }
}
