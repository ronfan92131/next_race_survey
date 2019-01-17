import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Race Survey',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Race Survey Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('nextrace').snapshots(),
          builder: (context,snapshot){
            if (!snapshot.hasData) return const Text('Loading...');

            return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          }),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                document['race'],
                style: Theme.of(context).textTheme.display1,
              ),
            ),

            Container(
                decoration: const BoxDecoration(
                  //color: Color(0xffddddff),
                  color: Colors.lightGreen,
                ),
                padding: const EdgeInsets.all(10.0),
                child:Text(
                  document['vote'].toString(),
                  style: Theme.of(context).textTheme.display1,
                )
            ),
          ],
        ),
        onTap: (){
          //document['vote'] = document['vote'] + 1;
          print("Should increase votes here");
        }
    );
  }
}
