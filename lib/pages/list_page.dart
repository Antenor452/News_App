import 'package:flutter/material.dart';
import 'package:news_app/helpers/functions.dart';
import 'package:news_app/helpers/response.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/dropDownMenus.dart';
import '../helpers/Api.dart';
import '../helpers/urlComposer.dart';
import '../widgets/searchBar.dart';
import '../widgets/navButtons.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _controller = TextEditingController();
  late Future<Response> futureResponse;
  int page = 1;
  String countryCode = 'us';

  //Functions //
  void onSearch(newValue) {}
  void clearSearch() {}

  //InitState//
  @override
  void initState() {
    futureResponse = Functions.getApi(countryCode: countryCode, page: page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('NewsAppByWhyte'),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchBar(
                onSearch: onSearch,
                clearSearch: clearSearch,
                controller: _controller),
            Expanded(
                child: FutureBuilder(
                    future: futureResponse,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
                        case ConnectionState.done:
                        Response response=snapshot.data;
                        if(snapshot.hasData && !snapshot.hasError && response.totalResults!=0){
                        int itemCount = response.articles.length;

                          return  ListView(
                            children: [
                              Flex(direction: Axis.vertical,
                              children: [ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: itemCount,
                                        itemBuilder: (context, index) {
                                          return ArticleWidget(
                                            article: response.articles[index],
                                          );
                                        })],
                              )
                            ],
                          );
                        }
                          
                        if(response.totalResults==0){
                          return const Center(
                            child: Text('No results'),
                          );
                        }
                        else{
                          return Center();
                        }
                       
                        }
                       
                    })),
          ],
        ),
      ),
    );
  }
}
