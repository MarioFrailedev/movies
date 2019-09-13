import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/models/movie_model.dart' as prefix0;

class MoviesProvider {

  String _apikey = '9e9dfc4605cf7109ea86041726415d2d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-Es';

  Future <List<Movie>> _processResponse( Uri url) async {

    final resp = await  http.get( url );
    final decodeData = json.decode(resp.body);
    final movies = new prefix0.Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future<List<Movie>> getCinemas() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language,
    });

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language' : _language,
    });

    return await _processResponse(url);
    
  }
}
