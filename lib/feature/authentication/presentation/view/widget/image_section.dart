import 'package:chat_app/core/widget/custom_show_toast.dart';
import 'package:chat_app/feature/authentication/cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is GetImageSuccess) {
          showToast(toastString: 'Upload Image Success', colors: Colors.green);
        } else if (state is FialedToGetImage) {
          showToast(toastString: 'Failed To Upload Image, Please Try Again', colors: Colors.red);
        }
      },
      builder: (context, state) {
        return state is LoadingToUploadImage
            ? const Center(child: CupertinoActivityIndicator())
            : Column(
                children: [
                  cubit.imageFile != null
                      ? GestureDetector(
                          onTap: () {
                            cubit.pickImageFromUser();
                          },
                          child: CircleAvatar(
                            backgroundImage: FileImage(cubit.imageFile!),
                            radius: 45,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            cubit.pickImageFromUser();
                          },
                          child:const CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey,
                            child:  Text(
                              'Upload Image',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ],
              );
      },
    );
  }
}
