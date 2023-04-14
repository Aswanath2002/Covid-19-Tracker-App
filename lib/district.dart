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
  void initState() {
    // TODO: implement initState
    readJson_district();
    super.initState();
  }
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
      var notes = value["notes"];
      var active = value["active"];
      var confirmed = value["confirmed"];
      var migratedother = value["migratedother"];
      var deceased = value["deceased"];
      var recovered = value["recovered"];
      var delta = value["delta"];
      var delta_confirmed = delta["confirmed"];
      var delta_deceased = delta["deceased"];
      var delta_recovered = delta["recovered"];

      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                title:  Text("$xyz district details",style: TextStyle(color: Colors.red),),
                content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("notes : $notes",textAlign: TextAlign.left,style: TextStyle(color: Colors.red,),),
                      Text("active : $active",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
                      Text("confirmed : $confirmed",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
                      Text("migratedother : $migratedother",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
                      Text("deceased : $deceased",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
                      Text("recovered : $recovered",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text("delta :- ",textAlign: TextAlign.left,style: TextStyle(color: Colors.red,),),
                            Text("confirmed : $delta_confirmed",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
                            Text(",deceased : $delta_deceased",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
                            Text(",recovered : $delta_recovered",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
                          ],
                        ),
                      )

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
        backgroundColor: Colors.cyan,
        title: Text("District Data",style: TextStyle(color:Colors.red),),
      ),
      body:Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
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
