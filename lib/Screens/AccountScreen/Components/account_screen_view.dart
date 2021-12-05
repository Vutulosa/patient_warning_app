import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/AccountScreen/Components/epilepsy_tab.dart';
import 'package:patient_warning_app/Screens/MediaDetailScreen/media_detail_screen.dart';

import '../account_screen.dart';
import 'issues_tab.dart';

class AccountViewScreen extends StatelessWidget {
  const AccountViewScreen({Key? key, required this.uid, required this.email})
      : super(key: key);
  final String uid;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: [
        const TopSection(name: 'View Patient'),
        //load rest of the screen stful -> pass uid
        AccountViewDetails(uid: uid, email: email)
      ]),
    );
  }
}

class AccountViewDetails extends StatefulWidget {
  const AccountViewDetails({Key? key, required this.uid, required this.email})
      : super(key: key);
  final String uid;
  final String email;

  @override
  _AccountViewDetailsState createState() => _AccountViewDetailsState();
}

class _AccountViewDetailsState extends State<AccountViewDetails> {
  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> _mediasStream =
        FirebaseFirestore.instance
            .collection('userDetails')
            .doc(widget.uid)
            .snapshots();

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _mediasStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          final data = snapshot.requireData;

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountHeader(
                    email: widget.email,
                    age: data['age'],
                    gender: data['gender']),
                const Divider(),
                AddressBar(address: data['address']),
                DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const TabBar(
                          labelColor: Colors.teal,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(text: 'Epilepsy'),
                            Tab(text: 'Issues'),
                          ],
                        ),
                        Container(
                            height: 400, //height of TabBarView
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            //TABS
                            child: TabBarView(children: <Widget>[
                              Padding(
                                  padding: const EdgeInsetsDirectional.all(15),
                                  child: TextFormField(
                                    initialValue: data['epilepsy'],
                                    minLines: 4,
                                    maxLines: 12,
                                    readOnly: true,
                                    // The validator receives the text that the user has entered.
                                    decoration: const InputDecoration(
                                      labelText: 'Epilepsy Details',
                                      border: OutlineInputBorder(),
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsetsDirectional.all(15),
                                  child: TextFormField(
                                    initialValue: data['issues'],
                                    minLines: 4,
                                    maxLines: 12,
                                    readOnly: true,
                                    // The validator receives the text that the user has entered.
                                    decoration: const InputDecoration(
                                      labelText: 'Mental Issues',
                                      border: OutlineInputBorder(),
                                    ),
                                  )),
                            ]))
                      ]),
                )
              ]);
        });
  }
}
