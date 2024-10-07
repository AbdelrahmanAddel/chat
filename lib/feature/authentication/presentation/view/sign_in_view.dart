import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'widget/sign_in_body.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 200,),
        ),
          SliverToBoxAdapter(
            child: SignInBody(),
          )
        ],
      ),
    );
  }
}