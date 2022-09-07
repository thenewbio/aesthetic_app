import 'dart:typed_data';

import 'package:aesthetic_app/constants.dart';
import 'package:aesthetic_app/models/movie_data.dart';
import 'package:aesthetic_app/providers/auth_providers.dart';
import 'package:aesthetic_app/widgets/form_widget.dart';
import 'package:aesthetic_app/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils/pick_image.dart';
import '../utils/show_dialog_utils.dart';

const String dataBoxName = "moviedata";
Box<MovieData>? dataBox;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

enum DataFilter { ALL, WATCHED, NOTWATCHED }

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DataFilter filter = DataFilter.ALL;
  Uint8List? image;

  void selectImage() async {
    Uint8List? pickedFile = await pickImage(ImageSource.gallery);
    setState(() {
      image = pickedFile;
    });
  }

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<MovieData>(dataBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Image.asset('assets/movie.png'),
          backgroundColor: appColor,
          title: const Text("Aesthetic App"),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  ShowDialog(context);
                },
                icon: const Icon(Icons.help)),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value.compareTo("All") == 0) {
                  setState(() {
                    filter = DataFilter.ALL;
                  });
                } else if (value.compareTo("Watched") == 0) {
                  setState(() {
                    filter = DataFilter.WATCHED;
                  });
                } else if (value.compareTo('NotWatched') == 0) {
                  setState(() {
                    filter = DataFilter.NOTWATCHED;
                  });
                } else {
                  Provider.of<AuthProvider>(context, listen: false)
                      .handleLogOut(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return ["All", "Watched", "Not Watched", "Logout"]
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
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: dataBox!.listenable(),
              builder: (context, Box<MovieData> items, _) {
                List<int> keys;
                if (filter == DataFilter.ALL) {
                  keys = items.keys.cast<int>().toList();
                } else if (filter == DataFilter.WATCHED) {
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
                      return PostCard(
                        data: data,
                        delete: () => dataBox!.delete(key),
                        filter: () => dialog(context, data!, key),
                      );
                    });
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff31D813),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.blueGrey[100],
                  child: FormWidget(
                      selectImage: selectImage,
                      titleController: titleController,
                      descriptionController: descriptionController,
                      addData: () {
                        final String title = titleController.text;
                        final String description = descriptionController.text;
                        titleController.clear();
                        descriptionController.clear();
                        MovieData data = MovieData(
                            name: title,
                            director: description,
                            posterImage: image!,
                            watched: false);
                        dataBox!.add(data);
                        Navigator.pop(context);
                      }),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ));
  }
}
