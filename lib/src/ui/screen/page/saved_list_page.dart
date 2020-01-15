import 'package:flutter/material.dart';
import 'package:jobber/src/core/model/screen_arguments.dart';

class SavedListPage extends StatelessWidget {
  const SavedListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      initialItemCount: 5,
      itemBuilder: (context, index, animation) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
              onTap: () {
                print('${index} item tapped.!');
                Navigator.pushNamed(context, '/detail',
                    arguments: ScreenArguments(
                      id: 'data from ${index}',
                      title: 'hello',
                    ));
              },
            ),
            Divider(height: 1.0),
          ],
        );
      },
    );
  }
}
