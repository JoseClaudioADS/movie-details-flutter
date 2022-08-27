import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_anime_things/util.dart';
import 'package:text_to_speech/text_to_speech.dart'; 

import 'package:get_anime_things/detail.dart';
import 'package:get_anime_things/form.dart';
import 'package:get_anime_things/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get Movie Details',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'ZéMDB'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleContainsQueryParam = "t";
  final movieNameController = TextEditingController();
  final _movieNameFocusNode = FocusNode();
  final TextToSpeech tts = TextToSpeech(); 
  Movie _movie = Movie(title: "", year: 0, poster: "plot", plot: "");
  String _apiKey = "";

  _MyHomePageState() {
    _apiKey = dotenv.get("OMDB_API_KEY");
    tts.setRate(0.9);
    tts.setPitch(1.3);
    tts.setLanguage("pt-BR");
  }

  void _searchMovie() async {

    final url = Uri.https("www.omdbapi.com", "", {
      titleContainsQueryParam: movieNameController.text,
      "apikey": _apiKey
    });
    final response = await http.get(url);
    _movieNameFocusNode.unfocus();
    final responseDecoded = jsonDecode(response.body);
    if (mounted && responseDecoded['Response'] == "False") {
      var snackBar = const SnackBar(content: Text('Filme não encontrado.'), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    var foundedMovie = Movie.fromJson(responseDecoded);
    foundedMovie.plot = (await AppUtils.translateToBR(foundedMovie.plot)).text;
    setState(() {
      _movie = foundedMovie;
    });
    tts.speak(foundedMovie.plot);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SearchMovieForm(
                movieNameController: movieNameController,
                movieNameFocusNode: _movieNameFocusNode,
                searchMovie: _searchMovie
              ),
              Visibility(
                visible: _movie.year > 0,
                child: MovieDetail(movie: _movie),
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _searchMovie,
        tooltip: 'Procurar',
        child: const Icon(Icons.search),
      ),
    );
  }
}
