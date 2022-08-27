import 'package:flutter/material.dart';
import 'package:get_anime_things/models/movie.dart';

class MovieDetail extends StatelessWidget {

  final Movie movie;

  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          movie.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          movie.year.toString(),
          style: Theme.of(context).textTheme.headline5,
        ),
        Image.network(movie.poster),
        Text(
          movie.plot,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}