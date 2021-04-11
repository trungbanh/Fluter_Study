import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'Album.dart';
import 'Routers.dart';

class MyHomePage extends StatefulWidget {
  late String title;

  MyHomePage({title}) {
    this.title = title;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<List<Album>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Album>.
List<Album> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Album>((json) => Album.fromJson(json)).toList();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<Album> futureAlbum;
  late Future<List<Album>> albums;
  final items = ['a' * 5, 'b' * 5, 'c' * 5];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }
  itemBuilder(String data) {
    return ListTile(
      title: Text(data),
      onTap: () =>
          Navigator.pushReplacementNamed(context, detailRoute, arguments: data),
    );
  }


  _getUsers() {
    http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums')).then((response) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.login), onPressed: () =>
                  Navigator.pushReplacementNamed(context, loginRoute))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<List<Album>>(
          future: fetchPhotos(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => itemBuilder(snapshot.data![index].title),
                )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}