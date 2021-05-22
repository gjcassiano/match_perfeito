
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_perfeito/login/login.controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Configuration extends StatefulWidget {
    @override
    ConfigurationPage createState() => ConfigurationPage();
}

class ConfigurationPage extends State<Configuration>  {
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    //Position userLocation;
    
    late String _name;
    late int _age;
    late String _findPreference;
    
    _updateLocation() async {
        
        //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
            // print(position);
        });
    }
    
    @override
    void initState() {
        super.initState();
        _read();
    }
    
    _read() async {
        final sharedPreferences = await SharedPreferences.getInstance();
        
        setState(() {
            _name = sharedPreferences.getString('_name') ?? '';
            _findPreference = sharedPreferences.getString('_findPreference') ?? 'Qualquer';
            _age = sharedPreferences.getInt('_age') ?? 0;
            print('Loaded configuration!');
        });
    }
    
    _save() async {
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('_name', _name);
        sharedPreferences.setString('_findPreference', _findPreference);
        sharedPreferences.setInt('_age', _age);
    }
    
    _submit() {
        setState(() {
            if (_formKey.currentState!.validate()) {
                // No any error in validation
                _formKey.currentState!.save();
                _save();
            }
        });
    }
    
    final LoginController _loginController = new LoginController();
    
    _logout() {
        _loginController.logout();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    
    String? numberValidator(String value) {
        // ignore: unnecessary_null_comparison
        if (value == null) {
            return null;
        }
        final n = num.tryParse(value);
        if (n == null || n as int < 18) {
            return 'Você tem que ser maior de idade';
        }
        return null;
    }
    
    @override
    Widget build(BuildContext context) {
        return Container(
            child: new Form(
                key: _formKey,
                child: new ListView(children: <Widget>[
                    SizedBox(
                        child: new PageView(
                            children: <Widget>[
                                Container(
                                    child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/loading.gif',
                                        image: 'https://images.unsplash.com/photo-1496302662116-35cc4f36df92?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                                    ),
                                    color: Colors.blue,
                                ),
                                Container(
                                    color: Colors.redAccent,
                                )
                            ],
                        ),
                        height: 250,
                    ),
                    new Container(
                        padding: EdgeInsets.all(20),
                        child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                                TextFormField(
                                    controller: TextEditingController(text: _name),
                                    onSaved: (name) {
                                        setState(() => _name = name!);
                                    },
                                    style: TextStyle(),
                                    keyboardType: TextInputType
                                        .text, // Use email input type for emails.
                                    decoration: new InputDecoration(
                                        alignLabelWithHint: true,
                                        labelText: 'Seu apelido')),
                                TextFormField(
                                    controller: TextEditingController(text: _age.toString()),
                                    // onSaved: (String age) {
                                    //     setState(()=> _age = int.tryParse(age)!);
                                    // },
                                    style: TextStyle(),
                                    // validator: numberValidator,
                                    keyboardType: TextInputType
                                        .number, // Use email input type for em
                                    inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter.digitsOnly
                                    ], // ails.
                                    decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        labelText: 'Sua idade')),
                                new Container(
                                    padding: const EdgeInsets.fromLTRB(0,20,0,0),
                                    child: new Text(
                                        'Você procura por',
                                    )),
                                
                                new Container(
                                    padding: EdgeInsets.all(0),
                                    child: new DropdownButton<String>(
                                        value: _findPreference,
                                        isExpanded: true,
                                        elevation: 16,
                                        // onChanged: (String preference) {
                                        //     setState(()=>{_findPreference = preference});
                                        // },
                                        items: <String>['Qualquer', 'Homens', 'Mulheres']
                                            .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                            );
                                        })
                                            .toList(),
                                    )),
                                new Container(
                                    child: SizedBox(
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RaisedButton(
                                                child: Text("Atualizar minha localização"),
                                                onPressed: _updateLocation
                                            ),
                                        ),
                                    ),
                                ),
                                new Container(
                                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                                    child: new Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                            Divider(),
                                            SizedBox(
                                                width: double.infinity,
                                                child: FlatButton(
                                                    child: Text("Salvar"),
                                                    onPressed: () {
                                                        _submit();
                                                    }),
                                            ),
                                            SizedBox(
                                                width: double.infinity,
                                                child: FlatButton(
                                                    child: Text("Sair"),
                                                    onPressed: () {
                                                        _logout();
                                                    }),
                                            )
                                        ],
                                    ))
                            ],
                        )),
                ])));
    }
}
