import 'package:dam_u4_proyecto2_18401197/servicios/firebase_service.dart';
import 'package:flutter/material.dart';

class Actualizar extends StatefulWidget {
  const Actualizar({Key? key}) : super(key: key);

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {

  TextEditingController salonController = TextEditingController(text: "");
  TextEditingController edificioController = TextEditingController(text: "");
  TextEditingController horarioController = TextEditingController(text: "");
  TextEditingController docenteController = TextEditingController(text: "");
  TextEditingController materiaController = TextEditingController(text: "");


  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    if(arguments.isNotEmpty) {
      salonController.text = arguments["salon"] ?? '';
      edificioController.text = arguments["edificio"].toString() ?? '';
      horarioController.text = arguments["horario"] ?? '';
      docenteController.text = arguments["docente"] ?? '';
      materiaController.text = arguments["materia"].toString() ?? '';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Asignación"),
        leading: Icon(Icons.update),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: salonController,
              decoration: InputDecoration(
                labelText: 'Salon',
                prefixIcon: Icon(Icons.class_),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: edificioController,
              decoration: InputDecoration(
                labelText: 'Edificio',
                prefixIcon: Icon(Icons.school),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: horarioController,
              decoration: InputDecoration(
                labelText: 'Nuevo horario',
                prefixIcon: Icon(Icons.schedule),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: docenteController,
              decoration: InputDecoration(
                labelText: 'Nuevo docente',
                prefixIcon: Icon(Icons.account_box),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: materiaController,
              decoration: InputDecoration(
                labelText: 'Nueva materia',
                prefixIcon: Icon(Icons.laptop),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await actualizarAsignacion(
                  arguments['uid'],
                  salonController.text,
                  edificioController.text,
                  horarioController.text,
                  docenteController.text,
                  materiaController.text,
                ).then((_) {
                  Navigator.pop(context);
                });
              },
              child: Text("ACTUALIZAR"),
            ),
          ],
        ),
      ),
    );
  }
}