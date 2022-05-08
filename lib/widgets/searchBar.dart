import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final  Function onSearch;
  final Function clearSearch;
  final TextEditingController controller;

  const SearchBar({Key? key,required this.onSearch,required this.clearSearch,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(color: Colors.white);
    return   Container(
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
                          style:style,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide.none
                            ) ,
                              hintText: 'Enter a keyword', hintStyle:TextStyle(color: Colors.white)),
                          controller:controller,
                          onSubmitted:(value){
                            onSearch(value);
                          }
                        ),
                      )),
                  IconButton(
                      onPressed: (){clearSearch();},
                      icon:const Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ))
                ],
              ));
  }
}