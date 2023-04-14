import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class districtData extends StatefulWidget {
  districtData({super.key,required this.dis_data}) ;
  Map<String,dynamic> dis_data;

  @override
  State<districtData> createState() => _districtDataState();
}

class _districtDataState extends State<districtData> {
  @override
  late List _items=[];


  Future<void> readJson_district() async {

      for(var key in widget.dis_data.keys){
        setState(() {
          _items.add(key);
        });
      }
  }
    
  @override  
  Widget build(BuildContext context) {

    Future<void> _dialogBuilder(BuildContext context,var index, value) {
      var xyz=_items[index];
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                title:  Text("<$xyz> district details",style: TextStyle(color: Colors.red),),
                content: Column(
                  children: [
                    Text("$value",style: TextStyle(color: Colors.red),),
                  ],
                ),
                actions: <Widget>[
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
        backgroundColor: Colors.cyanAccent,
        title: Text("District Data",style: TextStyle(color:Colors.red),),
      ),
      body:Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: () => readJson_district(), child: Text("Load District Data",style: TextStyle(color: Colors.red),)),
            Expanded(
              child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    var xyz=_items[index];
                    var value=widget.dis_data[xyz];
                  return Card(
                    color: Colors.cyanAccent,
                  margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(child: Text('$xyz',style: TextStyle(color: Colors.red),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyanAccent)),
                          onPressed: () => _dialogBuilder(context, index, value),
                        ),
                      ),
                      //title: Text(_items[index]["name"]),
                    ));
                }
              ),
            ),
          ],
        ),
      )
      );
  }
}
