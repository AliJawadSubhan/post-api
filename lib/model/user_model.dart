import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:post_api_testing/HOME/home_page.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final TextEditingController jobController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? userName;
  String? userJob;

  Future<UserModel> postApiData(String name, String job) async {
    UserModel? user;
    String url = 'https://reqres.in/api/users';

    var data = {
      "name": name,
      'job': job,
    };

    http.Response response = await http.post(Uri.parse(url), body: data);

    var json = jsonDecode(response.body);

    setState(() {
      userName = json['name'];
      userJob = json['job'];
    });

    user = UserModel.fromJson(json);
    log(response.body);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Exotic Form',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to the Exotic World!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: jobController,
                    decoration: const InputDecoration(
                      labelText: 'Your Job',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      // Perform form submission logic here
                      String job = jobController.text;
                      String name = nameController.text;

                      UserModel user = await postApiData(name, job);
                      // setState(() {
                      //   userName = user.name!;
                      //   userJob = user.job!;
                      // });

                      log('Job: $job, Name: $name');
                    },
                    child: const Text('Submit'),
                  ),
                  userName == null ? Container() : Text(userName.toString()),
                  userJob == null ? Container() : Text(userJob.toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
