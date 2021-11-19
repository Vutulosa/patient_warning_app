import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/MediaDetailScreen/media_detail_screen.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaList(
        media: List.generate(
      20,
      (i) => Media(
        'Media $i',
        '10:00',
        'link',
        List.generate(
          2,
          (i) => const Flash(
            '5:00',
            '6:00',
            'description',
          ),
        ),
      ),
    ));
  }
}

class MediaList extends StatelessWidget {
  const MediaList({Key? key, required this.media}) : super(key: key);

  final List<Media> media;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: media.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.movie,
            color: Colors.teal,
          ),
          title: Text(media[index].name),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MediaDetailScreen(media: media[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class Media {
  final String name;
  final String lenght;
  final String link;
  final List<Flash> flashes;

  const Media(this.name, this.lenght, this.link, this.flashes);
}

class Flash {
  final String start;
  final String end;
  final String description;

  const Flash(this.start, this.end, this.description);
}
