import 'package:flutter/material.dart';

import '../models/slide_model.dart';

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(slideList[index].imageUrl, fit: BoxFit.cover),
        const SizedBox(
          height: 40,
        ),
        Text(
          slideList[index].title,
          style: const TextStyle(
              fontSize: 25, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          slideList[index].description,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
