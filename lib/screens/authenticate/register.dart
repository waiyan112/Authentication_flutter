import 'package:flutter/material.dart';
import 'package:profile/services/auth.dart';
import 'package:profile/shared/constants.dart';
import 'package:profile/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register Slurr'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) =>
                          val.length < 6 ? 'Enter an password (6+ char)' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.redAccent[100],
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            if (this.mounted) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
                          }
                        }
                      }),
                  SizedBox(height: 12.0),
                  Text(error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0)),
                ],
              ))),
    );
  }
}