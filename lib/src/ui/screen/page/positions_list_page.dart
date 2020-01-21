import 'package:flutter/material.dart';
import 'package:jobber/src/core/model/screen_arguments.dart';
import 'package:jobber/src/core/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:jobber/src/core/provider/jobs_provider.dart';

class PositionsListPage extends StatefulWidget {
  PositionsListPage({Key key}) : super(key: key);

  @override
  _PositionsListPageState createState() => _PositionsListPageState();
}

class _PositionsListPageState extends State<PositionsListPage> {

  ScrollController _scrollController = ScrollController();

  JobsProvider jobsProvider;
  LocationProvider locationProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  void initialize() {

    Future.delayed(Duration.zero, () async{
      jobsProvider = Provider.of<JobsProvider>(context, listen: false);
      locationProvider = Provider.of<LocationProvider>(context, listen: false);

      _scrollController.addListener(() {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          bool isServiceOn = locationProvider.isServiceOn();
          if (isServiceOn) {
            jobsProvider.getJobs(
              latitude: locationProvider.latitude,
              longtitude: locationProvider.longtitude,
            );
          } else {
            jobsProvider.getJobs();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsProvider>(builder: (context, jobsProvider, child) {
      return _content(context, jobsProvider);
      // return jobsProvider.isLoading
      //     ? _loading(context)
      //     : _content(context, jobsProvider);
    });
  }

  Widget _content(BuildContext context, jobsProvider) {
    final jobs = jobsProvider.jobs;

    if (jobs.isEmpty) {
      return Container(
        key: Key('Empty'),
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Sorry, there are no open positions in your area. Please try again later',
          style: Theme.of(context).textTheme.subhead.copyWith(
                color: Colors.white54,
              ),
          textAlign: TextAlign.center,
        ),
      );
      
    } else {
      return ListView.separated(
          controller: _scrollController,
          key: Key('Content'),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(height: 1.0),
          itemCount: jobs.length + 1,
          itemBuilder: (context, index) {
            if (index == jobs.length) {
              return jobsProvider.isMoreData
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ))
                  : null;
            }
            final job = jobs[index];
            return ListTile(
              key: ValueKey(job['id']),
              title: Text("[${index}] ${job['title']}"),
              subtitle: Text("${job['location']}"),
              trailing: Icon(Icons.bookmark),
              // trailing: jobsProvider.findItemById(job['id'])
              //     ? Icon(Icons.bookmark)
              //     : null,
              onTap: () => Navigator.of(context).pushNamed(
                '/detail',
                arguments: ScreenArguments(
                  id: job['id'].toString(),
                  type: job['type'].toString(),
                  url: job['url'].toString(),
                  created_at: job['created_at'].toString(),
                  company_url: job['company_url'].toString(),
                  location: job['location'].toString(),
                  title: job['title'].toString(),
                  description: job['description'],
                  how_to_apply: job['how_to_apply'],
                  company_logo: job['company_logo'].toString(),
                  company: job['company'].toString(),
                  // parentKey: parentKey,
                ),
              ),
            );
          });
    }
  }

  Widget _loading(BuildContext context) => Container(
        key: Key('Loading'),
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
}
