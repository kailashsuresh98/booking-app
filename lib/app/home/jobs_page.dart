import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/app/home/add_job_page.dart';
import 'package:my_app/common_widgets/platform_alert_dialog.dart';
import 'package:my_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/services/auth_provider_del.dart';
import 'package:my_app/services/database.dart';
import 'package:provider/provider.dart';

import 'models/job.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _createJob(BuildContext context) async {
    try {
      final database = Provider.of<Database>(context);
      await database.createJob(Job(name: 'blogging', ratePerHour: 10));
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(title: 'Operation Failed', exception: e)
          .show(context);
    }
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final jobs = snapshot.data;
            final children = jobs.map((job) => Text(job.name)).toList();
            return ListView(children: children);
          }
          if (snapshot.hasError) {
            return Center(child: Text('Some error occured'));
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookings'), actions: <Widget>[
        FlatButton(
          child: Text('logout',
              style: TextStyle(fontSize: 18.0, color: Colors.white)),
          onPressed: () => _confirmSignOut(context),
        )
      ]),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddJobPage.show(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
