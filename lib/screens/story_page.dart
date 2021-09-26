import 'package:flutter/material.dart';

class story_page extends StatelessWidget {
  final String title, text, image;
  const story_page(
      {Key? key, required this.title, required this.text, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('$title'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text('$text')
            ],
          ),
        ),
      ),
    );
  }
}
