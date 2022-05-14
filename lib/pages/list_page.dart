import 'package:flutter/material.dart';
import 'package:news_app/helpers/response.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/dropDownMenus.dart';
import '../helpers/Api.dart';
import '../helpers/urlComposer.dart';
import '../widgets/searchBar.dart';
import '../widgets/navButtons.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

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

  void onChanged(newValue) {
    setState(() {
      countryCode = newValue.toString();
      getApi();
    });
  }

  void onSearch(newValue) {
    setState(() {
      _textController.clear();
      getApiWithKey(newValue);
    });
  }

  void clearSearch() {
    setState(() {
      getApi();
    });
  }

  void getApi() {
    futureResponse =
        fetchResponse(UrlComposer.urlWithCountryOfChoice(countryCode, page));
  }

  void getApiWithKey(String keyword) {
    futureResponse =
        fetchResponse(UrlComposer.defaulUrlWithKeyword(keyword, page));
  }

  void prevPage() {
    if (page != 1) {
      setState(() {
        page = page - 1;
        getApi();
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('First page reached')));
    }
  }

  void nextPage(maxPages) {
    if (page < maxPages.ceil()) {
      setState(() {
        page = page + 1;
        print(page);
        getApi();
        _scrollController.animateTo(0,
            duration: const Duration(milliseconds: 100), curve: Curves.linear);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Last page reached')));
    }

//Init State
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
            actions: [DropMenu(onChanged: onChanged, value: countryCode)],
          ),
          backgroundColor: Colors.black,
          body: Column(children: [
            SearchBar(
                onSearch: onSearch,
                clearSearch: clearSearch,
                controller: _textController),
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
                            physics: const ClampingScrollPhysics(),
                            itemCount: articleList.length,
                            itemBuilder: (BuildContext context, index) {
                              return ArticleWidget(article: articleList[index]);
                            }),
                        BottomNavButtons(
                            nextPage: nextPage,
                            prevPage: prevPage,
                            maxPages: maxPages)
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
