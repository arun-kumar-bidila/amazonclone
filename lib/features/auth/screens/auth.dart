import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/userService.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _namecontroller.dispose();
  }

//signupUser
  void signupUser() {
    print("\nfunction called\n");
    authService.signupUser(
        context: context,
        name: _namecontroller.text,
        email: _emailcontroller.text,
        password: _passwordcontroller.text);
    print("\nfunction ended\n");
  }

//signinUser
  void signinUser() {
    authService.signinUser(
        context: context,
        email: _emailcontroller.text,
        password: _passwordcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 22),
            ),
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: Text("Create Account"),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
            ),
            if (_auth == Auth.signup)
              Form(
                  key: _signupFormKey,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _namecontroller,
                          hintText: "Name",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: _emailcontroller,
                          hintText: "Email",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: _passwordcontroller,
                          hintText: "Password",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: "Sign-Up",
                          onTap: () => {
                            if (_signupFormKey.currentState!.validate())
                              {signupUser()}
                          },
                        )
                      ],
                    ),
                  )),
            ListTile(
              tileColor: _auth == Auth.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: Text("Sign In"),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
            ),
            if (_auth == Auth.signin)
              Form(
                  key: _signinFormKey,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _emailcontroller,
                          hintText: "Email",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: _passwordcontroller,
                          hintText: "Password",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: "Sign-In",
                          onTap: () {
                            if (_signinFormKey.currentState!.validate()) {
                              signinUser();
                            }
                          },
                        )
                      ],
                    ),
                  )),
          ],
        ),
      )),
    );
  }
}
