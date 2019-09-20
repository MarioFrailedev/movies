import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _customAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0,),
                _posterTitle(context, movie),
                _description(movie),
                _description(movie),
                
              ]
            ),
          )
        ],
      ) ,
    );
  }

  Widget _customAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 0.0,
      backgroundColor: Colors.grey,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBGImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
            image: NetworkImage(movie.getPosterImg()),
            height: 150.0,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(),style: Theme.of(context).textTheme.subhead,)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify
      ),
    );

  }
}