import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/MediaDetailScreen/media_detail_screen.dart';

import 'body.dart';

class FlashesForm extends StatefulWidget {
  const FlashesForm({Key? key, required this.onFlashAdded}) : super(key: key);
  final Function(Flash) onFlashAdded;

  @override
  _FlashesFormState createState() => _FlashesFormState();
}

class _FlashesFormState extends State<FlashesForm> {
  final _flashFormKey = GlobalKey<FormState>();
  final List<Flash> flashes = [];
  final descriptionController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    descriptionController.dispose();
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _flashFormKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CreateTitle(name: "Flashes"),
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: Column(
                children: [...buildFlashes(data: flashes)],
              )),
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
              child: TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
                maxLines: 2,
                // The validator receives the text that the user has entered.
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              )),
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: TextFormField(
                            controller: startController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the time';
                              }
                              return null;
                            },
                            // The validator receives the text that the user has entered.
                            decoration: const InputDecoration(
                              labelText: 'Start',
                              border: OutlineInputBorder(),
                            ),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextFormField(
                            controller: endController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the time';
                              }
                              return null;
                            },
                            // The validator receives the text that the user has entered.
                            decoration: const InputDecoration(
                              labelText: 'End',
                              border: OutlineInputBorder(),
                            ),
                          ))),
                ],
              )),
          Padding(
            padding: const EdgeInsetsDirectional.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      if (_flashFormKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        widget.onFlashAdded(Flash(descriptionController.text,
                            startController.text, endController.text));

                        setState(() {
                          flashes.add(Flash(descriptionController.text,
                              startController.text, endController.text));
                        });

                        descriptionController.clear();
                        startController.clear();
                        endController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Flash Added'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Flash"))
              ],
            ),
          )
        ]));
  }

  List<Widget> buildFlashes({data}) {
    List<Widget> list = [];

    for (int i = 0; i < data.length; i++) {
      Widget widget = BuildFlash(
          description: data[i].description,
          start: data[i].start,
          end: data[i].end);
      if (i > 0) {
        list.add(const Divider());
      }
      list.add(widget);
    }

    return list;
  }
}

class Flash {
  final String description;
  final String start;
  final String end;

  Flash(this.description, this.start, this.end);
}
