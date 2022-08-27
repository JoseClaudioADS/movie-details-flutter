class Movie {
  final String title;
  final int year;
  final String poster;
  final String plot;

  const Movie({
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'], 
      year: int.parse(json['Year']), 
      poster: json['Poster'],
      plot: json['Plot']
    );
  }

}