import 'package:flutter/material.dart';
import 'package:login_form/Routers.dart';

class Detail extends StatefulWidget {
  var data;

  Detail(String data) {
    this.data = data;
  }

  @override
  _DetailState createState() => _DetailState(this.data);
}

class _DetailState extends State<Detail> {
  var data;

  _DetailState(String data) {
    this.data = data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.restorablePopAndPushNamed(context, homeRoute),
        ),
        title: Text("Detail"),
      ),
      body: Container(
        child: Text(
          this.data,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
