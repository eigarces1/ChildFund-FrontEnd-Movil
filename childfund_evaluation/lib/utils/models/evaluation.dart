class Evaluation {
  String personInCharge;
  int reading;
  int education;
  String educationYears;
  int initialStimulation;
  String programPlace;
  bool childfundPartner;
  String nongovernmental;
  String governmental;
  int CIBV;
  int CNH;
  int initialEducation;
  String otherSponsor;
  String disability;
  String healthCondition;
  String healthConditionDescription;
  double height;
  double weight;
  String observations;

  Evaluation({
    required this.personInCharge,
    required this.reading,
    required this.education,
    required this.educationYears,
    required this.initialStimulation,
    required this.programPlace,
    required this.childfundPartner,
    required this.nongovernmental,
    required this.governmental,
    required this.CIBV,
    required this.CNH,
    required this.initialEducation,
    required this.otherSponsor,
    required this.disability,
    required this.healthCondition,
    required this.healthConditionDescription,
    required this.height,
    required this.weight,
    required this.observations,
  });

  Evaluation.vacio()
      : personInCharge = "",
        reading = 0,
        education = 0,
        educationYears = "",
        initialStimulation = 0,
        programPlace = "",
        childfundPartner = false,
        nongovernmental = "",
        governmental = "",
        CIBV = 0,
        CNH = 0,
        initialEducation = 0,
        otherSponsor = "",
        disability = '',
        healthCondition = "",
        healthConditionDescription = "",
        height = 0.0,
        weight = 0,
        observations = "";

  // Método para convertir una instancia de Evaluation a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'personInCharge': personInCharge,
      'reading': reading,
      'education': education,
      'educationYears': educationYears,
      'initialStimulation': initialStimulation,
      'programPlace': programPlace,
      'childfundPartner': childfundPartner,
      'nongovernmental': nongovernmental,
      'governmental': governmental,
      'CIBV': CIBV,
      'CNH': CNH,
      'initialEducation': initialEducation,
      'otherSponsor': otherSponsor,
      'disability': disability,
      'healthCondition': healthCondition,
      'healthConditionDescription': healthConditionDescription,
      'height': height,
      'weight': weight,
      'observations': observations,
    };
  }

  // Constructor para crear una instancia de Evaluation a partir de un mapa JSON
  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      personInCharge: json['personInCharge'] ?? '',
      reading: json['reading'] ?? 0,
      education: json['education'] ?? 0,
      educationYears: json['educationYears'] ?? '',
      initialStimulation: json['initialStimulation'] ?? 0,
      programPlace: json['programPlace'] ?? '',
      childfundPartner: json['childfundPartner'] ?? false,
      nongovernmental: json['nongovernmental'] ?? '',
      governmental: json['governmental'] ?? '',
      CIBV: json['CIBV'] ?? 0,
      CNH: json['CNH'] ?? 0,
      initialEducation: json['initialEducation'] ?? 0,
      otherSponsor: json['otherSponsor'] ?? '',
      disability: json['disability'] ?? '',
      healthCondition: json['healthCondition'] ?? '',
      healthConditionDescription: json['healthConditionDescription'] ?? '',
      height: json['height'] != null ? json['height'].toDouble() : 0.0,
      weight: json['weight'] != null ? json['weight'].toDouble() : 0.0,
      observations: json['observations'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Evaluation{'
        'personInCharge: $personInCharge, '
        'reading: $reading, '
        'education: $education, '
        'educationYears: $educationYears, '
        'initialStimulation: $initialStimulation, '
        'programPlace: $programPlace, '
        'childfundPartner: $childfundPartner, '
        'nongovernmental: $nongovernmental, '
        'governmental: $governmental, '
        'CIBV: $CIBV, '
        'CNH: $CNH, '
        'initialEducation: $initialEducation, '
        'otherSponsor: $otherSponsor, '
        'disability: $disability, '
        'healthCondition: $healthCondition, '
        'healthConditionDescription: $healthConditionDescription, '
        'height: $height, '
        'weight: $weight, '
        'observations: $observations'
        '}';
  }
}
