import 'package:flutter/material.dart';
import 'package:movies/src/search/search_delegate.dart';

import 'package:movies/src/utils/appcolors.dart';
import 'package:movies/src/widgets/card_swiper_landscape_widget.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/provider/movies_provider.dart';

class HomePage extends StatelessWidget {
  
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    
    moviesProvider.getPopulars();

    return Scaffold(
      backgroundColor: AppColors.whiteBgColor,
      appBar: AppBar(
        title: Text('Peliculas en cartelera'),
        centerTitle: true,
        backgroundColor: AppColors.grey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch(),
                );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context),
          ],
        ),
      )
    );
  }

  Widget _swiperCards() {

    return FutureBuilder(
      future: moviesProvider.getCinemas(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if( snapshot.hasData ) {
          return CardSwiper( movies: snapshot.data,);
        }else {
          return Container(
            height: 400,
            child: Center(
            child :CircularProgressIndicator()
            )
          );
        }      
      },
    );
  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 5.0),

          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              if( snapshot.hasData ) {
                return MovieLandscape(
                   movies: snapshot.data, 
                   nextPage: moviesProvider.getPopulars);
              }else {
               return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}