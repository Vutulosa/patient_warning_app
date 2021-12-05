import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EpilepsyTab extends StatefulWidget {
  const EpilepsyTab({Key? key, required this.epilepsyDetails})
      : super(key: key);
  final String epilepsyDetails;

  @override
  _EpilepsyTabState createState() => _EpilepsyTabState();
}

class _EpilepsyTabState extends State<EpilepsyTab> {
  final _epilepsyFormKey = GlobalKey<FormState>();
  final epilepsyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    epilepsyController.text = widget.epilepsyDetails;

    return Form(
        key: _epilepsyFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsetsDirectional.all(15),
                child: TextFormField(
                  minLines: 4,
                  maxLines: 12,
                  controller: epilepsyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter details about your epilepsy';
                    }
                    return null;
                  },
                  // The validator receives the text that the user has entered.
                  decoration: const InputDecoration(
                    labelText: 'Epilepsy Details',
                    border: OutlineInputBorder(),
                  ),
                )),
            Padding(
              padding: const EdgeInsetsDirectional.all(15),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      minimumSize: const Size(50, 50)),
                  onPressed: () async {
                    if (_epilepsyFormKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection("userDetails")
                          .doc(
                              FirebaseAuth.instance.currentUser!.uid.toString())
                          .update({'epilepsy': epilepsyController.text});
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                              content: Text(
                            'Saved Details',
                          ));
                        },
                      );
                    }
                  },
                  child: const Text("Save")),
            ),
          ],
        ));
  }
}
