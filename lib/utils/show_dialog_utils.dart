// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../models/movie_data.dart';
import '../screens/home_screen.dart';

Future<dynamic> ShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Need Help'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                Text(
                    '1:  Clicked on watched icon if you have watched the movie before'),
                Text(
                    '2:  rClick on the icon near help to filter the movies for you'),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK')),
                )
              ],
            ),
          ),
        );
      });
}

Future<dynamic> dialog(BuildContext context, MovieData data, int key) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            backgroundColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.blueAccent[100],
                    child: const Text(
                      "Mark as Watched",
                      style: TextStyle(color: Colors.black87),
                    ),
                    onPressed: () {
                      MovieData mData = MovieData(
                          name: data.name,
                          director: data.director,
                          posterImage: data.posterImage,
                          watched: true);
                      dataBox!.put(key, mData);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ));
      });
}
