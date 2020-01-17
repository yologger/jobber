import 'package:flutter/material.dart';
import 'package:jobber/src/core/model/screen_arguments.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:jobber/src/core/provider/jobs_provider.dart';


class SavedListPage extends StatefulWidget {
  SavedListPage({Key key}) : super(key: key);

  @override
  _SavedListPageState createState() => _SavedListPageState();
}


class _SavedListPageState extends State<SavedListPage> {

  ScrollController _scrollController = ScrollController();

  JobsProvider jobsProvider;

  final bool isLocationActivated = true;
  final String userLocation = 'new+york';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      jobsProvider = Provider.of<JobsProvider>(context, listen: false);
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          jobsProvider.getJobs();
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
      return isLocationActivated
          ? jobsProvider.isLoading
              ? _loading(context)
              : _content(context, jobsProvider)
          : _requestLocation(context);
    });
  }

  Widget _content(BuildContext context, jobsProvider) {

    final saved = jobsProvider.saved;

    if (saved.isEmpty) {
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
          itemCount: saved.length,
          itemBuilder: (context, index) {
            // if (index == saved.length) {
            //   return jobsProvider.isMoreData
            //       ? Center(
            //           child: Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: CircularProgressIndicator(),
            //         ))
            //       : null;
            // }
            final job = saved[index];
            return ListTile(
              key: ValueKey(job.id),
              title: Text("[${index}] ${job.title}"),
              subtitle: Text("${job.location}"),
              trailing: Icon(Icons.star),
              onTap: () => Navigator.of(context).pushNamed(
                '/detail',
                arguments: ScreenArguments(
                  id: job.id.toString(),
                  type: job.type.toString(),
                  url: job.url.toString(),
                  created_at: job.created_at.toString(),
                  company_url: job.company_url.toString(),
                  location: job.location.toString(),
                  title: job.title.toString(),
                  description: job.description,
                  how_to_apply: job.how_to_apply,
                  company_logo: job.company_logo.toString(),
                  company: job.company.toString(),
                  // parentKey: parentKey,
                ),
              ),
            );
          });
    }
  }

  Widget _requestLocation(BuildContext context) {
    return Container(
        key: Key('Empty'),
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Location Access Disabled',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.white54,
                  ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Please Allow "Jobber" to use your location.',
              style: Theme.of(context).textTheme.body1.copyWith(
                    color: Colors.white54,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }

  Widget _loading(BuildContext context) => Container(
        key: Key('Loading'),
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );

}
