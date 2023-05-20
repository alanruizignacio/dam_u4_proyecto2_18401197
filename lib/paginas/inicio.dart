import 'package:dam_u4_proyecto2_18401197/paginas/asistencia.dart';
import 'package:dam_u4_proyecto2_18401197/paginas/consultaasistenciadocente.dart';
import 'package:dam_u4_proyecto2_18401197/servicios/firebase_service.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text("Asignación", style: TextStyle(color: Colors.white,
        ),
        ),
        leading: Icon(Icons.assignment_outlined),
      ),
      body: FutureBuilder(
        future: getAsignaciones(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    trailing: Text("Materia", style: TextStyle(fontWeight: FontWeight.bold,
                    ),
                    ),
                    leading: Icon(Icons.account_box, size: 40, color: Colors.black87,
                    ),
                    title: Text(
                      snapshot.data?[index]['materia'] ?? 'No disponible', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Docente: ${snapshot.data?[index]['docente'] ?? 'No disponible'}',
                        ),
                        Text(
                          'Salon: ${snapshot.data?[index]['salon'] ?? 'No disponible'}',
                        ),
                        Text(
                          'Edificio: ${snapshot.data?[index]['edificio'] ?? 'No disponible'}',
                        ),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                '¿Qué desea hacer con la Asignación ${snapshot.data?[index]['materia']}?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Actualizar'),
                                onPressed: () async {
                                  await Navigator.pushNamed(
                                      context, "/actualizar",
                                      arguments: {
                                        "uid": snapshot.data?[index]['uid'],
                                        "salon": snapshot.data?[index]['salon'],
                                        "edificio": snapshot.data?[index]['edificio'],
                                        "horario": snapshot.data?[index]['horario'],
                                        "docente": snapshot.data?[index]['docente'],
                                        "materia": snapshot.data?[index]['materia'],
                                      });
                                  setState(() {
                                    const Center(
                                      child: Text("Cargando..."),
                                    );
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Eliminar Asignación'),
                                onPressed: () async {
                                  await borrarAsignacion(
                                      snapshot.data?[index]['uid']);
                                  setState(() {
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Asistencia"),
                                onPressed: () async{
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Asistencia(AsignacionId: snapshot.data?[index]['uid'] ?? ''),
                                    ),
                                  );
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Consultas(),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/add');
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}