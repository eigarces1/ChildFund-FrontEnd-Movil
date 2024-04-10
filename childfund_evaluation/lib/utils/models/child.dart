class Child {
  int childId;
  String name;
  String lastname;
  int childNumber;
  String gender;
  String birthdate;
  String community;
  String communityType;
  String village;
  int status;
  String updatedAt;
  String createdAt;

  Child({
    required this.childId,
    required this.name,
    required this.lastname,
    required this.childNumber,
    required this.gender,
    required this.birthdate,
    required this.community,
    required this.communityType,
    required this.village,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
  });

  Child.vacio()
      : childId = 0,
        name = "",
        lastname = "",
        childNumber = 0,
        gender = '',
        birthdate = '',
        community = '',
        communityType = '',
        village = '',
        status = 0,
        updatedAt = '',
        createdAt = '';

  @override
  String toString() {
    return 'Child{childId: $childId, name: $name, lastname: $lastname, childNumber: $childNumber, gender: $gender, birthdate: $birthdate, community: $community, communityType: $communityType, village: $village, status: $status, updatedAt: $updatedAt, createdAt: $createdAt}';
  }

  Map<String, dynamic> toJson() {
    return {
      'childId': childId,
      'name': name,
      'lastname': lastname,
      'childNumber': childNumber,
      'gender': gender,
      'birthdate': birthdate,
      'community': community,
      'communityType': communityType,
      'village': village,
      'status': status,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      childId: json['childId'] as int,
      name: json['name'] as String,
      lastname: json['lastname'] as String,
      childNumber: json['childNumber'] as int,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String,
      community: json['community'] as String,
      communityType: json['communityType'] as String,
      village: json['village'] as String,
      status: json['status'] as int,
      updatedAt: json['updatedAt'] as String,
      createdAt: json['createdAt'] as String,
    );
  }
}
