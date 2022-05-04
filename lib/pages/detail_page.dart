import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class detailPage extends StatelessWidget {
  final Map article;
  const detailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _launchUrl(url) async{
     await launchUrlString(url);
    }
    const TextStyle style = TextStyle(color: Colors.white);
    print(article);
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Whyte News'),
        centerTitle: true,

      ),
      backgroundColor: Colors.black,
      
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.3,
            child:article['urlToImage']!=null?Center(child: Image.network(article['urlToImage']),): Center(child: Text('No Image available',style: style,))
          ),
          const Text('Title :',style: style,),
          Wrap(
            children: [Text(article['title'],style: style,)],
          ),
          const Text('Description : ',style: style,),
          Wrap(
            children:[
              Text(article['description']!=null?article['description']:'No description available',style: style,)
            ]
          ),
         
          article['author']!=null? Row(children:[ const Text('Author :',style: style,),Text(article['author'],style: style,)]):Container(),
          Container(
            margin:const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: Colors.blueAccent
            ),
            width: double.infinity,
            child: TextButton(
              child:const Text('Read More',style: style,),
              onPressed: (){
                _launchUrl(article['url']);
              },
              ),
          )
        ]),
      ),
    );
  }
}
