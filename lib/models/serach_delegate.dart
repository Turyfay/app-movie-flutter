import 'package:app_movie/models/movie.dart';
import 'package:app_movie/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Resultado');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Icon(
                Icons.movie_creation_outlined,
                color: Colors.black38,
                size: 200,
              ),
            ),
            Text(
              'Realizar una busqueda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    }

    final moviesProvieder = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvieder.getSuggetionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvieder.suggetionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Icon(
                    Icons.movie_creation_outlined,
                    color: Colors.black38,
                    size: 200,
                  ),
                ),
                Text(
                  'No se ha encontrado resultados',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        }

        final movies = snapshot.data!;

        return ListView.builder(
          
          itemCount: movies.length,
          itemBuilder: (_,int index)=>_MovieItem(movie: movies[index])
        );

      },
    );
  }
}



class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';


    return  ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(placeholder: const AssetImage('assets/img/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){
        Navigator.pushNamed(context, 'details',arguments: movie);
      },
    );
  }
}