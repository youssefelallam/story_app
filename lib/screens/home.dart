import 'dart:convert';

import 'package:app_story/screens/story_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List my_data = <Map>[];
  get_data() async {
    http.Response response =
        await http.get(Uri.parse('API URL'));
    var jsondata = jsonDecode(response.body);
    setState(() {
      my_data = jsondata;
    });
  }

  @override
  void initState() {
    super.initState();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/cover.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                ),
                Flexible(
                  child: my_data.isEmpty
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: my_data.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => story_page(
                                            title: my_data[index]['title'],
                                            text: my_data[index]['text'],
                                            image: my_data[index]['img'])));
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                my_data[index]['img']),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${my_data[index]['title']}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
