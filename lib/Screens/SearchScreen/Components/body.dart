import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/MediaDetailScreen/media_detail_screen.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _mediasStream = FirebaseFirestore.instance
        .collection('Medias')
        .where('name')
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

        return MediaList(data: data);
      },
    );
  }
}

class MediaList extends StatefulWidget {
  const MediaList({Key? key, required this.data}) : super(key: key);
  final QuerySnapshot<Object?> data;

  @override
  _MediaListState createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<Object?>> list = [];

    for (int i = 0; i < widget.data.size; i++) {
      if (name.isEmpty) {
        list = widget.data.docs;
        break;
      }
      if (widget.data.docs[i]['name'].toString().toUpperCase().contains(name)) {
        list.add(widget.data.docs[i]);
      }
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
        child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.search,
              ),
            ),
            onChanged: (String value) {
              setState(() {
                name = value.toUpperCase();
              });
            }),
      ),
      ListView.separated(
        shrinkWrap: true,
        itemCount: list.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(
              Icons.movie,
              color: Colors.teal,
            ),
            title: Text(list[index]['name']),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MediaDetailScreen(media: list[index]),
                ),
              );
            },
          );
        },
      )
    ]);
  }
}
