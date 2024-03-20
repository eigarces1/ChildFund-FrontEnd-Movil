class AgeController {
  AgeController();

  List<int> calculate(String date) {
    DateTime fecha =
        DateTime.parse(date); //Se convierte la fecha de String a DateTime
    DateTime currentDate = DateTime.now(); //Fecha Actual
    List<int> data = [];

    int years = currentDate.year - fecha.year;
    int months = currentDate.month - fecha.month;
    int days = currentDate.day - fecha.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += 12;
    }

    if (days < 0) {
      DateTime previousMonth = DateTime(currentDate.year, currentDate.month, 0);
      days += previousMonth.day;
      months--;

      if (months < 0) {
        years--;
        months += 12;
      }
    }

    int differenceInDays = years * 360 + months * 30 + days;
    int differenceInMonths = differenceInDays ~/ 30;
    int remainingDays = differenceInDays % 30;

    if (remainingDays > 0) {
      differenceInMonths++;
    }
    int level = calculateLevel(differenceInMonths.toDouble());
    data.add(differenceInMonths);
    data.add(level);
    return data;
  }

  int calculateLevel(double ageInMonths) {
    // Perform calculations to determine the level based on the child's age
    if (ageInMonths >= 60.1) {
      return 11;
    } else if (ageInMonths >= 48.1) {
      return 10;
    } else if (ageInMonths >= 36.1) {
      return 9;
    } else if (ageInMonths >= 24.1) {
      return 8;
    } else if (ageInMonths >= 20.1) {
      return 7;
    } else if (ageInMonths >= 16.1) {
      return 6;
    } else if (ageInMonths >= 12.1) {
      return 5;
    } else if (ageInMonths >= 9.1) {
      return 4;
    } else if (ageInMonths >= 6.1) {
      return 3;
    } else if (ageInMonths >= 3.1) {
      return 2;
    } else {
      return 1;
    }
  }
}
