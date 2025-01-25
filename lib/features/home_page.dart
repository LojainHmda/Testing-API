import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> posts = [];
   late String source ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing API"),
      ),
      body: Center(
        child: posts.isEmpty
            ? FloatingActionButton(
                onPressed: () async{
                  Dio dio =Dio();       
                             Response response = await dio.get("https://jsonplaceholder.typicode.com/posts");
                             Response responseImage = await dio.get("https://api.thecatapi.com/v1/images/search");

                  setState(()  {
                   posts=response.data;
                   source =responseImage.data[0]["url"];
                  });
                },
                child: const Text("Get Data"),
              )
            : Column(
              children: [
                Image.network(source),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(posts[index]["title"]),
                        );
                      },
                    ),
                ),
              ],
            ),
      ),
    );
  }
}