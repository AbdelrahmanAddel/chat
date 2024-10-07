import 'package:shared_preferences/shared_preferences.dart';

class Cache {
static late SharedPreferences sharedPreferences ;
static cacheInt()async{
  sharedPreferences=await SharedPreferences.getInstance();
}
static  Future<bool> setValue({required String key,required dynamic value})async{
  if (value is int) {
   return await sharedPreferences.setInt(key, value);
  }
  else if(value is String){
  return await sharedPreferences.setString(key, value);
  }
  else if(value is bool){
  return await sharedPreferences.setBool(key, value);
  }
  else {
   return await sharedPreferences.setDouble(key, value);
  }

}


static dynamic getValue({required String key}){
 return sharedPreferences.get(key);

}

}