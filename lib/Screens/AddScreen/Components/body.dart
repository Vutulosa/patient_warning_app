import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/MediaDetailScreen/media_detail_screen.dart';

import 'flashes_form.dart';

class AddMediaScreen extends StatefulWidget {
  const AddMediaScreen({Key? key}) : super(key: key);

  @override
  _AddMediaScreenState createState() => _AddMediaScreenState();
}

class _AddMediaScreenState extends State<AddMediaScreen> {
  //retrieve data
  //create Media Document
  //create Flashes Collection
  //create FLashes Documents

  final _mediaFormKey = GlobalKey<FormState>();
  List<Flash> flashes = [];
  final nameController = TextEditingController();
  final lengthController = TextEditingController();
  final linkController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    lengthController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference medias =
        FirebaseFirestore.instance.collection('Medias');

    Future<void> addMedia(String name, String length, String link) {
      // Call the user's CollectionReference to add a new user
      return medias
          .add({'name': name, 'length': length, 'link': link}).then((value) {
        for (int i = 0; i < flashes.length; i++) {
          value.collection('Flashes').add({
            'description': flashes[i].description,
            'start': flashes[i].start,
            'end': flashes[i].end
          });
        }
      });
    }

    return Form(
        key: _mediaFormKey,
        child: ListView(children: [
          const CreateTitle(name: "Add Media"),
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
              child: TextFormField(
                controller: nameController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              )),
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
              child: TextFormField(
                controller: lengthController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the media length';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Length',
                  border: OutlineInputBorder(),
                ),
              )),
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
              child: TextFormField(
                controller: linkController,
                // The validator receives the text that the user has entered.
                decoration: const InputDecoration(
                  labelText: 'Media Link',
                  border: OutlineInputBorder(),
                ),
              )),
          FlashesForm(
            onFlashAdded: (Flash flash) {
              setState(() {
                flashes.add(flash);
              });
            },
          ),
          Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      minimumSize: const Size(100, 50)),
                  onPressed: () {
                    if (_mediaFormKey.currentState!.validate()) {
                      if (flashes.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text(
                                  "You must add at least one warning of a Flash"),
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text("Media Added"),
                            );
                          },
                        );
                        addMedia(nameController.text, lengthController.text,
                            linkController.text);
                      }
                      //clear screen //navigate home
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Media")))
        ]));
  }
}

class CreateTitle extends StatelessWidget {
  const CreateTitle({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
      child: Text(name, style: Theme.of(context).textTheme.headline5),
    );
  }
}

class Media {
  final String name;
  final String length;
  final String link;

  Media(this.name, this.length, this.link);
}
