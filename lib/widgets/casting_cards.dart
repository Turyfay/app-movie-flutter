import 'package:flutter/material.dart';

class CastingCard extends StatelessWidget {
  const CastingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      color: Colors.red,
      child: ListView.builder(
          itemBuilder: (context, index) => const _CastCard(),
          itemCount: 10,
          scrollDirection: Axis.horizontal),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(
                'https://image.tmdb.org/t/p/w500/kTQ3J8oTTKofAVLYnds2cHUz9KO.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Name',
            maxLines: 2,
            style: TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
