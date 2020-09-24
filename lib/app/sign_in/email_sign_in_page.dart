import 'package:flutter/material.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        elevation: 2.9,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(child: _buildContent())),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Container();
  }
}
