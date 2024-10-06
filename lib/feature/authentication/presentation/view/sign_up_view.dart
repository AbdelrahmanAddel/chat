import 'package:chat_app/feature/authentication/presentation/view/widget/sign_up_body.dart';
import 'package:flutter/material.dart';

import 'widget/image_section.dart';


class SignUpView extends StatelessWidget {
  SignUpView({super.key});


  @override
  Widget build(BuildContext context) {

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
            SliverToBoxAdapter(
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

