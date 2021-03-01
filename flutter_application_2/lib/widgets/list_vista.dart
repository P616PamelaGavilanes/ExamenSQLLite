import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/person_model.dart';
import 'package:flutter_application_2/providers/person_file.dart';
import 'package:provider/provider.dart';

class Formulario extends StatefulWidget {
  Formulario({Key key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final formKey = GlobalKey<FormState>();
    Person _person = new Person();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: CustomScrollView(
                slivers: [
                  
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.0),
                        child: Divider(
                            height: 4.0,
                            color: Theme.of(context).primaryColor)),
                    SizedBox(height: 20.0),
                    Center(
                        child: Text("Registro de personas ",
                            style: Theme.of(context).textTheme.headline5)),
                    Container(
                        margin: EdgeInsets.all(14.0),
                        child: Form(
                            key: formKey,
                            child: Column(children: [
                              _gnombre(),
                              _gpellido(),
                              _gcedula(),
                              _gnacimiento(),
                              _gdiscapacidad(),
                              _getSubmitButton()
                            ]))),
                  ]))
                ],
              ),
            );
  }
    Widget _gnombre() {
    return TextFormField(
    initialValue: _person.nombre,
    textCapitalization: TextCapitalization.words,
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      filled: true,
      icon: Icon(Icons.crop_rounded),
      hintText: ' ',
      labelText: 'Nombre',
    ),
      maxLength: 10,
    onSaved: (value) {
      _person.nombre = value;
        },
         validator: (value) {
        if (value.length < 5) {
        return "Debe ingresar un mensaje con al menos 20 caracteres";
        } else {
        return null; //Validación se cumple al retorna null
        }
      }
  );
  }
  Widget _gpellido() {
  return  TextFormField(
    initialValue: _person.apellido,
    textCapitalization: TextCapitalization.words,
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      filled: true,
      icon: Icon(Icons.crop_rounded),
      hintText: 'Apellido',
      labelText: 'apellido',
    ),
      maxLength: 10,
    onSaved: (value) {
      _person.apellido = value;
        },
         validator: (value) {
        if (value.length < 5) {
        return "Debe ingresar un mensaje con al menos 20 caracteres";
        } else {
        return null; //Validación se cumple al retorna null
        }
      }
  );
  }
    Widget _gcedula() {
  return  TextFormField(
    initialValue: _person.cedula,
    textCapitalization: TextCapitalization.words,
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      filled: true,
      icon: Icon(Icons.crop_rounded),
      hintText: 'Cedula',
      labelText: 'cedula',
    ),
      maxLength: 10,
    onSaved: (value) {
      _person.cedula = value;
        },
       validator: (value) {
        if (value.length < 3) {
        return "Debe ingresar un mensaje con al menos 20 caracteres";
        } else {
        return null; //Validación se cumple al retorna null
        }
      }
  );
  }
    Widget _gnacimiento() {
  return  TextFormField(
    initialValue: _person.nacimiento,
    textCapitalization: TextCapitalization.words,
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      filled: true,
      icon: Icon(Icons.crop_rounded),
      hintText: '5x5 cm ',
      labelText: 'nacimiento',
    ),
      maxLength: 10,
    onSaved: (value) {
      _person.nacimiento= value;
        },
       validator: (value) {
        if (value.length < 9) {
        return "Debe ingresar un mensaje con al menos 10 caracteres";
        } else {
        return null; //Validación se cumple al retorna null
        }
      }
  );
  }
    Widget _gdiscapacidad() {
  return  TextFormField(
    initialValue: _person.discapacidad,
    textCapitalization: TextCapitalization.words,
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      filled: true,
      icon: Icon(Icons.crop_rounded),
      hintText: 'SI/NO',
      labelText: 'tiene discapacidad ?',
    ),
      maxLength: 2,
    onSaved: (value) {
      _person.discapacidad= value;
        },
       validator: (value) {
        if (value.length < 2) {
        return "Debe ingresar un mensaje con al menos 5 caracteres";
        } else {
        return null; //Validación se cumple al retorna null
        }
      }
  );
  }

  Widget _getSubmitButton() {
    return Container(
        color: Theme.of(context).buttonColor,
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  if (!formKey.currentState.validate()) return;
                  formKey.currentState.save();
                  final personProvider =
                     Provider.of<PersonProvider>(context, listen: false);
                     _person = await personProvider.addPerson(
                      _person.nombre,_person.cedula,_person.apellido,_person.discapacidad,_person.nacimiento);
                      print(_person.nombre);
                      print(_person.cedula);
                      print(_person.apellido);
                      print(_person.discapacidad);
                      print(_person.nacimiento);
                      //Navigator.pop(context);
                })
          ],
        ));
  }
}