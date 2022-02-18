
import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: const Icon(Icons.clear)),
    ];
  }


  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Resultado');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: const [
             Center(child: Icon(Icons.movie_creation_outlined,color: Colors.black38,size: 200,),),
             Text('No se ha encontrado resultados',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          ],
        ),
      );
    }
    return const Text('buildSuggestions');
  }

}