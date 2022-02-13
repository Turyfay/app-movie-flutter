import 'package:app_movie/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'd562d41aa4de20e3323a4ed4cf325a90';
  String _language = 'es-ES';
  String _baseUrl = 'api.themoviedb.org';

  List<Movie> onDiplaymovies = [];
  List<Movie> onDiplayPopularmovies = [];
  int _popularPage = 0;
  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': page.toString(),
    });
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final moviesResponse = NowPlayingResponse.fromJson(
        await _getJsonData('/3/movie/now_playing', 1));
    onDiplaymovies = moviesResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final moviesPopularResponse = PopularResponse.fromJson(
        await _getJsonData('/3/movie/popular', _popularPage));
    onDiplayPopularmovies = [
      ...onDiplayPopularmovies,
      ...moviesPopularResponse.results
    ];
    notifyListeners();
  }
}
