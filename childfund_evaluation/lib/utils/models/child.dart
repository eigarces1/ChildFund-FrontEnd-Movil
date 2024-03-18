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
}
