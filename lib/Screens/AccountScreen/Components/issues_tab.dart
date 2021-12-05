import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IssuesTab extends StatefulWidget {
  const IssuesTab({Key? key, required this.issuesDetails}) : super(key: key);
  final String issuesDetails;

  @override
  _IssuesTabState createState() => _IssuesTabState();
}

class _IssuesTabState extends State<IssuesTab> {
  final _issuesFormKey = GlobalKey<FormState>();
  final issuesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    issuesController.text = widget.issuesDetails;

    return Form(
        key: _issuesFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsetsDirectional.all(15),
                child: TextFormField(
                  minLines: 4,
                  maxLines: 12,
                  controller: issuesController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter details about issues you are having';
                    }
                    return null;
                  },
                  // The validator receives the text that the user has entered.
                  decoration: const InputDecoration(
                    labelText: 'Issues',
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
                    if (_issuesFormKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection("userDetails")
                          .doc(
                              FirebaseAuth.instance.currentUser!.uid.toString())
                          .update({'issues': issuesController.text});
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
