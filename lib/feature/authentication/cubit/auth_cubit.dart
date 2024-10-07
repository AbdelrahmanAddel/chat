import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/core/database/cache.dart';
import 'package:chat_app/feature/profile/data/model/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? emailAddress;
  String? password;
  String? firstName;
  String? lastName;
  String?image;

  File? imageFile;
  bool obscureText = false;
FirebaseFirestore firestore =FirebaseFirestore.instance;
FirebaseAuth fireAuth=FirebaseAuth.instance;

Future<void> createUserWithEmailAndPassword() async {
    try {
      emit(LoadingToCrateAccountStata());

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      await addUserDataToFireStore(userId: fireAuth.currentUser!.uid);
      await verfiyEmail();
      emit(CrateAccountSuccessStata());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(FailedToCeateAccountState(errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(FailedToCeateAccountState(errorMessage: 'The account already exists for that email.'));
      } else {
        emit(FailedToCeateAccountState(errorMessage: e.code));
      }
    } catch (e) {
      print('/////////////');
      print(e.toString());
      print('/////////////');

      emit(FailedToCeateAccountState(errorMessage: e.toString()));
    }
  }

  void changeObsecure() {
    obscureText = !obscureText;
    emit(ChangeObsecureIcon());
  }

  Future<void> verfiyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future<void> pickImageFromUser() async {
    ImagePicker picker = ImagePicker();
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageFile = File(image.path);
        await uploadImageToFireStore();
        emit(GetImageSuccess());
      } else {
        emit(FialedToGetImage());
      }
    } catch (e) {
      emit(FialedToGetImage());
    }
  }

  Future<void> uploadImageToFireStore() async {
    Reference reference = FirebaseStorage.instance.ref(basename(imageFile!.path));
    await reference.putFile(imageFile!);
    image= await reference.getDownloadURL();
  }

  Future<void> addUserDataToFireStore({required String userId})async{
 await Cache.setValue(key: 'userId', value: fireAuth.currentUser?.uid);
 UserProfileModel model=UserProfileModel(email: emailAddress!, firstName: firstName!, image: image, lastName: lastName!);
  await firestore.collection('users').doc(userId).set(
    model.userProfileModelToJson()
);
}


Future<void> signInWithEmailAndPassword()async{
try {
   emit(LoadingToSignInWithEmailAndPassword());
   await fireAuth.signInWithEmailAndPassword(
    email: emailAddress!,
    password: password!
  );
 emit(SignInWithEmailAndPasswordSuccess());
} 
on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
    emit(FailedToSignInWithEmailAndPassword(errorMessage: 'No user found for that email.'));
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
    emit(FailedToSignInWithEmailAndPassword(errorMessage: 'Wrong password provided for that user.'));
  }
  else{
    emit(FailedToSignInWithEmailAndPassword(errorMessage: e.code));
  }
}

}
}