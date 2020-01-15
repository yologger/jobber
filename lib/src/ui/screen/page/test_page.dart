import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

final players = [
  {
    'name': 'ronaldo',
    'nation': 'portugal',
  },
  {
    'name': 'benzema',
    'nation': 'france',
  },
  {
    'name': 'ramos',
    'nation': 'spain',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
  {
    'name': 'kane',
    'nation': 'england',
  },
];

class _TestPageState extends State<TestPage> {
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      print(_controller.position.pixels);
      print(_controller.position.maxScrollExtent);
      // if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      //   print('HELLO!');
      // }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       controller: _controller,
  //       itemCount: players.length,
  //       itemBuilder: (ctx, index) {
  //         final player = players[index];
  //         return ListTile(
  //             title: Text("${player['name']}"),
  //             subtitle: Text("${player['nation']}"),
  //             trailing: Icon(Icons.star),
  //             onTap: () {});
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _controller,
        separatorBuilder: (context, index) => const Divider(height: 1.0),
        padding: EdgeInsets.zero,
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return ListTile(
              title: Text("${player['name']}"),
              subtitle: Text("${player['nation']}"),
              trailing: Icon(Icons.star),
              onTap: () {});
        });
  }
}
