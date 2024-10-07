
import 'package:chat_app/core/widget/custom_show_toast.dart';
import 'package:chat_app/feature/authentication/cubit/auth_cubit.dart';
import 'package:chat_app/feature/authentication/presentation/view/widget/custom_matrial_buttom.dart';
import 'package:chat_app/feature/authentication/presentation/view/widget/custom_text_form_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBody extends StatelessWidget {
   SignInBody({super.key});
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit=BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInWithEmailAndPasswordSuccess) {
          FirebaseAuth.instance.currentUser!.emailVerified==false?
          showToast(toastString: 'please Verfiy email', colors: Colors.green):
          showToast(toastString: 'Sign In Success', colors: Colors.green);
          
        }
        else if(state is FailedToSignInWithEmailAndPassword){
          showToast(toastString: state.errorMessage, colors: Colors.red);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                CustomTextFormFiled(
                  prefixIcon:  Icon(Icons.email),
                labelText: 'Email Address',
                 obscureText: false,
                 onChanged: (email) {
                   cubit.emailAddress=email;
                 },
                 ),
                 CustomTextFormFiled(
                labelText: 'password ',
                prefixIcon: Icon(Icons.password),
                 obscureText: true,
                 suffixIcon:  IconButton(onPressed: (){
                  cubit.changeObsecure();
                 },icon: Icon(cubit.obscureText?Icons.visibility:Icons.visibility_off)
            ,
            
                 
                 )
                 ,
                 onChanged: (password) {
                   cubit.password=password;
                 },
                 ),
                 state is LoadingToSignInWithEmailAndPassword?
                 CupertinoActivityIndicator():
                 CustomMaterialButton(buttonText: 'Sign In',onPressed: () {
                  if (formKey.currentState!.validate()) {
                   cubit.signInWithEmailAndPassword();
                    
                  }
                 },)
              ],
            ),
          ),
        );
      },
    );
  }
}