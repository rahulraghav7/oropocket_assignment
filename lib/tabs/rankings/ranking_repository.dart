import 'package:oropocket_assignment/api%20provider/api_provider.dart';
import 'package:oropocket_assignment/models/movie.dart';

class RankingRepository {
  final Api _apiProvider = Api();

  Future<List<Movie>> getMovies() async {
    return await _apiProvider.getMovies();
  }

}
