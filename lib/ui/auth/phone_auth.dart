// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mallet_user/ui/auth/code_sent_form.dart';
import 'package:mallet_user/scoped_models/main.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:mallet_user/scoped_models/auth.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  String? phoneNo;
  String? smsCode;
  String? verId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  var isPressed = false;
  Future<void> verifyPhone() async {
    setState(() {
      isPressed = true;
    });

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verId = verId;
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent smsCodesent = (String verId, [int? forceCodeReSend]) {
      this.verId = verId;
//      smsDialog(context).then((value) {
//        print('SignIN');
//      });
      setState(() {
        isPressed = true;
      });
      Navigator.of(context).push(_createRoute(this.verId, this.smsCode));
    };
    final PhoneVerificationCompleted verifySuccess = (PhoneAuthCredential user) {
      setState(() {
        isPressed = false;
      });
    };
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException error) {
      print('${error.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo.toString(),
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodesent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifySuccess,
        verificationFailed: verifyFailed);
  }

  Future smsDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter Code'),
            content: Container(
              height: 120.0,
              child: Form(
                key: _formKey1,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Phone Number is required and should be 6 characters long';
                        }
                      },
                      onSaved: (val) {
                        this.smsCode = val;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text('We will send you a one time SMS message'),
                    ScopedModelDescendant<MainModel>(builder:
                        (BuildContext context, Widget child, MainModel model) {
                      return FlatButton(
                        child: const Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          if (!_formKey1.currentState!.validate()) {
                            return;
                          }
                          _formKey1.currentState!.save();
                          // Map<String, dynamic> successInfo =  await model.signInWithPhone(this.verId, this.smsCode);
                          // print(successInfo);
                          // if(successInfo['success']){
                          //   Navigator.of(context).pop();
                          //   Navigator.of(context).pushReplacementNamed('/home');
                          // }
                          // else{
                          //
                          // }
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mall Auth'),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: 'Enter Phone Number',
                    icon: Icon(Icons.phone_iphone),
                    prefixText: "+251"),
                validator: (String? value) {
                  if (value!.length < 9) {
                    return 'Phone Number should be 13 characters long';
                  } else if (value!.isEmpty) {
                    return 'Phone Number is required';
                  } else if (value.length > 9) {
                    return 'Phone Number should be 13 characters long';
                  }
                },
                onSaved: (val) {
                  this.phoneNo = "+251" + val.toString();
                  print(
                      " this.phoneNo this.phoneNo this.phoneNo this.phoneNo ${this.phoneNo}");
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Center(child: Text('We will send you a One time SMS message')),
              RaisedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  setState(() {
                    isPressed = true;
                  });
                  verifyPhone();
                },
                child: const Icon(Icons.arrow_forward_ios),
                textColor: Colors.white,
                elevation: 7.0,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10.0,
              ),
              isPressed == true
                  ? const Center(
                      child: const CircularProgressIndicator(),
                    )
                  : Container()
            ],
          ),
        ),
      )),
    );
  }
}

Route _createRoute(verId, smsCode) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        CodeSent(verId, smsCode),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
