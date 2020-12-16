import 'package:flutter/material.dart';
import 'package:memento_design_pattern/post.dart';

import 'generic_care_taker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TekStateKaydetme(),
    );
  }
}

class TekStateKaydetme extends StatefulWidget {
  @override
  _TekStateKaydetmeState createState() => _TekStateKaydetmeState();
}

class _TekStateKaydetmeState extends State<TekStateKaydetme> {

  final GenericCareTaker<Post> postManager = GenericCareTaker<Post>();
  final Post post = Post("", "");
  final TextEditingController controllerAuthor = TextEditingController();
  final TextEditingController controllerBody = TextEditingController();


  @override
  void initState() {
    super.initState();
    save();
    controllerAuthor.addListener(() {
      post.author = controllerAuthor.text;
    });
    controllerBody.addListener(() {
      post.body = controllerBody.text;
    });
  }

  void save() {
    postManager.memento = post.save();
  }

  void restore() {
    post.restore(postManager.memento);
    controllerAuthor.text = post.author;
//    controllerAuthor.setTextAndSelection(post.author);
    controllerBody.text = post.body;
//    controllerBody.setTextAndSelection(post.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tek state kaydetme", style: TextStyle(color: Color(0xffb74093)),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: controllerAuthor,
                decoration: InputDecoration(hintText: "Yazar"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: controllerBody,
                decoration: InputDecoration(hintText: "İçerik"),
              ),
            ),
            const SizedBox(height: 12),
            RaisedButton(
              onPressed: save,
              child: Text("Kaydet"),
            ),
            RaisedButton(
              onPressed: restore,
              child: Text("Kaydedilene geri dön"),
            ),
          ],
        ),
      ),
    );
  }
}
