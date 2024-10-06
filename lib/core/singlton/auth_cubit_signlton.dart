import 'package:chat_app/feature/authentication/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthCubit>(AuthCubit());


}