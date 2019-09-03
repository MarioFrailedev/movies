import 'package:flutter/material.dart';

import 'package:movies/src/utils/appcolors.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBgColor,
      appBar: AppBar(
        title: Text('Peliculas en cartelera'),
        centerTitle: true,
        backgroundColor: AppColors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperCards(),
          ],
        ),
      )
    );
  }

  _swiperCards() {
    return CardSwiper(
      movies: [1,2,3,4,5],
    );
    //return Container();
  }
}