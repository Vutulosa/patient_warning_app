import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/MediaDetailScreen/media_detail_screen.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MediaList();
  }
}

class MediaList extends StatefulWidget {
  const MediaList({Key? key}) : super(key: key);

  @override
  _MediaListState createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  final Stream<QuerySnapshot> _mediasStream =
      FirebaseFirestore.instance.collection('Medias').snapshots();

  @override
  Widget build(BuildContext context) {
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

        return ListView.separated(
          itemCount: data.size,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.movie,
                color: Colors.teal,
              ),
              title: Text(data.docs[index]['name']),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MediaDetailScreen(media: data.docs[index]),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
