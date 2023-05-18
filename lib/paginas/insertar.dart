import 'package:dam_u4_proyecto2_18401197/servicios/firebase_service.dart';
import 'package:flutter/material.dart';

class Insertar extends StatefulWidget {
  const Insertar({Key? key}) : super(key: key);

  @override
  State<Insertar> createState() => _InsertarState();
}

class _InsertarState extends State<Insertar> {

  TextEditingController salonController = TextEditingController(text: "");
  TextEditingController edificioController = TextEditingController(text: "");
  TextEditingController horarioController = TextEditingController(text: "");
  TextEditingController docenteController = TextEditingController(text: "");
  TextEditingController materiaController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insertar una Asignación"),
        leading: Icon(Icons.assignment_outlined),
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
                labelText: 'Horario',
                prefixIcon: Icon(Icons.schedule),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: docenteController,
              decoration: InputDecoration(
                labelText: 'Nombre del docente',
                prefixIcon: Icon(Icons.account_box),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: materiaController,
              decoration: InputDecoration(
                labelText: 'Materia',
                prefixIcon: Icon(Icons.laptop),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await insertarAsignacion(
                  salonController.text,
                  edificioController.text,
                  horarioController.text,
                  docenteController.text,
                  materiaController.text,
                ).then((_) {
                  Navigator.pop(context);
                });
              },
              child: Text("Insertar"),
            ),
          ],
        ),
      ),
    );
  }
}