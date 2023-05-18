import 'package:dam_u4_proyecto2_18401197/servicios/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InsertarAsistencia extends StatefulWidget {

  final String AsignacionId;

  const InsertarAsistencia({Key? key, required this.AsignacionId}) : super(key: key);

  @override
  State<InsertarAsistencia> createState() => _InsertarAsistenciaState();
}

class _InsertarAsistenciaState extends State<InsertarAsistencia> {

  TextEditingController fechahoraController = TextEditingController(text: "");
  TextEditingController  revisorController = TextEditingController(text: "");

  DateTime selectedFecha = DateTime.now();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar asistencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: revisorController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.list),
                  labelText: 'Revisor'
              ),
            ),
            SizedBox(height: 10,),
            TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedFecha,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedFecha)
                  setState(() {
                    selectedFecha = picked;
                  });
              },
              child: Text('Seleccionar Fecha: ${DateFormat.yMd().format(selectedFecha)}'),
            ),

            ElevatedButton(onPressed: () async{
              await insertarAsistencia(widget.AsignacionId, {
                "revisor": revisorController.text,
                "fechahora": selectedFecha,
              }).then((_) {
                Navigator.pop(context);
              });
            }, child: const Text("Insertar"))
          ],
        ),
      ),
    );
  }
}

