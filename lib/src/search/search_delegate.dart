import 'package:flutter/material.dart';
import 'package:movies/provider/movies_provider.dart';
import 'package:movies/src/models/movie_model.dart';

class DataSearch extends SearchDelegate{

  String selected = '';
  final moviesProvider = MoviesProvider();

  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
    'Superman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5',
  ];

  final recentMovies = [
    'Spiderman',
    'Capitan America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones de appbar lipiar o cancela
    return [
      IconButton(
        icon:  Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono al a izquierda de appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if( query.isEmpty ) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        
        if(snapshot.hasData) {

          final movies = snapshot.data;

          return ListView(
            children: movies.map( (movie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text( movie.title ),
                subtitle: Text( movie.originalTitle ),
                onTap: () {
                  close(context, null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: movie);
                },
              );
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        } 
      },
    );
  }

  /* @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias que aparecen cuando escribe

    final suggestlist = (query.isEmpty) 
                          ? recentMovies
                          : movies.where( 
                            (p) => p.toLowerCase().startsWith(query.toLowerCase())
                          ).toList();

    return ListView.builder(
      itemCount: suggestlist.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestlist[i]),
          onTap: () {
            selected = suggestlist[i];
            showResults(context);
          },
        );
      },
    );
  } */
  
}