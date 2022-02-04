import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiperScreen extends StatelessWidget {
  const CardSwiperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.55,
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'details');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  'https://picsum.photos/id/$index/300/400',
                ),
                fadeInDuration: const Duration(milliseconds: 200),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
