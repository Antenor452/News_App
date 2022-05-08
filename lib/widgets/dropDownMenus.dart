import 'package:flutter/material.dart';
import '../helpers/countryList.dart' ;

class DropMenu extends StatelessWidget {
  final  Function onChanged;
  final  String value;
  const DropMenu({Key? key,required this.onChanged, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton(
                dropdownColor: Colors.black,
                elevation: 0,
                underline: Container(),
                alignment: Alignment.center,
                value: value,
                icon: const Icon(
                  Icons.flag,
                  color: Colors.white,
                ),
                onChanged:(value){onChanged(value);},
                items: countryCodes.map((String value) {
                  return DropdownMenuItem(
                    child: Center(
                        child: Text(
                      value,
                      style: TextStyle(color: Colors.white),
                    )),
                    value: value,
                  );
                }).toList(),
              ),
            );
  }
}