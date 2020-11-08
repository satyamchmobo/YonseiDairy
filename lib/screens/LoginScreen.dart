import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_login/form.dart';
import 'package:firebase_user_login/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_user_login/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:country_pickers/country_pickers.dart';

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if(user != null){

 await Firestore.instance.collection('users').document(user.uid).setData({
      'userPhoneNo': phone,
 
    });


           
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => StepperForm(user: user,number: phone,)
            ));
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
      
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                      
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Color(0xfffec321),
                    onPressed: () async{
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

                      AuthResult result = await _auth.signInWithCredential(credential);

                      FirebaseUser user = result.user;

                      if(user != null){

                        await Firestore.instance.collection('users').document(user.uid).setData({
      'userPhoneNo': phone,
 
    });
                        
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => StepperForm(user: user,number: phone,)
                        ));
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }



  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('90');

  Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('90');

  Country _selectedCupertinoCountry =
      CountryPickerUtils.getCountryByIsoCode('tr');

  Country _selectedFilteredCupertinoCountry =
      CountryPickerUtils.getCountryByIsoCode('DE');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // key: loginStore.loginScaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 240,
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                margin: const EdgeInsets.only(top: 100),
                                decoration: const BoxDecoration(
                                    color: Color(0x0000ff00),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                            ),
                            Center(
                              child: Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 340),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Image.asset('images/key.png')),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Phone Login',
                              style: TextStyle(
                                  color: Color(0xfffec321),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800))),


          //                          Card(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Text("CountryPickerDialog (has priorityList['TR,'US'])"),
          //       ListTile(
          //         onTap: _openCountryPickerDialog,
          //         title: _buildDialogItem(_selectedDialogCountry),
          //       ),
          //     ],
          //   ),
          // ),

          
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'We will send you an ',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                  text: 'One Time Password ',
                                  style: TextStyle(
                                      color: Color(0xfffec321),
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: 'on this mobile number',
                                  style: TextStyle(color: Colors.black)),
                            ]),
                          )),
                      Container(
                        height: 40,
                        constraints: const BoxConstraints(maxWidth: 500),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CupertinoTextField(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color:Colors.yellow[100],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4))),
                          controller: _phoneController,
                          clearButtonMode: OverlayVisibilityMode.editing,
                          keyboardType: TextInputType.phone,
                          maxLines: 1,
                          placeholder: '+91...',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: RaisedButton(
                          onPressed: () {

                              final phone = _phoneController.text.trim();

                        loginUser(phone, context);

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => OtpPage()),
                            // );


// final mobile = _phoneController.text.trim();
//                         registerUser(mobile, context);

                            // if (phoneController.text.isNotEmpty) {
                            //   loginStore.getCodeWithPhoneNumber(
                            //       context, phoneController.text.toString());
                            // } else {
                            //   loginStore.loginScaffoldKey.currentState
                            //       .showSnackBar(SnackBar(
                            //     behavior: SnackBarBehavior.floating,
                            //     backgroundColor: Colors.red,
                            //     content: Text(
                            //       'Please enter a phone number',
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //   ));
                            // }
                          },
                          color:  Color(0xfffec321),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color:  Colors.yellow[600],
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }














  
}
