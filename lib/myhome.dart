import 'dart:convert';

import 'package:api_json_parsing/model/team.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHome extends StatelessWidget {
  //another example for http calls
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  // var url =
  //     Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

  // // Await the http get response, then decode the json-formatted response.
  // var response = await http.get(url);
  // if (response.statusCode == 200) {
  //   var jsonResponse =
  //       convert.jsonDecode(response.body) as Map<String, dynamic>;
  //   var itemCount = jsonResponse['totalItems'];
  //   print('Number of books about http: $itemCount.');
  // } else {
  //   print('Request failed with status: ${response.statusCode}.');
  // }
  MyHome({super.key});
  List<Team> teams = [];
  Future getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsonResponse = jsonDecode(response.body);
    for (var info in jsonResponse['data']) {
      var team = Team(team: info['city'], abbreviation: info['abbreviation']);
      teams.add(team);
    }
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
        body: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(teams[index].team),
                    );
                  },
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
