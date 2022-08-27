import 'package:flutter/material.dart';

class SearchMovieForm extends StatelessWidget {
  final TextEditingController movieNameController;
  final FocusNode movieNameFocusNode;
  final Function searchMovie;

  const SearchMovieForm({
    Key? key, 
    required this.movieNameController,
    required this.movieNameFocusNode,
    required this.searchMovie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          'Qual filme deseja pesquisar?',
        ),
        TextField(
          controller: movieNameController,
          focusNode: movieNameFocusNode,
          onSubmitted: (_) {
            searchMovie();
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Nome do Filme",
          ),
        ),
      ],
    );
  }
}