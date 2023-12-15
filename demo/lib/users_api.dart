import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/model.dart';

class HomepageApi extends StatefulWidget {
  const HomepageApi({super.key});

  @override
  State<HomepageApi> createState() => _HomepageApiState();
}

class _HomepageApiState extends State<HomepageApi> {
  List<GetRequest> getrequest = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("Users"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
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
                      getText(index, "Id : ", getrequest[index].id.toString()),
                      getText(
                          index, "Name : ", getrequest[index].name.toString()),
                      getText(index, "User Name: ",
                          getrequest[index].username.toString()),
                      getText(index, "Email : ",
                          getrequest[index].email.toString()),
                      getText(index, "Webside : ",
                          getrequest[index].website.toString()),
                      getText(index, "Mobil No : ",
                          getrequest[index].phone.toString()),
                      getText(index, "Company : ",
                          getrequest[index].company.toString()),
                      getText(index, "Address : ",
                          '${getrequest[index].address.street.toString()},${getrequest[index].address.suite.toString()},${getrequest[index].address.city.toString()},\n${getrequest[index].address.zipcode.toString()},${getrequest[index].address.geo.lat.toString()},${getrequest[index].address.geo.lng.toString()}'),
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

  Widget getText(int index, String fielName, String content) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: fielName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(text: content, style: const TextStyle(fontSize: 16)),
      ]),
    );
  }

  Future<List<GetRequest>> getData() async {
    final responce =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(responce.body.toString());

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        getrequest.add(GetRequest.fromJson(index));
      }
      //getrequest.clear();
      return getrequest;
    } else {
      return getrequest;
    }
  }
}
