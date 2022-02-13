import 'package:app_movie/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'd562d41aa4de20e3323a4ed4cf325a90';
  String _language = 'es-ES';
  String _baseUrl = 'api.themoviedb.org';

  List<Movie> onDiplaymovies = [];

  List<Movie> onDiplayPopularmovies = [];

  MoviesProvider() {
    print('MoviesProvider init');
    getOnDisplayMovies();
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);
    final moviesResponse = NowPlayingResponse.fromJson(response.body);
    onDiplaymovies = moviesResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);
    final moviesPopularResponse = PopularResponse.fromJson(response.body);
    onDiplayPopularmovies = [
      ...onDiplayPopularmovies,
      ...moviesPopularResponse.results
    ];
    notifyListeners();
  }
}
