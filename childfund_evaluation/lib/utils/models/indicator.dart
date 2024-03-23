class Indicator {
  final String indicator;
  final String materials;
  final String instructions;
  final String response;
  final String position;
  final String image;
  bool? accomplished; // New property to track if the step is accomplished

  Indicator({
    required this.indicator,
    required this.materials,
    required this.position,
    required this.image,
    required this.instructions,
    required this.response,
    this.accomplished, // Default value is false
  });

  @override
  String toString() {
    return 'Indicador {'
        ' indicator: $indicator,'
        ' materials: $materials,'
        ' instructions: $instructions,'
        ' response: $response,'
        ' position: $position,'
        ' image: $image,'
        ' accomplished: $accomplished'
        '}';
  }

  Map<String, dynamic> toJson() {
    return {
      ' indicator': indicator,
      ' materials': materials,
      ' instructions': instructions,
      ' response': response,
      ' position': position,
      ' image': image,
      ' accomplished': accomplished
    };
  }
}
