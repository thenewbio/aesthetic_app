import 'dart:typed_data';

import 'package:aesthetic_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/movie_data.dart';

class FormWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  Uint8List? image;
  final Function()? selectImage;
  final Function()? addData;

  FormWidget(
      {required this.selectImage,
      required this.addData,
      required this.titleController,
      required this.descriptionController,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: [
                image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(image!),
                        backgroundColor: Colors.red,
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                        backgroundColor: Colors.red,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.black38,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Title"),
              controller: titleController,
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Description"),
              controller: descriptionController,
            ),
            SizedBox(
              height: 8,
            ),
            FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.red,
                child: const Text(
                  "Add Data",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: addData)
          ],
        ),
      ),
    );
  }
}
