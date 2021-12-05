import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/MediaDetailScreen/media_detail_screen.dart';

class UpdateDetailsScreen extends StatelessWidget {
  const UpdateDetailsScreen(
      {Key? key,
      required this.age,
      required this.gender,
      required this.address})
      : super(key: key);
  final String age;
  final String gender;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: [
        const TopSection(name: 'Update Details'),
        DetailsForm(
          age: age,
          gender: gender,
          address: address,
        ),
      ]),
    );
  }
}

class DetailsForm extends StatefulWidget {
  const DetailsForm(
      {Key? key,
      required this.age,
      required this.gender,
      required this.address})
      : super(key: key);
  final String age;
  final String gender;
  final String address;

  @override
  _DetailsFormState createState() => _DetailsFormState();
}

class _DetailsFormState extends State<DetailsForm> {
  final _detailsFormKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    addressController.text = widget.address;
    ageController.text = widget.age;
    genderController.text = widget.gender;

    //reset fields?

    return Form(
        key: _detailsFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsetsDirectional.all(15),
                child: TextFormField(
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Age cannot be empty';
                    } else if (int.tryParse(value) != null) {
                      if (int.tryParse(value)! > 130) {
                        return 'Age cannot be higher than 130';
                      } else {
                        return null;
                      }
                    } else if (int.tryParse(value) == null) {
                      return 'Age must be a number';
                    }
                    return null;
                  },
                  // The validator receives the text that the user has entered.
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                )),
            Padding(
                padding: const EdgeInsetsDirectional.all(15),
                child: TextFormField(
                  controller: genderController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Gender cannot be empty';
                    }
                    return null;
                  },
                  // The validator receives the text that the user has entered.
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                )),
            Padding(
                padding: const EdgeInsetsDirectional.all(15),
                child: TextFormField(
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address cannot be empty';
                    }
                    return null;
                  },
                  // The validator receives the text that the user has entered.
                  decoration: const InputDecoration(
                    labelText: 'Address',
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
                    if (_detailsFormKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection("userDetails")
                          .doc(
                              FirebaseAuth.instance.currentUser!.uid.toString())
                          .update({
                        'address': addressController.text,
                        'age': ageController.text,
                        'gender': genderController.text
                      });
                      Navigator.pop(context);
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
