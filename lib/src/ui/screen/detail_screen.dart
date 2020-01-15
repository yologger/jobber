import 'package:flutter/material.dart';
import 'package:jobber/src/core/model/screen_arguments.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DetailScreen extends StatefulWidget {
  final int index;

  DetailScreen({Key key, this.index}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        (ModalRoute.of(context).settings.arguments) as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Position'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.star_border),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                '${arguments.title}',
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              title: Text('Samsung'),
              subtitle: Text('Seoul, Korea'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Full Time',
                style: Theme.of(context).textTheme.body2.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
            ),
            Divider(height: kToolbarHeight),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Description',
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 16.0,
                    ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: MarkdownBody(
                data:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                onTapLink: (url) => print(url),
              ),
            ),
            Divider(height: kToolbarHeight),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'How to apply',
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 16.0,
                    ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 0.0,
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              color: Colors.white10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: MarkdownBody(
                  data:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  onTapLink: (url) => print('url'),
                ),
              ),
            ),
            SizedBox(height: 80.0),
          ],
        ),
      ),
    );
  }
}
