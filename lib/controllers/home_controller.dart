import 'package:get/get.dart';
import '../api/api_service.dart';
import '../models/movie.dart';
import '../utils/database_helper.dart';

class HomeController extends GetxController {
  var movies = <Movie>[].obs;
  var favorites = <Movie>[].obs;

  final dbHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
    loadFavoritesFromDatabase(); // Load favorites from the database
  }

  Future<void> fetchMovies() async {
    try {
      List<Movie> result = await ApiService.getPopularMovies();
      movies.assignAll(result);
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  Future<void> loadFavoritesFromDatabase() async {
    final favMovies = await dbHelper.queryAllFavorites();
    favorites.assignAll(favMovies);
  }

  bool isFavorite(int movieId) {
    return favorites.any((favMovie) => favMovie.id == movieId);
  }

  Future<void> addToFavorites(Movie movie) async {
    if (!isFavorite(movie.id)) {
      favorites.add(movie);
      await dbHelper.insertFavorite(movie);
    }
  }

  Future<void> removeFromFavorites(Movie movie) async {
    favorites.removeWhere((favMovie) => favMovie.id == movie.id);
    await dbHelper.deleteFavorite(movie.id);
  }
}
