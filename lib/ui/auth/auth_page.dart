import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mallet_user/scoped_models/auth.dart';

import 'package:mallet_user/models/auth.dart';
import 'package:mallet_user/models/user.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final _formData = UserData(email: '', password: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  AuthMode _authMode=AuthMode.LOGIN;


  Widget _buildSubmitButton() {
    return ScopedModelDescendant<AuthModel>(
        builder: (BuildContext context,Widget child,AuthModel model)
        {
          return RaisedButton(
              child: Text(_authMode == AuthMode.LOGIN
                  ? 'LOGIN'
                  : 'SIGNUP'),
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();
                Map<String, dynamic> successInfo;
                if(_authMode == AuthMode.LOGIN ){
                  successInfo=await model.login(_formData!.email.toString(), _formData!.password.toString());
                }
                else{
                  successInfo = await model.sigup(_formData!.email.toString(), _formData!.password.toString());
                }

                if (successInfo['success']) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('An Error Occured'),
                          content: Text(successInfo['message']),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Okay'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                }
              }
            );
        }

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }

                    },
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordController,
                    onSaved: (String? value) {
                      _formData.email = value;
                    },
                  ),
                  TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }

                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (String? value) {
                      _formData.password = value;
                    },
                  ),
                  _authMode==AuthMode.SIGNUP? TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Confirm Password'),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {
                      if (_passwordController.text != value) {
                        // return 'Passwords do not much';
                      }

                    },
                  )
                      : Container(),

                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    child: Text(
                        'Switch to ${_authMode == AuthMode.LOGIN ? 'Sign Up' : 'Login'}'),
                    onPressed: () {
                      setState(() {
                        _authMode = _authMode == AuthMode.LOGIN
                            ? AuthMode.SIGNUP
                            : AuthMode.LOGIN;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildSubmitButton()
                ],
              )
          ),
        ),
      ),
    );
  }
}
