import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _posts = List.generate(12, (i) => 'Post ${i + 1}');

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {
              // TODO: abrir câmera/galeria
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _posts.length,
        itemBuilder: (_, i) => Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text('Autor ${i + 1}'),
                subtitle: const Text('há 2h'),
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(color: Colors.grey.shade300),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text('Legenda do ${_posts[i]}'),
              ),
              ButtonBar(
                children: [
                  IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
