import 'package:flutter/material.dart';
import 'package:news_app/pages/detail_page.dart';

class ArticleWidget extends StatelessWidget {
  final Map article;
  const ArticleWidget({Key? key,required this.article}) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
      color: Colors.white
    );
    final String title = article['title'];
    final String imgUrl = article['urlToImage']!=null?article['urlToImage']:'';
    
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: ((BuildContext context) => detailPage(article: article))));
      },
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
        decoration:const BoxDecoration(
          
          
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin:const EdgeInsets.only(right: 12),
              height: 100,
              width: 100,
              child: imgUrl!=''?Image.network(imgUrl):const Center(child:Text('No image available',style: style,))
            ),
           Flexible(child: Text(title!=''?title:'No title given',style: style,))
           
          ],
        ),
        Container(
          height: 2,
          width: MediaQuery.of(context).size.width*1,
          color: Colors.grey,
        )
          ],
        ),
        
           
        
      ),
    );
  }
}