import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey.shade200,
      child: Container(
        color: Color.fromARGB(50, 189, 189, 189),
        height: 200,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
