import 'package:app_movie/providers/movies_provider.dart';
import 'package:app_movie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: const Text('Peliculas en cines'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiperScreen(
              movies: moviesProvider.onDiplaymovies,
            ),
            MovieSliderScreen(
              movies: moviesProvider.onDiplayPopularmovies,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}
