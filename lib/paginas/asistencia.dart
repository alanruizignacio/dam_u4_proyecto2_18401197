import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2_18401197/insertar_asistencia.dart';

import 'package:dam_u4_proyecto2_18401197/servicios/firebase_service.dart';
import 'package:flutter/material.dart';


class Asistencia extends StatefulWidget {

  final String AsignacionId;

  const Asistencia({Key? key, required this.AsignacionId}) : super(key: key);

  @override
  State<Asistencia> createState() => _AsistenciaState();
}

class _AsistenciaState extends State<Asistencia> {

  bool _filterApplied = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistencias"),
      ),
      body: FutureBuilder<List>(
        future: getAsistencias(widget.AsignacionId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final asistenciaData = snapshot.data?[index];
                return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                trailing: Text("Revisor", style: TextStyle(fontWeight: FontWeight.bold,),
                ),
                leading: Icon(Icons.account_box, size: 40, color: Colors.black87,),
                title: Text(
                snapshot.data?[index]['revisor'] ?? 'No disponible', style: TextStyle(
                fontWeight: FontWeight.bold,),
                ),
                subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text((asistenciaData?['fechahora'] as Timestamp)?.toDate().toString() ?? 'No disponible',),
                ],
                ),
                ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error al cargar las asistencias"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsertarAsistencia(AsignacionId: widget.AsignacionId),
            ),
          );
          setState(() {});
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}