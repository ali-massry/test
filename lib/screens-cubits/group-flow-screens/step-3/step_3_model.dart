class RepresentativeModel {
  int? civilityId;
  int? titleId;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? address;

  RepresentativeModel({
    this.civilityId,
    this.titleId,
    this.firstname,
    this.lastname,
    this.phone,
    this.email,
    this.address,
  });

  factory RepresentativeModel.fromJson(Map<String, dynamic> json) {
    return RepresentativeModel(
      civilityId: json['civilityid'],
      titleId: json['titleid'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'civilityid': civilityId,
      'titleid': titleId,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}
