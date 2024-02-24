import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_2/view/custom%20layout.dart';
import 'package:sqflite_2/view/favoritepage_view.dart';
import '../controllers/home_controller.dart';
import '../models/movie.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(FavoritePage());
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(), // Initialize the controller
        builder: (controller) {
          if (controller.movies.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: controller.movies.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: controller.movies[index],
                  onLovePressed: () {
                    if (controller.isFavorite(controller.movies[index].id)) {
                      controller.removeFromFavorites(controller.movies[index]);
                    } else {
                      controller.addToFavorites(controller.movies[index]);
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}


class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onLovePressed;

  MovieCard({required this.movie, required this.onLovePressed});

  @override
  Widget build(BuildContext context) {
    final HomeController? controller = Get.find<HomeController>();

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movie.overview),
          ),
          Obx(() => IconButton(
            onPressed: onLovePressed,
            icon: Icon(
              controller?.isFavorite(movie.id) ?? false
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: controller?.isFavorite(movie.id) ?? false
                  ? Colors.red
                  : null,
            ),
          )),
        ],
      ),
    );
  }
}



