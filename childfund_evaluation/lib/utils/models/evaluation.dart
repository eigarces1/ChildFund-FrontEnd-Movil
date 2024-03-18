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
