import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? emailAddress;
  String? password;
  File? imageFile;
  bool obscureText = false;

  Future<void> createUserWithEmailAndPassword() async {
    try {
      emit(LoadingToCrateAccountStata());

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );

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
  }
}
