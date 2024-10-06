 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?>  showToast({required String toastString ,required Color colors}){
  return Fluttertoast.showToast(
        msg:toastString ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: colors,
        textColor: Colors.white,
        fontSize: 16.0
    );
 }

