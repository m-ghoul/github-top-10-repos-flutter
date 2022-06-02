// Import statements
import 'dart:convert';
import 'package:flutter/material.dart';
import './repo.dart';
import 'package:http/http.dart' as http;

// Main function that runs MyApp
void main() {
  runApp(MaterialApp(home: Scaffold(body: Center(child: MyApp()))));
}

// Stateless widget that runs the first screen that is seen when the app is opened
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return Scaffold containing the main UI design
    return MaterialApp(
        home: Builder(
            // Scaffold provides basic functionality such as an app bar and a body
            builder: (context) => Scaffold(
                // App Bar is the header that appears on top of the app
                appBar: AppBar(title: Text("GitFetcher")),
                // Center places its child at the center of the screen
                body: Center(
                    // Column places all its children in a column, where widgets are displayed in a top-down fashion
                    child: Column(
                  children: [
                    // Container adds some extra properties to its child such as margin and padding
                    Container(
                        child: Image.asset('assets/images/github_logo.png'),
                        margin: EdgeInsets.all(50)),
                    // The elevated button, unlike a flat button, looks "elevated" on the screen
                    ElevatedButton(
                        // Pressing the button switches the screen to the one containing the top 10 GitHub repos
                        onPressed: () => _displayResults(context),
                        // The child displays content on the button
                        child: Text("Fetch top 10 repositories"),
                        style: ElevatedButton.styleFrom(
                            // Primary is the color of the button itself while on primary refers to the color of the child that is on the button
                            primary: Colors.blue,
                            onPrimary: Colors.white))
                  ],
                )))));
  }

  // displayResults switches the screen to an instance of Stats, which gets and displays the top 10 GitHub repos
  void _displayResults(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Stats()));
  }
}

class Stats extends StatelessWidget {
  // The type Future is used for async/await functions
  static Future<List<Map>> getTop10Repos() async {
    var url = Uri.parse("http://10.0.2.2:5000/repos/top10");
    var response = await http.get(url);
    List<Map<String, dynamic>> parsed = [];
    // Converting the json object to a Dart object and storing it in a list of maps (dictionaries but for Dart)
    parsed = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    return parsed;
  }

  @override
  Widget build(BuildContext context) {
    // FutureBuilder is used when we are building a widget that uses values from an asynchronous function
    // We also have to match the data type of Future to match the output of the asynchronous function
    return FutureBuilder<List<Map>>(
        // In future, we enter the asynchornous function whose value we depend on
        future: getTop10Repos(),
        // Asynchronous snapshot provides us with a snapshot containing the returned value of the asynchronous function
        // The data type of the snapshot should match the output of the asynchronous function
        builder: (context, AsyncSnapshot<List<Map>> snapshot) {
          var data = snapshot.data;
          var idList = [];
          var nameList = [];
          var starsList = [];
          if (data != null) {
            idList = data.map((e) => e['id']).toList();
            nameList = data.map((e) => e['name']).toList();
            starsList = data.map((e) => e['stars']).toList();
          } // [1, 35, 93, 82, 28]
          return Scaffold(
              appBar: AppBar(title: Text("Top 10 Respositories (by stars)")),
              body: Center(
                  // ListView displays widgets as a scrollable array of widgets in a top-down fashion
                  child: ListView(children: [
                Repo(idList[0], nameList[0], starsList[0]),
                Repo(idList[1], nameList[1], starsList[1]),
                Repo(idList[2], nameList[2], starsList[2]),
                Repo(idList[3], nameList[3], starsList[3]),
                Repo(idList[4], nameList[4], starsList[4]),
                Repo(idList[5], nameList[5], starsList[5]),
                Repo(idList[6], nameList[6], starsList[6]),
                Repo(idList[7], nameList[7], starsList[7]),
                Repo(idList[8], nameList[8], starsList[8]),
                Repo(idList[9], nameList[9], starsList[9]),
              ])));
        });
  }
}
