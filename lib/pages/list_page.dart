import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helpers/response.dart';
import 'package:news_app/widgets/article_widget.dart';
import '../helpers/Api.dart';
import '../helpers/urlComposer.dart';
import '../helpers/countryList.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int page = 1;
  String countryCode = 'us';
  late Future<Response> futureResponse;
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  final TextEditingController _textController = TextEditingController();
  void getApi() {
    futureResponse =
        fetchResponse(UrlComposer.urlWithCountryOfChoice(countryCode, page));
  }

  void getApiWithKey(String keyword) {
    futureResponse =
        fetchResponse(UrlComposer.defaulUrlWithKeyword(keyword, page));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getApi();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(color: Colors.white);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Whyte News'),
          centerTitle: false,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton(
                dropdownColor: Colors.black,
                elevation: 0,
                underline: Container(),
                alignment: Alignment.center,
                value: countryCode,
                icon: const Icon(
                  Icons.flag,
                  color: Colors.white,
                ),
                onChanged: (newValue) {
                  setState(() {
                    countryCode = newValue.toString();
                    getApi();
                  });
                },
                items: countryCodes.map((String value) {
                  return DropdownMenuItem(
                    child: Center(
                        child: Text(
                      value,
                      style: style,
                    )),
                    value: value,
                  );
                }).toList(),
              ),
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: Column(children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: Row(
                children: [
                  Flexible(
                      flex: 7,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border:Border.all(
                            color: Colors.white
                          )
                        ),
                        child: TextField(
                          style: style,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide.none
                            ) ,
                              hintText: 'Enter a keyword', hintStyle: style),
                          controller: _textController,
                          onSubmitted: (value) {
                            setState(() {
                              _textController.clear();
                              getApiWithKey(value);
                            });
                          },
                        ),
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          getApi();
                        });
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ))
                ],
              )),
          Expanded(
            child: FutureBuilder(
              future: futureResponse,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List articleList = snapshot.data.articles;
                  double maxPages = (snapshot.data.totalResults / 20);
                  print(snapshot.data.totalResults.toString());
                  return ListView(
                    controller: _scrollController,
                    children: [
                      ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articleList.length,
                          itemBuilder: (BuildContext context, index) {
                            return ArticleWidget(article: articleList[index]);
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            height: 30,
                            color: Colors.blueAccent,
                            child: TextButton(
                              child: const Text(
                                'Prev',
                                style: style,
                              ),
                              onPressed: () {
                                if (page != 1) {
                                  setState(() {
                                    page = page - 1;
                                    getApi();
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('First page reached')));
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            height: 30,
                            color: Colors.blueAccent,
                            child: TextButton(
                              child: const Text(
                                'Next',
                                style: style,
                              ),
                              onPressed: () {
                                if (page < maxPages.ceil()) {
                                  setState(() {
                                    page = page + 1;
                                    print(page);
                                    getApi();
                                    _scrollController.animateTo(0,
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.linear);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Last page reached')));
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.blue));
                }
              },
            ),
          )
        ]));
  }
}
