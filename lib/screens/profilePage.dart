import 'package:flutter/material.dart';
import 'package:shared_preference_module/constants/string_constants.dart';
import 'package:shared_preference_module/helper/personDatabaseHelper.dart';
import 'package:shared_preference_module/models/personModel.dart';
import 'package:shared_preference_module/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final List<String> dataList;
  ProfilePage({required this.dataList});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Gender gender = Gender.Female;
  // String _gender = gender == null
  //     ? StringConstant.male
  //     : gender; // Setting up the default value of the gender.

  // DateTime date;

  // Future datePicker() async {
  //   date = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(1970),
  //       lastDate: DateTime(2025));

  // }

  String? name;
  String? email;
  String? phone_number;
  String? gender;
  String? birthdate;
  String? password;

  @override
  void initState() {
    super.initState();

    // Structure of datalist
    //[Jigyasa, jig@gmail.com, 1999-11-14, Female, 9654707498, Abc123##]
    name =
        widget.dataList.length == 0 ? StringConstant.name : widget.dataList[0];
    email =
        widget.dataList.length == 0 ? StringConstant.email : widget.dataList[1];
    gender =
        widget.dataList.length == 0 ? StringConstant.male : widget.dataList[3];
    birthdate =
        widget.dataList.length == 0 ? StringConstant.dob : widget.dataList[2];
    phone_number = widget.dataList.length == 0
        ? StringConstant.phone_number
        : widget.dataList[4];
    password = widget.dataList.length == 0
        ? StringConstant.password
        : widget.dataList[5];
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    TextEditingController passController = new TextEditingController();
    TextEditingController confirmPassController = new TextEditingController();
    TextEditingController phoneController = new TextEditingController();
    DateTime _birthDate;
    // DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(StringConstant.login, false);
                prefs.setString(StringConstant.email, "");

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Icon(
                Icons.logout,
                color: Colors.white,
              )),
          title: Text("Welcome Back! ${name!.split(" ").first}"),
          backgroundColor: Color.fromRGBO(27, 213, 210, 10)),
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(27, 213, 210, 10),
              Color.fromRGBO(27, 213, 210, 15),
              Color.fromRGBO(27, 213, 210, 20),
            ])),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Center(
                    child: Text(name![0].toUpperCase(),
                        style: TextStyle(color: Colors.red, fontSize: 40)),
                  ),
                  //height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(bottom: 10, top: 50),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40))),
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: 10, top: 10, right: 30, left: 30),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            spreadRadius: 5.0,
                            blurRadius: 5.0,
                            color: Colors.blue.shade200.withOpacity(0.5),
                            offset: Offset(0, 3),
                          )
                        ]),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              )),
                              child: TextFormField(
                                controller: name != null
                                    ? (nameController..text = name!)
                                    : nameController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline),
                                    hintText: name == null
                                        ? StringConstant.name
                                        : name,
                                    hintStyle: TextStyle(color: Colors.black),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                              ),
                            ),

                            Row(
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                ),
                                Text(
                                  "  Gender: ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Radio(
                                    value: StringConstant.male,
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    }),
                                Text(StringConstant.male,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                Radio(
                                    value: StringConstant.female,
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    }),
                                Text(StringConstant.female,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              )),
                              child: TextFormField(
                                //controller: _birthDate,
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: birthdate == null
                                        ? StringConstant.dob
                                        : birthdate,
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon:
                                        Icon(Icons.calendar_today_outlined),
                                    enabledBorder: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              )),
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: email == null
                                        ? StringConstant.email
                                        : email,
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.alternate_email),
                                    enabledBorder: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                              ),
                            ),
                            //SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              )),
                              child: TextFormField(
                                //readOnly: true,
                                controller: phone_number != null
                                    ? (phoneController..text = phone_number!)
                                    : phoneController,
                                decoration: InputDecoration(
                                    hintText: phone_number == null
                                        ? StringConstant.phone_number
                                        : phone_number,
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.phone),
                                    enabledBorder: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                //textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.unfocus(),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              )),
                              child: TextFormField(
                                //readOnly: true,
                                controller: password != null
                                    ? (passController..text = password!)
                                    : passController,
                                decoration: InputDecoration(
                                    hintText: phone_number == null
                                        ? StringConstant.password
                                        : StringConstant.password,
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.lock),
                                    enabledBorder: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0)),
                                //textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.unfocus(),
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            )),
      ),
    );
  }
}
