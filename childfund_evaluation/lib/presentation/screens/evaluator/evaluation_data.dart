import 'package:childfund_evaluation/utils/models/evaluation.dart';
import 'package:flutter/material.dart';
import 'package:childfund_evaluation/utils/api_service.dart';

class EvaluationFormScreen extends StatefulWidget {
  final int testId;

  const EvaluationFormScreen({Key? key, required this.testId})
      : super(key: key);

  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationFormScreen> {
  Evaluation evaluation = Evaluation.vacio();
  // **Estas si
  //1
  bool personaMadre = false;
  bool personaPadre = false;
  bool personaAbuelo = false;
  bool personaOtros = false;

  //2
  bool sabeLeerEscribir = false;
  bool noSabeLeerEscribir = false;

  //3
  bool educacion = false;
  bool edYears1 = false;
  bool edYears2 = false;
  bool edYears3 = false;
  bool edYears4 = false;
  bool edYears5 = false;

  //4ed
  bool estInSi = false;
  bool estInNo = false;
  bool dondeCentro = false;
  bool dondeCasa = false;
  bool chilFun = false;
  bool noGub = false;
  bool gub = false;
  bool cibv = false;
  bool cnh = false;
  bool edIn = false;
  bool ubOtros = false;

  //5
  bool siTiene = false;
  bool noTiene = false;

  //6
  bool estBueno = false;
  bool estMalo = false;
  bool estRegular = false;

  void _submit() {
    print(evaluation.toString());
  }

  /*Future<void> _submit() async {
    await ApiService.enviarEvaluacion(evaluation, widget.testId);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingrese los datos de la evaluación'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('1. Persona responsable del niño:'),
              CheckboxListTile(
                title: Text('Madre'),
                value: personaMadre,
                onChanged: (bool? newValue) {
                  setState(() {
                    personaMadre = newValue!;
                    evaluation?.personInCharge = "MADRE";
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Padre'),
                value: personaPadre,
                onChanged: (bool? newValue) {
                  setState(() {
                    personaPadre = newValue!;
                    evaluation?.personInCharge = "PADRE";
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Abuelo(s)'),
                value: personaAbuelo,
                onChanged: (bool? newValue) {
                  setState(() {
                    personaAbuelo = newValue!;
                    evaluation?.personInCharge = "ABUELO";
                  });
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: personaOtros,
                    onChanged: (bool? newValue) {
                      setState(() {
                        personaOtros = newValue!;
                        evaluation?.personInCharge = "";
                      });
                    },
                  ),
                  Text('Otros'),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Especificar',
                      ),
                      onChanged: (data) {
                        setState(() {
                          evaluation?.personInCharge = data;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('2. La persona responsable sabe leer y escribir?'),
              CheckboxListTile(
                title: Text('Sí'),
                value: sabeLeerEscribir,
                onChanged: (bool? value) {
                  setState(() {
                    sabeLeerEscribir = value!;
                    evaluation?.reading = 1;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('No'),
                value: noSabeLeerEscribir,
                onChanged: (bool? value) {
                  setState(() {
                    noSabeLeerEscribir = value!;
                    evaluation?.reading = 0;
                  });
                },
              ),
              SizedBox(height: 20),
              Text('3. Educación del cuidado:'),
              CheckboxListTile(
                title: Text('Sin educación'),
                value: educacion,
                onChanged: (bool? value) {
                  setState(() {
                    educacion = value!;
                    evaluation?.education = educacion ? 1 : 0;
                  });
                },
              ),
              if (educacion!) SizedBox(height: 5),
              Text('Años de educación:'),
              CheckboxListTile(
                title: Text('1-3'),
                value: edYears1,
                onChanged: (bool? value) {
                  setState(() {
                    edYears1 = value!;
                    evaluation?.educationYears = "1-3";
                  });
                },
              ),
              CheckboxListTile(
                title: Text('4-6'),
                value: edYears2,
                onChanged: (bool? value) {
                  setState(() {
                    edYears2 = value!;
                    evaluation?.educationYears = "4-6";
                  });
                },
              ),
              CheckboxListTile(
                title: Text('7-9'),
                value: edYears3,
                onChanged: (bool? value) {
                  setState(() {
                    edYears3 = value!;
                    evaluation?.educationYears = "7-9";
                  });
                },
              ),
              CheckboxListTile(
                title: Text('10-12'),
                value: edYears4,
                onChanged: (bool? value) {
                  setState(() {
                    edYears4 = value!;
                    evaluation?.educationYears = "10-12";
                  });
                },
              ),
              CheckboxListTile(
                title: Text('13 o más'),
                value: edYears5,
                onChanged: (bool? value) {
                  setState(() {
                    edYears5 = value!;
                    evaluation?.educationYears = "13 o màs";
                  });
                },
              ),
              SizedBox(height: 20),
              Text('4. Participa en algún programa de estimulación inicial?'),
              CheckboxListTile(
                title: Text('Sí'),
                value: estInSi,
                onChanged: (bool? value) {
                  setState(() {
                    estInSi = value!;
                    evaluation?.initialStimulation = 1;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('No'),
                value: estInNo,
                onChanged: (bool? value) {
                  setState(() {
                    estInNo = value!;
                    evaluation?.initialStimulation = 0;
                  });
                },
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('En dónde?'),
                  CheckboxListTile(
                    title: Text('En un centro'),
                    value: dondeCentro,
                    onChanged: (bool? value) {
                      setState(() {
                        dondeCentro = value!;
                        evaluation?.programPlace = "CENTRO";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('En su casa'),
                    value: dondeCasa,
                    onChanged: (bool? value) {
                      setState(() {
                        dondeCasa = value!;
                        evaluation?.programPlace = "CASA";
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Proporcionado por:'),
                  CheckboxListTile(
                    title: Text('Comunidad afiliada a ChilFund'),
                    value: chilFun,
                    onChanged: (bool? value) {
                      setState(() {
                        chilFun = value!;
                        evaluation?.childfundPartner = "ABCD";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Organización no gubernamental'),
                    value: noGub,
                    onChanged: (bool? value) {
                      setState(() {
                        noGub = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Especificar',
                    ),
                    onChanged: (data) {
                      setState(() {
                        evaluation?.nongovernmental = noGub ? data : "";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Organismo gubernamental'),
                    value: gub,
                    onChanged: (bool? value) {
                      setState(() {
                        gub = value!;
                      });
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        title: Text('CIBV'),
                        value: cibv,
                        onChanged: (bool? value) {
                          setState(() {
                            cibv = value!;
                            evaluation?.CIBV = cibv ? 1 : 0;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('CNH'),
                        value: cnh,
                        onChanged: (bool? value) {
                          setState(() {
                            cnh = value!;
                            evaluation?.CNH = cnh ? 1 : 0;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Educación inicial'),
                        value: edIn,
                        onChanged: (bool? value) {
                          setState(() {
                            edIn = value!;
                            evaluation?.initialEducation = edIn ? 1 : 0;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Ingresar',
                        ),
                        onChanged: (data) {
                          setState(() {
                            evaluation?.governmental = data;
                          });
                        },
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    title: Text('Otros'),
                    value: ubOtros,
                    onChanged: (bool? value) {
                      ubOtros = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Especificar',
                    ),
                    onChanged: (data) {
                      setState(() {
                        evaluation?.otherSponsor = ubOtros ? data : "NO";
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('5. El niño/a presenta algún tipo de discapacidad?'),
              CheckboxListTile(
                title: Text('Sí'),
                value: siTiene,
                onChanged: (bool? value) {
                  setState(() {
                    siTiene = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('No'),
                value: noTiene,
                onChanged: (bool? value) {
                  setState(() {
                    noTiene = value!;
                  });
                },
              ),
              if (siTiene)
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enumere o describa',
                  ),
                  onChanged: (data) {
                    setState(() {
                      evaluation?.disability = siTiene ? data : "NO";
                    });
                  },
                ),
              SizedBox(height: 20),
              Text('6. Estado de salud del niño/a en las últimas semanas:'),
              CheckboxListTile(
                title: Text('Bueno'),
                value: estBueno,
                onChanged: (bool? value) {
                  setState(() {
                    estBueno = value!;
                    evaluation?.healthCondition = "BUENA";
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Malo'),
                value: estMalo,
                onChanged: (bool? value) {
                  setState(() {
                    estMalo = value!;
                    evaluation?.healthCondition = "MALO";
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Regular'),
                value: estRegular,
                onChanged: (bool? value) {
                  setState(() {
                    estRegular = value!;
                    evaluation?.healthCondition = "REGULAR";
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Describa',
                ),
                onChanged: (data) {
                  setState(() {
                    evaluation?.healthConditionDescription = data;
                  });
                },
              ),
              SizedBox(height: 20),
              Text('7. Registro de crecimiento:'),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: 'Estatura',
                ),
                onChanged: (data) {
                  double doubleValue = double.tryParse(data) ?? 0.0;
                  setState(() {
                    evaluation?.height = doubleValue;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: 'Peso',
                ),
                onChanged: (data) {
                  double doubleValue = double.tryParse(data) ?? 0.0;
                  setState(() {
                    evaluation?.weight = doubleValue;
                  });
                },
              ),
              SizedBox(height: 20),
              Text('8. Observaciones:'),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Ingrese sus observaciones aquí...',
                ),
                onChanged: (data) {
                  setState(() {
                    evaluation?.observations = data;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
