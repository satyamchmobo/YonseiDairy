import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:firebase_user_login/home.dart';

import 'package:flutter/cupertino.dart';

import 'package:language_pickers/languages.dart';
import 'package:language_pickers/language_pickers.dart';

class StepperForm extends StatefulWidget {
  String number;
  FirebaseUser user;
  StepperForm({this.user, this.number});

  @override
  _StepperFormState createState() => _StepperFormState(user1: user,number1:number);
}

class _StepperFormState extends State<StepperForm> {
  String number1;
  FirebaseUser user1;
  _StepperFormState({this.user1,this.number1});
  int _currentStep = 0;
  String curCountry;
  String curState;
  String curCity;
  String curLang;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameControllr = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  List<String> cities = [
    'Bangalore',
    'Chennai',
    'New York',
    'Mumbai',
    'Delhi',
    'Tokyo',
  ];

  List<String> states = [
    'Madhya Pradesh',
    'Maharashtra',
    'Tamil Nadu',
    'Mumbai',
    'Delhi',
    'Tokyo',
  ];

  List<String> countries = [
    'INDIA',
    'USA',
    'JAPAN',
  ];

  Language _selectedDropdownLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('ko');
  Language _selectedDialogLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('ko');
  Language _selectedCupertinoLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('ko');

  // It's sample code of Dropdown Item.
  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }

  // It's sample code of Dialog Item.
  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your language'),
                onValuePicked: (Language language) => setState(() {
                      _selectedDialogLanguage = language;
                      print(_selectedDialogLanguage.name);
                      print(_selectedDialogLanguage.isoCode);
                    }),
                itemBuilder: _buildDialogItem)),
      );

  // It's sample code of Cupertino Item.
  void _openCupertinoLanguagePicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return LanguagePickerCupertino(
          pickerSheetHeight: 200.0,
          onValuePicked: (Language language) => setState(() {
            _selectedCupertinoLanguage = language;
            print(_selectedCupertinoLanguage.name);
            print(_selectedCupertinoLanguage.isoCode);
          }),
        );
      });

  Widget _buildCupertinoItem(Language language) => Row(
        children: <Widget>[
          Text("+${language.name}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(language.name))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "You are Logged in succesfully",
                    style: TextStyle(color: Colors.lightBlue, fontSize: 32),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${user1.phoneNumber}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 9,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Your Profile',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w500))),
            Stepper(
              steps: _stepper(),
              physics: ClampingScrollPhysics(),
              currentStep: this._currentStep,
              onStepTapped: (step) {
                setState(() {
                  this._currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (this._currentStep < this._stepper().length - 1) {
                    this._currentStep = this._currentStep + 1;
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (this._currentStep > 0) {
                    this._currentStep = this._currentStep + -1;
                  } else {
                    this._currentStep = 0;
                  }
                });
              },
            ),
            SizedBox(
              height: 60,
            ),
            InkWell(
              onTap: () async {
                await Firestore.instance
                    .collection('users')
                    .document(user1.uid)
                    .setData({
                  'userFirstName': firstNameController.text,
                  'userLastName': lastNameControllr.text,
                  'userEmail': emailController.text,
                  'userCountry': curCountry.toString(),
                  'userState': curState.toString(),
                  'userCity': curCity.toString(),
                  'userZipCode': zipCodeController.text,
                  'userLanguage': curLang,
                  'userPhoneNumber':number1,
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            fireUser: user1,
                          )),
                );
              },
              child: Container(
                height: 45,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x80000000),
                        blurRadius: 30.0,
                        offset: Offset(0.0, 5.0),
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xfffec321),
                        Colors.yellow[500],
                      ],
                    )),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextEditingController countryController = TextEditingController();
  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
          title: Text("Name"),
          content: Column(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: "First Name"),
              ),
              TextFormField(
                controller: lastNameControllr,
                decoration: InputDecoration(labelText: "last Name"),
              ),
            ],
          ),
          isActive: _currentStep >= 0,
          state: StepState.complete),
      Step(
          title: Text("Email"),
          content: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email id"),
              )
            ],
          )),
      Step(
          title: Text("Address"),
          content: Column(
            children: [
              DropDownField(
                  controller: countryController,
                  onValueChanged: (value) {
                    setState(() {
                      curCountry = value;
                      print(curCountry);
                    });
                  },
                  value: curCountry,
                  icon: Icon(Icons.map),
                  //required: true,
                  hintText: 'Choose a country',
                  labelText: 'Country',
                  items: countries,
                  setter: (newValue) {
                    curCountry = newValue;
                    print(newValue);
                    print(countryController.text);
                  }),
              SizedBox(
                height: 11,
              ),
              DropDownField(
                  value: curState,
                  onValueChanged: (value) {
                    setState(() {
                      curState = value;
                      print(curState);
                    });
                  },
                  //required: true,
                  // strict: true,
                  hintText: 'Choose a state',
                  labelText: 'State',
                  icon: Icon(Icons.account_balance),
                  items: states,
                  setter: (newValue) {
                    curState = newValue;
                  }),
              SizedBox(
                height: 11,
              ),
              DropDownField(
                  value: curCity,
                  onValueChanged: (value) {
                    setState(() {
                      curCity = value;
                      print(curCity);
                    });
                  },
                  // required: true,
                  // strict: true,
                  hintText: 'Choose a city',
                  labelText: 'City',
                  icon: Icon(Icons.account_balance),
                  items: cities,
                  setter: (dynamic newValue) {
                    curCity = newValue;
                  }),
              Container(
                width: 240,
                child: Row(
                  children: [
                    Flexible(
                        child: Icon(
                      Icons.gps_fixed,
                      color: Colors.blue,
                    )),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: zipCodeController,
                        decoration: InputDecoration(
                          labelText: "Zip Code",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 11,
              ),
            ],
          )),
      Step(
          title: Text("Language"),
          content: Column(
            children: [
              LanguagePickerDropdown(
                initialValue: 'en',
                itemBuilder: _buildDropdownItem,
                onValuePicked: (Language language) {
                  _selectedDropdownLanguage = language;
                  setState(() {
                    curLang = _selectedCupertinoLanguage.name;
                  });
                  print(_selectedDropdownLanguage.name);
                  print("=============>>>>>>>>>>>>");
                  print(_selectedDropdownLanguage.isoCode);
                },
              ),

              // Expanded(
              //   child: Center(
              //     child: MaterialButton(
              //       child: Text("Push"),
              //       onPressed: _openLanguagePickerDialog,
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: Center(
              //     child: ListTile(
              //       title: _buildCupertinoItem(_selectedCupertinoLanguage),
              //       onTap: _openCupertinoLanguagePicker,
              //     ),
              //   ),
              // ),
            ],
          )),
    ];
    return _steps;
  }
}
