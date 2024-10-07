import 'package:chat_app/feature/profile/cubit/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/user_account_drawer_header.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          key: scaffoldKey,
          drawer: Drawer(
            child: cubit.userProfileData.isEmpty
                ? const CupertinoActivityIndicator()
                : Column(
                    children: [
                      userAccountDrawerHeader(
                        accountName: cubit.userProfileData[0].firstName,
                        accountEmail: cubit.userProfileData[0].email,
                        networkImage: cubit.userProfileData[0].image!,
                      ),
                    ],
                  ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cubit.userProfileData.isEmpty
                  ? const CupertinoActivityIndicator()
                  : Text(cubit.userProfileData[0].firstName),
            ],
          ),
        );
      },
    );
  }
}
