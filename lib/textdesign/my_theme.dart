import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style:
      ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
            )
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue ),
        fixedSize: MaterialStateProperty.all<Size>(
            Size(350,60)
        ),
      )
  ),
  inputDecorationTheme: InputDecorationTheme(
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

  ),
);
ButtonStyle _builtButtonStyle(Color color,{double size = 16}){
  return ButtonStyle(
    backgroundColor:MaterialStateProperty.all(color),
  );
}
ButtonThemeData button_theme() => ButtonThemeData(
  padding: EdgeInsets.all(20),
  shape: _buildBorder(Colors.blue),
  buttonColor: Colors.red,
);



