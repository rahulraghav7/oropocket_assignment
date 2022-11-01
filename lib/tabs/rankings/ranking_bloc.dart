import 'package:oropocket_assignment/tabs/rankings/ranking_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/movie.dart';

class BlocRanking{
  final RankingRepository _repository = RankingRepository();

  final BehaviorSubject<dynamic> _subject = BehaviorSubject<dynamic>();
  List<Movie> movieList=[];

 Future<void> getMovies() async
  {
    dynamic response = await _repository.getMovies();
    movieList.clear();
    movieList.addAll(response);
    _subject.sink.add(response);
  }

dispose()
{

  _subject.close();
  movieList=[];
}

  BehaviorSubject<dynamic> get subject => _subject;

}
final blocRanking = BlocRanking();
