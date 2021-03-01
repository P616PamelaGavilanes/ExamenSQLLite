import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/list_vista.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/utils/pref.dart';
import 'package:flutter_application_2/providers/person_file.dart';

import 'models/person_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<PersonProvider>(
      create: (_) => PersonProvider(),
    )
  ], child: MyApp()));
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
Person _list;
class MenuItem {
  String key;
  String title;
  IconData icon;
  MenuItem(this.key, this.title, this.icon);
}
class _MyHomePageState extends State<MyHomePage> {

final List<MenuItem> mainActions = [
  MenuItem("config", "Agregar", Icons.forum),
];

  @override
  Widget build(BuildContext context) {
      final personProvider = Provider.of<PersonProvider>(context, listen: false);
      personProvider.loadPersons();
    return Scaffold(
      
      appBar: AppBar(
          actions: [
            PopupMenuButton<MenuItem>(
              onSelected: (value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Formulario()));
              
              },
              itemBuilder: (BuildContext context) {
                return mainActions.map((MenuItem option) {
                  return PopupMenuItem<MenuItem>(
                      value: option,
                      child: Row(
                        children: [
                          Icon(option.icon,
                              color: Theme.of(context).primaryColor),
                          SizedBox(width: 14.0),
                          Text(option.title)
                        ],
                      ));
                }).toList();
              },
            ),
          ],
          title: Text("Listado de Personas ",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .apply(color: Colors.white))),
      body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.0),
          Text("Personas registradas ",
              style: Theme.of(context).textTheme.headline5),
              _listView(personProvider.persons)
        ],
      ),
    ),
      );
      
  }
    _listView(List<Person> persons) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: persons.length,
        itemBuilder: (_, index) => ListTile(
              leading: Icon(Icons.person),
              title: Text("${persons[index].apellido}"),//"${tattoo.style}"
              subtitle: Text("C.I:  "+"${persons[index].cedula} "+ " Dicapacitado:  "+"${persons[index].discapacidad}" ),
            ));
    }
}
