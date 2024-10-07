import 'package:chat_app/feature/authentication/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFormFiled extends StatelessWidget {
 CustomTextFormFiled({super.key, required this.labelText, this.onChanged, required this.obscureText,  this.bottomPadding,  this.suffixIcon,this.prefixIcon});
final String labelText;
final Function(String)? onChanged;
final bool obscureText;
final double ? bottomPadding;
final Widget? suffixIcon;
Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    final cubit=BlocProvider.of<AuthCubit>(context);
    return Padding(
      padding:  EdgeInsets.only(bottom: bottomPadding ??15),
      child: TextFormField(
        validator: (value) {
         if (value == null || value.isEmpty) {
       return 'Please Enter Text';
         } else {
       return null;
         } 
        },
        obscureText:obscureText?cubit.obscureText:false,
        onChanged: onChanged,
        
        decoration: InputDecoration(
          prefixIcon:prefixIcon ,
          suffixIcon: suffixIcon,
          labelText:labelText ,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)
          )
        ),
      ),
    );
  }
}