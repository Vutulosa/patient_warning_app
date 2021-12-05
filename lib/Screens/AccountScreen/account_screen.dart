import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/AccountScreen/Components/epilepsy_tab.dart';
import 'package:patient_warning_app/Screens/AccountScreen/Components/settings_tab.dart';

import 'Components/issues_tab.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

//SETTINGS: UPDATE ADDRESS/AGE/GENDER
//REGISTER
//VIEW PATIENTS
//* VIEW PATIENT

class _AccountScreenState extends State<AccountScreen> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> _mediasStream =
      FirebaseFirestore.instance
          .collection('userDetails')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .snapshots();

  @override
  Widget build(BuildContext context) {
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

          return ListView(children: [
            AccountHeader(
                email: FirebaseAuth.instance.currentUser!.email.toString(),
                age: data['age'],
                gender: data['gender']),
            const Divider(),
            AddressBar(address: data['address']),
            DefaultTabController(
              length: 3, // length of tabs
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
                        Tab(text: 'Settings'),
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
                          EpilepsyTab(epilepsyDetails: data['epilepsy']),
                          IssuesTab(issuesDetails: data['issues']),
                          SettingsTab(
                              age: data['age'],
                              gender: data['gender'],
                              address: data['address']),
                        ]))
                  ]),
            )
          ]);
        });
  }
}

class AccountHeader extends StatelessWidget {
  const AccountHeader(
      {Key? key, required this.email, required this.age, required this.gender})
      : super(key: key);
  final String email;
  final String age;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline5,
              children: [
                WidgetSpan(
                  child: Icon(Icons.account_circle,
                      size: 28, color: Colors.teal.shade500),
                ),
                TextSpan(
                  text: " " + email,
                ),
              ],
            ),
          )),
      Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Text(
          age + ' • ' + gender,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      )
    ]);
  }
}

class AddressBar extends StatelessWidget {
  const AddressBar({Key? key, required this.address}) : super(key: key);
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address', style: Theme.of(context).textTheme.headline6),
            Text(address, style: Theme.of(context).textTheme.bodyText2)
          ],
        ));
  }
}
