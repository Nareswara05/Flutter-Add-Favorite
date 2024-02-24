import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_2/controllers/home_controller.dart';

class FavoritePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>() ?? HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: Center(
        child: Obx(() {
          if (controller.favorites.isEmpty) {
            return Text('No favorite movies.');
          } else {
            return ListView.builder(
              itemCount: controller.favorites.length,
              itemBuilder: (context, index) {
                // Accessing movie details
                var movie = controller.favorites[index];

                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),  // Add description
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}',),  // Add image
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red,),
                    onPressed: () {
                      controller.removeFromFavorites(movie);
                    },
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
