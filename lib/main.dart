import 'package:covid_19_tracker/district.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'LGM',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/district' : (context) => districtData(dis_data: {},),
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];
  late Map<String,dynamic> data = {};

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/covid.json');
    data = await json.decode(response);
    setState(() {
      for(var key in data.keys){
        _items.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Future<void> _dialogBuilder(BuildContext context,var index, value) {
      var xyz=value["statecode"];
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                title:  Text("STATE CODE : $xyz",style: TextStyle(color: Colors.red),),
                actions: <Widget>[
              TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('districtData',style: TextStyle(color: Colors.red),),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                  builder: (context) => districtData(dis_data: value["districtData"]),
                  ),
              );
              },),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('close',style: TextStyle(color: Colors.red),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),

                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text(
          'LGM Covid-19 Tracker',style: TextStyle(color: Colors.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJson,
              child: const Text('Load Data',style: TextStyle(color: Colors.red),),
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  var xyz=_items[index];
                  var value=data["$xyz"];
                  return Card(
                    color: Colors.cyanAccent,
                     margin: const EdgeInsets.all(10),
                      child: ListTile(
                         leading: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: TextButton(child: Text('$xyz',style: TextStyle(color: Colors.red),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyanAccent)),
                               onPressed: () => _dialogBuilder(context,index,value),
                           ),
                         ),
                         //title: Text(_items[index]["name"]),
                  ));
                },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}