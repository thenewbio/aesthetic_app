import 'package:flutter/material.dart';

import '../models/movie_data.dart';
import '../screens/home_screen.dart';
import '../utils/show_dialog_utils.dart';

class PostCard extends StatelessWidget {
  final MovieData? data;
  final Function()? delete;
  final Function()? filter;
  const PostCard(
      {Key? key,
      required this.data,
      required this.delete,
      required this.filter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data!.name,
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                  onPressed: delete,
                  icon: Icon(Icons.delete, size: 30, color: Color(0xff31D813)))
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.topLeft,
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    scale: 0.1,
                    image: MemoryImage(data!.posterImage))),
          ),
          Row(
            children: [
              Text(
                "Director: ${data!.director}",
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: filter,
                  icon: Icon(Icons.watch_later,
                      size: 25,
                      color: data!.watched ? Colors.grey : Color(0xff31D813)))
            ],
          )
        ],
      ),
    );
  }
}
