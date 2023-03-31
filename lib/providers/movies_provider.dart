import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:disney_movies/helpers/debouncer.dart';
import 'package:disney_movies/models/models.dart';
import '../models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseURL = 'disney-movies-db.onrender.com';

  List<Movie> onDisplayMovies = [];
  List<Characters> onDisplayPopularMovies = [];

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

//https://api.themoviedb.org/3/movie/now_playing?api_key=85cbc3921272efcb12987d6f90aebbda&language=en-US&page=1
  MoviesProvider() {
    getOnNowPlayingMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.https(_baseURL, endpoint);

    final response = await http.get(url);
    return response.body;
  }

  getOnNowPlayingMovies() async {
    final jsonData = await _getJsonData('/movies');

    final nowPlaying = movieFromJson(jsonData);

     onDisplayMovies = nowPlaying;

    notifyListeners();
  }

  getPopularMovies() async {

    final jsonData = await _getJsonData('characters');

    final popularResponse = characterFromJson(jsonData);

        //onDisplayPopularMovies = popularResponse;

    notifyListeners();
  }
}
