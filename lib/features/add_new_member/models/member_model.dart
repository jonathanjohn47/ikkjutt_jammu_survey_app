class MemberModel {
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  String? designation;
  String? profilePicture;

  MemberModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    this.designation,
    this.profilePicture,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      designation: json['designation'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'address': address,
      'designation': designation,
      'profile_picture': profilePicture,
    };
  }
}
