class UserProfileModel {
  String ? image;
  String email;
  String firstName;
  String lastName;
UserProfileModel
({required this.email,
required this.firstName ,
required this.image,
required this.lastName});

factory UserProfileModel.fromJson({required jsonData}){
  return UserProfileModel(
    email: jsonData['email'],
    firstName: jsonData['firstName'],
    image: jsonData['image'],
    lastName: jsonData['lastName']);
}


Map<String,dynamic>userProfileModelToJson(){
  return {
    'email':email,
    'firstName':firstName,
    'image':image,
    'lastName':lastName
  };
}
}
