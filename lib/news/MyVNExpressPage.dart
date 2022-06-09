// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/news/PageBao.dart';
import 'package:flutter_app/news/RSSItem.dart';

import 'RSS_helper.dart';

class MyVNexpressPage extends StatefulWidget {
  const MyVNexpressPage({ Key? key }) : super(key: key);

  @override
  State<MyVNexpressPage> createState() => _MyVNexpressPageState();
}

class _MyVNexpressPageState extends State<MyVNexpressPage> {
  late Future<List<RSSItem>?> rssItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("My VNexpress Page"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
            rssItems = RSS_Helper.readVNExpressRSS()
              .whenComplete(() => 
                setState(() {}));
          },
        child: FutureBuilder<List<RSSItem>?>(
          future: rssItems,
          builder: 
            (context, snapshot) {
              if(snapshot.hasData){
                var listItem = snapshot.data!;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => PageBao( link: listItem[index].url ),)
                        );
                      },
                      child: ListTile(
                        // isThreeLine: false,
                        leading: _getImage(listItem[index].imageUrl),
                        title: Text("${listItem[index].title}"),
                        subtitle: Text("${listItem[index].description}"),
                      )
                    );
                  }
                  , 
                  separatorBuilder: (context, index) => const Divider(thickness: 2,), 
                  itemCount: listItem.length);
              }
              return const Center(child: CircularProgressIndicator(),);
            },
            
            ),

      )
    );
  }
  @override
  void initState() {
    super.initState(); 
    rssItems = RSS_Helper.readVNExpressRSS();
  }
  Widget _getImage(String? url) {
    if(url != null){
      return Image.network(url, fit: BoxFit.fitWidth,);
    }
    return const Icon(Icons.image);
  }
}