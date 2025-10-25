class UserModel {

  final String ? token ;

  final String ? password ;
  final String  phoneNumber ;
   String ? name ;

  UserModel(  this.token,{required this.password, required this.phoneNumber,});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModel(

      json['token'],
      password: json['password'],
      phoneNumber: json['phone_number'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}