import 'dart:typed_data';

import 'package:aesthetic_app/models/movie_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/pick_image.dart';

const String dataBoxName = "moviedata";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

enum DataFilter { watched, created, notWatched }

class _MyHomePageState extends State<MyHomePage> {
  Box<MovieData>? dataBox;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DataFilter filter = DataFilter.watched;
  Uint8List? image;

  void selectImage() async {
    Uint8List? pickedFile = await pickImage(ImageSource.gallery);
    setState(() {
      image = pickedFile;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Hive.openBox<MovieData>(dataBoxName);
    dataBox = Hive.box<MovieData>(dataBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text("Flutter Hive Demo"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value.compareTo("All") == 0) {
                  setState(() {
                    filter = DataFilter.watched;
                  });
                } else if (value.compareTo("Compeleted") == 0) {
                  setState(() {
                    filter = DataFilter.created;
                  });
                } else {
                  setState(() {
                    filter = DataFilter.notWatched;
                  });
                }
              },
              itemBuilder: (BuildContext context) {
                return ["Wateched", "Created Movies", "Not Watched"]
                    .map((option) {
                  return PopupMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: dataBox!.listenable(),
                builder: (context, Box<MovieData> items, _) {
                  List<int> keys;

                  if (filter == DataFilter.watched) {
                    keys = items.keys.cast<int>().toList();
                  } else if (filter == DataFilter.created) {
                    keys = items.keys
                        .cast<int>()
                        .where((key) => items.get(key)!.watched)
                        .toList();
                  } else {
                    keys = items.keys
                        .cast<int>()
                        .where((key) => !items.get(key)!.watched)
                        .toList();
                  }

                  return ListView.separated(
                      separatorBuilder: (_, index) => Divider(),
                      itemCount: keys.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final int key = keys[index];
                        final MovieData? data = items.get(key);
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(data!.posterImage))),
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  backgroundColor: Colors.blueGrey[100],
                  child: Container(
                    padding: EdgeInsets.all(16),
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
                                    backgroundImage: NetworkImage(
                                        'https://i.stack.imgur.com/l60Hf.png'),
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
                          child: Text(
                            "Add Data",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // await Hive.openBox<MovieData>(dataBoxName);
                            final String title = titleController.text;
                            final String description =
                                descriptionController.text;
                            titleController.clear();
                            descriptionController.clear();
                            MovieData data = MovieData(
                                name: title,
                                director: description,
                                posterImage: image!,
                                watched: false);
                            dataBox!.add(data);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ));
            },
          );
          label:
          Icon(Icons.add);
        }));
  }
}
