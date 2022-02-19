import 'dart:async';

import 'package:app_movie/helpers/debouncer.dart';
import 'package:app_movie/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'd562d41aa4de20e3323a4ed4cf325a90';
  final String _language = 'es-ES';
  final String _baseUrl = 'api.themoviedb.org';

  List<Movie> onDiplaymovies = [];
  List<Movie> onDiplayPopularmovies = [];
  int _popularPage = 0;

  Map<int,List<Cast>> moviesCast = {};


  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast(); 
  Stream<List<Movie>> get suggetionStream => this._suggestionStreamController.stream;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
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

  Future<List<Cast>> getMovieCast(int movieId) async{
   
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    
     final creditsResponse = CreditsResponse.fromJson(
        await _getJsonData('/3/movie/$movieId/credits'));
      moviesCast[movieId]=creditsResponse.cast;
      
      return creditsResponse.cast;


  }

  Future<List<Movie>> searchMovies (String query) async{
    final url = Uri.https(_baseUrl, '/3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query':query
    });

     final response = await http.get(url);
     final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;


  }



  void getSuggetionsByQuery(String searchStream){

    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await searchMovies(value);
      _suggestionStreamController.add(result);


    };

    final timer =  Timer.periodic( const Duration(milliseconds: 300), (_) { 
      debouncer.value = searchStream;

    });

    Future.delayed( const Duration(milliseconds: 301)).then((_) => timer.cancel());

  }

}
