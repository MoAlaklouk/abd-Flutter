class ShopLoginModel {
  bool status;
  String message;
  UserData data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  String name;
  String email;
  String phone;
  int id;
  String image;
  int points;
  int credit;
  String token;
  //named constractor

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];

    token = json['token'];
  }
}
