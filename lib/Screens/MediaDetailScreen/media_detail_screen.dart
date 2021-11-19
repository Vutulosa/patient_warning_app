import 'package:flutter/material.dart';
import 'package:patient_warning_app/Screens/HomeScreen/Components/body.dart';

class MediaDetailScreen extends StatelessWidget {
  const MediaDetailScreen({Key? key, required this.media}) : super(key: key);

  final Media media;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
            const Spacer(),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          Row(
            children: [Text(media.lenght)],
          ),
        ],
      ),
    );
  }
}
