import 'package:chat_app/core/widget/custom_show_toast.dart';
import 'package:chat_app/feature/authentication/presentation/view/sign_in_view.dart';
import 'package:chat_app/feature/authentication/presentation/view/widget/custom_matrial_buttom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/auth_cubit.dart';
import 'custom_text_form_filed.dart';

class SignUpBody extends StatelessWidget {
  SignUpBody({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CrateAccountSuccessStata) {
          showToast(
            toastString: 'Success, Please Check Mail To Verify',
            colors: Colors.green,
          );
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>SignIn()));
        } else if (state is FailedToCeateAccountState) {
          showToast(
            toastString: state.errorMessage,
            colors: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             //!First Name
              CustomTextFormFiled(
                labelText: 'First Name',
                obscureText: false,
                onChanged: (firstName) {
                  cubit.firstName = firstName;
                },
              ),
             //!Last Name
             CustomTextFormFiled(
                labelText: 'Last Name',
                obscureText: false,
                onChanged: (lastName) {
                  cubit.lastName = lastName;
                },
              ),
             //!Email
              CustomTextFormFiled(
                labelText: 'Email',
                obscureText: false,
                onChanged: (email) {
                  cubit.emailAddress = email;
                },
              ),
             //!Password       
              CustomTextFormFiled(
                suffixIcon: MaterialButton(
                  onPressed: () {
                    cubit.changeObsecure();
                  },
                  child: Icon(
                    cubit.obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                labelText: 'Password',
                obscureText: cubit.obscureText,
                onChanged: (password) {
                  cubit.password = password;
                },
              ),
              state is LoadingToCrateAccountStata
                  ? const CupertinoActivityIndicator()
                  : CustomMaterialButton(
                      buttonText: 'Sign Up',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.createUserWithEmailAndPassword();
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
