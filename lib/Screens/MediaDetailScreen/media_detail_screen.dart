import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/HomeScreen/Components/body.dart';

class MediaDetailScreen extends StatelessWidget {
  const MediaDetailScreen({Key? key, required this.media}) : super(key: key);

  final Media media;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Expanded(
            child: Row(
              children: [
                const BackButton(),
                Text(
                  media.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              12.0,
              1.0,
              1.0,
              1.0,
            ),
            child: Text(
              'Hyperlink: ' + media.link,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text(
            'Lenght: ' + media.lenght,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
