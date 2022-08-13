import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rhrs_app/models/profile.dart';
import 'package:rhrs_app/widgets/custom_button.dart';
import 'package:rhrs_app/constants.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit_profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final inputBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(15));
  String email, name, phone, gender, age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Info'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16,horizontal: 12),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 4,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration:
                        InputDecoration(border: inputBorder, labelText: 'Name'),
                    onSaved: (value) {
                      name = value;
                    },
                  ),
                  SIZED_BOX_H12,
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      decoration: InputDecoration(
                          border: inputBorder, labelText: 'E-mail'),
                      onSaved: (value) {
                        email = value;
                      }),
                  SIZED_BOX_H12,
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: inputBorder, labelText: 'Phone'),
                      onSaved: (value) {
                        phone = value;
                      }),
                  SIZED_BOX_H12,
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      decoration: InputDecoration(
                          border: inputBorder, labelText: 'Gender'),
                      onSaved: (value) {
                        gender = value;
                      }),
                  SIZED_BOX_H12,
                  TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: inputBorder, labelText: 'Age'),
                      onSaved: (value) {
                        age = value;
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    buttonLabel: 'Submit',
                    onPress: () async{
                      _formKey.currentState.save();
                      print("name");
                      print(name);
                      print("email");
                      print(email);
                      print("phone");
                      print(phone);
                      await Provider.of<Profile>(context,listen: false).updateProfile(name, email, phone).then((value) => Navigator.pop(context));
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
