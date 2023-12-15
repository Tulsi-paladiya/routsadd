import 'dart:convert';
import 'package:demo/until/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/albums_model.dart';

class AlbumsApi extends StatefulWidget {
  const AlbumsApi({super.key});

  @override
  State<AlbumsApi> createState() => _AlbumsApiState();
}

class _AlbumsApiState extends State<AlbumsApi> {
  List<Albums> albumsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("Albums"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: albumsList.length,
            itemBuilder: (context, index) {
              final albums = albumsList[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("userId :  ${albums.userId}",
                          style: MyTextStyle.details),
                      Text("Id :  ${albums.id}", style: MyTextStyle.details),
                      Text("title :  ${albums.title}",
                          style: MyTextStyle.details),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Albums>> getData() async {
    final responce = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums?userId=1"));
    var data = jsonDecode(responce.body.toString());

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        albumsList.add(Albums.fromJson(index));
      }

      return albumsList;
    } else {
      return albumsList;
    }
  }
}
