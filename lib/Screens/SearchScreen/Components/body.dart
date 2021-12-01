import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: 'Input text',
      decoration: const InputDecoration(
        labelText: 'Label text',
        errorText: 'Error message',
        border: OutlineInputBorder(),
        suffixIcon: Icon(
          Icons.error,
        ),
      ),
    );
  }
}
