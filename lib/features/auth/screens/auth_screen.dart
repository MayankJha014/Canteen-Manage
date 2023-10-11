import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lottie/lottie.dart';
import 'package:zomato_clone/common/widgets/custom_button.dart';
import 'package:zomato_clone/common/widgets/custom_textfield.dart';
import 'package:zomato_clone/features/auth/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authservice = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authservice.signUpUser(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    authservice.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 53, 53, 53),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Lottie.asset(
                        "assets/login3.json",
                        height: size.height * 0.35,
                        width: size.width * 0.9,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                Text(
                  "Welcome to Raj Station",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TabBar(
                      unselectedLabelColor: Colors.redAccent,
                      indicatorPadding: EdgeInsets.only(left: 30, right: 30),
                      indicator: ShapeDecoration(
                          color: Colors.redAccent,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.redAccent,
                              ))),
                      tabs: const [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Login"),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("SigIn"),
                          ),
                        ),
                      ]),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 430,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 200.0, left: 10, right: 10, top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2, color: Colors.white30)),
                            padding: const EdgeInsets.all(8.0),
                            // color: Color.fromARGB(255, 230, 230, 230),
                            // color: Color.fromARGB(255, 255, 236, 253),
                            child: Form(
                              key: _signInFormKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      controller: _emailController,
                                      hintText: "Email",
                                    ),
                                    SizedBox(height: 10),
                                    CustomTextField(
                                      controller: _passwordController,
                                      hintText: "Password",
                                    ),
                                    SizedBox(height: 10),
                                    CustomButtom(
                                      text: "LogIn",
                                      color: Colors.black,
                                      onTap: () {
                                        if (_signInFormKey.currentState!
                                            .validate()) {
                                          signInUser();
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 130.0, left: 20, right: 20, top: 7),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2, color: Colors.white30)),
                            padding: const EdgeInsets.all(8.0),
                            // color: Color.fromARGB(255, 252, 238, 245),
                            child: Form(
                              key: _signUpFormKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      controller: _nameController,
                                      hintText: "Name",
                                    ),
                                    SizedBox(height: 10),
                                    CustomTextField(
                                      controller: _emailController,
                                      hintText: "Email",
                                    ),
                                    SizedBox(height: 10),
                                    CustomTextField(
                                      controller: _passwordController,
                                      hintText: "Password",
                                    ),
                                    SizedBox(height: 10),
                                    CustomButtom(
                                        text: "Sign Up",
                                        onTap: () {
                                          if (_signUpFormKey.currentState!
                                              .validate()) {
                                            signUpUser();
                                          }
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Icon(Icons.directions_bike, size: 350),
                      ],
                    ),
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
