import 'package:flutter/material.dart';
import 'package:jobber/src/core/model/screen_arguments.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jobber/src/core/provider/jobs_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments =
        (ModalRoute.of(context).settings.arguments) as ScreenArguments;

    JobsProvider jobsProvider = Provider.of<JobsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Position'),
      ),
      floatingActionButton: FloatingActionButton(
        child: jobsProvider.findItemById(arguments.id) ? Icon(Icons.star) : Icon(Icons.star_border),
        onPressed: () {
          if (jobsProvider.findItemById(arguments.id)) {
            jobsProvider.remove(arguments.id);
          } else {
            jobsProvider.save(arguments);
          }
        },
      ),
      body: _content(context, arguments),
    );
  }

  Widget _content(BuildContext context, var arguments) {
    return Center(
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
            title: Text(arguments.company),
            subtitle: Text(arguments.location),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              arguments.type,
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
              data: arguments.description,
              onTapLink: (url) => _launchUrl(url, context),
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
                data: arguments.how_to_apply,
                onTapLink: (url) => _launchUrl(url, context),
              ),
            ),
          ),
          SizedBox(height: 80.0),
        ],
      ),
    );
  }

  void _launchUrl(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Failed to launch url.'),
      ));
    }
  }

  Widget _loading() {
    return Center(
      key: Key('Loading'),
      child: CircularProgressIndicator(),
    );
  }
}
