class Children {
  final String name;
  final String lastName;
  final int childNumber;
  final String gender;
  final String birthdate;
  final String community;
  final String communityType;
  final String village;
  final String updatedAt;
  final String createdAt;

  Children({
    required this.name,
    required this.lastName,
    required this.childNumber,
    required this.gender,
    required this.birthdate,
    required this.community,
    required this.communityType,
    required this.village,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
      name: json['name'],
      lastName: json['lastname'],
      childNumber: json['child_number'],
      gender: json['gender'],
      birthdate: json['birthdate'],
      community: json['community'],
      communityType: json['community_type'],
      village: json['village'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }

  @override
  String toString() {
    return 'Children{ name: $name, lastName: $lastName, childNumber: $childNumber, gender: $gender, birthdate: $birthdate, community: $community, communityType: $communityType, village: $village,  updatedAt: $updatedAt, createdAt: $createdAt}';
  }
}
