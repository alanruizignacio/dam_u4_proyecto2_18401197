import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getAsignaciones() async{
  List asignacion = [];
  QuerySnapshot queryAsignacion = await db.collection('asignacion').get();
  for(var doc in queryAsignacion.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asigna = {
      "uid":doc.id,
      "salon":data['salon'],
      "edificio":data['edificio'],
      "horario":data['horario'],
      "docente":data['docente'],
      "materia":data['materia'],
    };
    asignacion.add(asigna);
  }
  await Future.delayed(const Duration(seconds: 1));
  return asignacion;
}

Future<void> insertarAsignacion(String salon, edificio, horario, docente, materia) async{
  await db.collection("asignacion").add({
    "salon":salon,
    "edificio":edificio,
    "horario":horario,
    "docente":docente,
    "materia":materia,
  });
}

Future<void> actualizarAsignacion(String uid, newsalon, newedificio,
    newhorario, newdocente, newmateria) async{
  await db.collection("asignacion").doc(uid).set({
    "salon":newsalon,
    "edificio":newedificio,
    "horario":newhorario,
    "docente":newdocente,
    "materia":newmateria,
  });
}

Future<void> borrarAsignacion(String uid) async{
  await db.collection('asignacion').doc(uid).delete();
}

Future<List<Map<String, dynamic>>> getAsistencias(String asignacionId) async {
  List<Map<String, dynamic>> asistencia = [];
  QuerySnapshot queryAsistencia = await FirebaseFirestore.instance.collection('asignacion').doc(asignacionId).collection('asistencia').get();
  for (var doc in queryAsistencia.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asistenciaDoc = {
      "fechahora": data['fechahora'],
      "revisor": data['revisor'],
      "uid": doc.id,
    };
    asistencia.add(asistenciaDoc);
  }
  await Future.delayed(const Duration(seconds: 1));
  return asistencia;
}

Future<void> insertarAsistencia(String asignacionId, Map<String, dynamic> asistenciaData) async{
  await db.collection('asignacion').doc(asignacionId).collection('asistencia').add(asistenciaData);
}


