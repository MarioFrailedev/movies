import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies/src/models/actors_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/models/movie_model.dart' as prefix0;

class MoviesProvider {

  String _apikey = '9e9dfc4605cf7109ea86041726415d2d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-Es';
  int _popularesPage = 0;
  bool _waiting      = false;

  List<Movie> _populars = new List();

  final _streamPopularsController = StreamController<List<Movie>>.broadcast();

  Function ( List<Movie> ) get popularsSink => _streamPopularsController.sink.add;
  Stream<List<Movie>> get popularStream => _streamPopularsController.stream;

  void disposeStream() {
    _streamPopularsController?.close();
  }

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

    if( _waiting) return [];

    _waiting = true;

    _popularesPage ++;
    
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language' : _language,
      'page'    : _popularesPage.toString()
    });

    final resp = await _processResponse(url);

    _populars.addAll( resp );
    popularsSink( _populars );

    _waiting = false;
    
    return resp;
  }

  Future<List<Actor>> getCast( String peliId ) async {

    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key' : _apikey,
      'language' : _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
    
  }

  Future<List<Movie>> searchMovie(String query) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apikey,
      'language' : _language,
      'query'    : query
    });

    return await _processResponse(url);
  }
}
