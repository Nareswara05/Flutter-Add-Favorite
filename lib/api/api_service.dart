
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const apiKey = '9acf91f77dc8d30eea3c27a21ecd43f3';
  static const baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List).map((json) => Movie.fromJson(json)).toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
