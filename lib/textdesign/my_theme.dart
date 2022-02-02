import 'package:flutter/material.dart';

class MyTheme{
  TextStyle _builtTextStyle(Color color,{double size = 16}){
      return TextStyle(
        color:color,
        fontSize: size,
      );
  }
  OutlineInputBorder _buildBorder(Color color ){
    return OutlineInputBorder (
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      )
    );
  }
  InputDecorationTheme theme()=> InputDecorationTheme(
    contentPadding: EdgeInsets.all(20),
    isDense: true,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    constraints: BoxConstraints(maxWidth:600 ),

    //Borders
    enabledBorder: _buildBorder(Colors.grey[600]!),
    errorBorder:  _buildBorder(Colors.red),
    focusedErrorBorder: _buildBorder(Colors.red),
    border: _buildBorder(Colors.yellow),
    focusedBorder: _buildBorder(Colors.blue),
    disabledBorder: _buildBorder(Colors.grey[400]!),

    suffixStyle: _builtTextStyle(Colors.black),
    counterStyle:  _builtTextStyle(Colors.grey, size: 12),
    floatingLabelStyle:  _builtTextStyle(Colors.black),
    errorStyle:  _builtTextStyle(Colors.red, size: 12),
    helperStyle: _builtTextStyle(Colors.black, size: 12),
    hintStyle:  _builtTextStyle(Colors.grey),
    labelStyle:  _builtTextStyle(Colors.black),
    prefixStyle:  _builtTextStyle(Colors.black),

  );
}



