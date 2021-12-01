import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MediaDetailScreen extends StatelessWidget {
  MediaDetailScreen({Key? key, required this.media}) : super(key: key);
  final QueryDocumentSnapshot<Object?> media;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          TopSection(name: media["name"]),
          MediaDetails(link: media["link"], lenght: media["lenght"]),
          const Divider(),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              20.0,
              5.0,
              20.0,
              5.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Flashes",
                  style: Theme.of(context).textTheme.headline5,
                ),
                FlashesList(documentId: media.id)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlashesList extends StatefulWidget {
  const FlashesList({Key? key, required this.documentId}) : super(key: key);
  final String documentId;

  @override
  _FlashesListState createState() => _FlashesListState();
}

class _FlashesListState extends State<FlashesList> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _mediasStream = FirebaseFirestore.instance
        .collection('Medias/' + widget.documentId + '/Flashes')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _mediasStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        final data = snapshot.requireData;

        var widgets = <Widget>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...buildFlashes(data: data),
          ],
        );
      },
    );
  }

  List<Widget> buildFlashes({data, start, end}) {
    List<Widget> list = [];

    for (int i = 0; i < data.size; i++) {
      list.add(Text(data.docs[i]['description']));
    }

    return list;
  }
}

class TopSection extends StatelessWidget {
  const TopSection({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        20.0,
        15.0,
        20.0,
        5.0,
      ),
      child: Row(
        children: [
          const BackButton(),
          Text(
            name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}

class MediaDetails extends StatelessWidget {
  const MediaDetails({Key? key, required this.lenght, required this.link})
      : super(key: key);
  final String link;
  final String lenght;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          25.0,
          5.0,
          25.0,
          5.0,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Lenght: ' + lenght,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Respond to button press
              Clipboard.setData(ClipboardData(text: link));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied Media Link'),
                ),
              );
            },
            icon: const Icon(Icons.copy, size: 18),
            label: const Text("Media Link"),
          ),
        ]));
  }
}
