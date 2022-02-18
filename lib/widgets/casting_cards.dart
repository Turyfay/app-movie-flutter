import 'package:app_movie/models/models.dart';
import 'package:app_movie/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {
  final int movieID;

  const CastingCard({Key? key, required this.movieID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieID),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {

        if(!snapshot.hasData){
          return Container(
            width: 180,
            height: 180,
            child: const Center(child:  CircularProgressIndicator()),
          );
        }

        final List<Cast> cast = snapshot.data!;


        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 200,
          child: Expanded(
            child: ListView.builder(
                itemBuilder: (_, int index) =>  _CastCard( cast[index] ),
                itemCount: cast.length,
                scrollDirection: Axis.horizontal),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard( this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:  FadeInImage(
              placeholder: const AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(
                actor.fullprofilePath,
              ),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
           Text(
            actor.name,
            maxLines: 3,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
