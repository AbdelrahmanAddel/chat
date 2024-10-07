import 'package:chat_app/feature/authentication/cubit/auth_cubit.dart';
import 'package:chat_app/feature/authentication/presentation/view/widget/sign_up_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/image_section.dart';


class SignUp extends StatelessWidget {
  SignUp({super.key});


  @override
  Widget build(BuildContext context) {
final cubit=BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:12.0),
        child: CustomScrollView(
          slivers: [
          const  SliverToBoxAdapter(
              child: SizedBox(height: 130,),
            ),
            const SliverToBoxAdapter(
              child: ImageSection(),
            ),
           const SliverToBoxAdapter(
              child: SizedBox(height: 40,),
            ),
            SliverToBoxAdapter(
              child: SignUpBody(),
            )
          ],
        ),
      )
    );
  }
}

