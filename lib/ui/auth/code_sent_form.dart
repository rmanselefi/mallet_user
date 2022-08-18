import 'package:flutter/material.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeSent extends StatefulWidget {
  final verid;
  var smscode;
  CodeSent(this.verid, this.smscode);

  @override
  _CodeSentState createState() => _CodeSentState();
}

class _CodeSentState extends State<CodeSent> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 25.0),
              height: 200.0,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Please Enter Sms Code sent to you',
                      style: TextStyle(color: Colors.blue.withOpacity(0.8)),
                    ),
                  ),
                  Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/vericon.png'),
                            fit: BoxFit.contain)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 500.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                )),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          PinCodeTextField(
                            appContext: context,
                            length: 6,
                            animationType: AnimationType.slide,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                widget.smscode = value;
                              });
                            },
                            onCompleted: (value) {
                              setState(() {
                                widget.smscode = value;
                              });

                              print(
                                  "thisthisthisthisthisthisthis ${widget.smscode}");
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ScopedModelDescendant<MainModel>(builder:
                              (BuildContext context, Widget child,
                                  MainModel model) {
                            return RaisedButton(
                              child: Icon(Icons.send),
                              color: Colors.blue.withOpacity(0.8),
                              onPressed: () async {
                                print(
                                    "this.widget.smscodethis.widget.smscodethis.widget.smscode ${this.widget.smscode}");
                                if (!_formKey1.currentState!.validate()) {
                                  return;
                                }
                                _formKey1.currentState!.save();
                                // Map<String, dynamic> successInfo =
                                // await model.signInWithPhone(
                                //     this.widget.verid, this.widget.smscode);
                                // print(successInfo);
                                // if (successInfo['success']) {
                                //   Navigator.of(context).pop();
                                //   Navigator.of(context)
                                //       .pushReplacementNamed('/home');
                                // }
                              },
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
