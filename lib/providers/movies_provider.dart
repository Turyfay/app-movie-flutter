import 'package:app_movie/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'd562d41aa4de20e3323a4ed4cf325a90';
  String _language = 'es-ES';
  String _baseUrl = 'api.themoviedb.org';

  MoviesProvider() {
    print('MoviesProvider init');
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

    print(moviesResponse.results[0].title);
  }
}
