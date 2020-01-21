import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobber/src/core/provider/location_provider.dart';
import 'package:jobber/src/ui/widget/home_app_bar.dart';
import 'package:jobber/src/ui/screen/page/positions_list_page.dart';
import 'package:jobber/src/ui/screen/page/saved_list_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [HomeAppBar()],
          body: TabBarView(
            children: <Widget>[
              PositionsListPage(),
              SavedListPage(),
            ],
          ),
        ),
      ),
    );
  }
}

