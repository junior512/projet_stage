import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'album.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}):super(key: key);

  

  @override
  _HomePageState createState() => _HomePageState();
}

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
 
  // ··

class _HomePageState extends State<HomePage> {
late Future<Album> futureAlbum;
@override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }
 

  @override
   
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
         appBar: AppBar(
           title: Text('fetch jkapi'


             ),
            centerTitle: true,


          ),
     body: FutureBuilder<Album>(
           future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
               return Text(snapshot.data!.title);
               } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
               }

              // By default, show a loading spinner.
             return const CircularProgressIndicator();
             },
          ),


      )
      

    );
    
    
  }
}
