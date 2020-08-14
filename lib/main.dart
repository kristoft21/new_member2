import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formkey = GlobalKey<FormState>();
  DateTime dateTime;

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
  }

  Dategt() async {
    DateTime newDateTime = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
        borderRadius: 16,
        theme: ThemeData.dark(),
        customWeekDays: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]);
    if (newDateTime != null) {
      setState(() => dateTime = newDateTime);
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: new Form(
        key: _formkey,
        child: new Column(
          children: <Widget>[
            new Text(
              'E-mail:',
              style: TextStyle(fontSize: 20.0),
            ),
            new TextFormField(validator: (value) {
              if (value.isEmpty) return 'Пожалуйста введите свой Email';

              String p =
                  "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
              RegExp regExp = new RegExp(p);

              if (regExp.hasMatch(value)) return null;

              return 'Это не E-mail';
            }),
            new SizedBox(height: 20.0),
            new Text(
              'пароль',
              style: TextStyle(fontSize: 20.0),
            ),
            new TextFormField(validator: (value) {
              if (value.isEmpty)
                return 'введите пароль';
              else
                return null;
            }),
            new SizedBox(
              height: 20.0,
            ),
            new Text(
              "Date Time selected",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
              ),
            ),
            Text(
              "$dateTime",
              style: const TextStyle(fontSize: 20),
            ),
            RaisedButton(
              onPressed: () {
                Dategt();
              },
              child: Text(
                'календарь',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              color: Colors.blue[900],
            ),
            new RaisedButton(
              onPressed: () {
                if (_formkey.currentState.validate())
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("форма заполнена"),
                    backgroundColor: Colors.green,
                  ));
              },
              child: Text('Создать'),
              color: Colors.blue[900],
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('ru', 'RU'), // Thai
      ],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Добавить пользователя',
            style: TextStyle(fontSize: 26.0),
          ),
          backgroundColor: Colors.black87,
        ),
        body: new MyForm(),
      ),
    ));
