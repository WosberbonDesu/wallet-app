class UserModel{
  String userName;
  String phoneNum;
  String userEmail;
  UserModel({
    required this.userName,
    required this.phoneNum,
    required this.userEmail,
});
  Map<String, dynamic> toJson() => {
    'userName': userName,
    'userEmail': userEmail,
    'phoneNum': phoneNum
  };
  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      userName: json["userName"],
      phoneNum: json["phoneNum"],
      userEmail: json["userEmail"]);
}