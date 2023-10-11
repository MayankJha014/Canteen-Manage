import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/common/widgets/bottom_bar.dart';
import 'package:zomato_clone/features/admin/screens/admin_screen.dart';
import 'package:zomato_clone/features/auth/screens/auth_screen.dart';
import 'package:zomato_clone/providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Provider.of<UserProvider>(context).user.email.isNotEmpty
                        ? Provider.of<UserProvider>(context).user.type == 'user'
                            ? const BottomBar()
                            : AdminScreen()
                        : const AuthScreen())));
  }

  @override
  Widget build(BuildContext context) {
    initState() {
      Provider.of<UserProvider>(context).user.token;
      setState(() {});
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Lottie.asset(
                "assets/login2.json",
                height: size.height * 0.5,
                width: size.width * 0.8,
              ),
              Text(
                "Powered by Apiero Technica",
                style: TextStyle(
                    fontFamily: "Cinzel",
                    fontSize: size.width * 0.05,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
